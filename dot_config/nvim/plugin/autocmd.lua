local utils = require("utils")

-- resize splits on vim resize
---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd("VimResized", {
    group = utils.augroup("ResizeSplits", { clear = true }),
    callback = function()
        vim.cmd.tabdo("wincmd =")
    end,
})

-- close buffer with `q`
vim.api.nvim_create_autocmd("FileType", {
    group = utils.augroup("EasyClose", { clear = true }),
    pattern = {
        -- "git",
        "gitsigns-blame",
        "fugitive",
        "qf",
        "help",
        "man",
        "query",
        "harpoon",
    },
    callback = function(ev)
        vim.keymap.set("n", "q", "<cmd>bwipe<cr>", { buffer = ev.buf, silent = true })
    end,
})

-- Auto create dir when saving a file,
-- in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
    group = utils.augroup("AutoCreateDir", { clear = true }),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Open Oil file explorer if nvim is started with a directory as the argument.",
    group = utils.augroup("VimEnter", { clear = true }),
    callback = function()
        ---@diagnostic disable-next-line: assign-type-mismatch
        local dir = vim.fn.argv(0) ---@type string
        if dir and vim.fn.isdirectory(dir) == 1 then
            require("oil").open(dir)
            -- pcall(vim.cmd([[bdelete #]])) -- optional: close the default 'No Name' buffer
        end
    end,
    once = true,
})

-- Chezmoi: auto add config files to chezmoi source
vim.api.nvim_create_autocmd("BufWritePost", {
    group = utils.augroup("ChezmoiAdd", { clear = true }),
    pattern = {
        string.format("%s/*", os.getenv("XDG_CONFIG_HOME")),
    },
    ---@param args { buf: integer, file: string, match: string }
    callback = function(args)
        if args.file:gmatch("COMMIT_EDITMSG$") or args.file:gmatch("git-rebase-merge$") then
            return
        end
        local fname = args.match:gsub(os.getenv("HOME") or "", "~")
        local managed = #vim.fn.system({ "chezmoi", "managed", args.match }) ~= 0
        if not managed then
            vim.ui.input({
                prompt = string.format("Do you want to add `%s` to chezmoi? [Y/n] ", fname),
            }, function(input)
                if input and vim.trim(input) == "Y" then
                    managed = true
                end
            end)
        end
        if managed then
            local result = vim.fn.system({ "chezmoi", "add", args.match })
            if vim.v.shell_error == 0 then
                vim.notify(fname, vim.log.levels.INFO, { key = "Chezmoi", annote = "Chezmoi added" })
            else
                vim.notify(result, vim.log.levels.ERROR, { key = "Chezmoi", annote = "Chezmoi add failed" })
            end
        else
            vim.notify(fname, vim.log.levels.INFO, { key = "Chezmoi", annote = "Chezmoi add skipped" })
        end
    end,
})

-- Chezmoi: auto apply config files to target path
vim.api.nvim_create_autocmd("BufWritePost", {
    group = utils.augroup("ChezmoiApply", { clear = true }),
    pattern = string.format("%s/**/*", os.getenv("CHEZMOI_SOURCE")),
    ---@param args { buf: integer, file: string, match: string }
    callback = function(args)
        local excluded_filetypes = { "gitcommit", "gitrebase" }
        if vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
            return
        end
        local result = vim.fn.system({ "chezmoi", "apply", "--source-path", args.match })
        if vim.v.shell_error == 0 then
            local fname = args.match:gsub(os.getenv("CHEZMOI_SOURCE") .. "/" or "", "")
            vim.notify(fname, vim.log.levels.INFO, { key = "Chezmoi", annote = "Chezmoi applied" })
        else
            vim.notify(result, vim.log.levels.ERROR, { key = "Chezmoi", annote = "Chezmoi apply failed" })
        end
    end,
})
