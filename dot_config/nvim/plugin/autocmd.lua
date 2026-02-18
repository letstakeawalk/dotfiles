local utils = require("utils")

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Resize splits on vim resize",
    group = utils.augroup("ResizeSplits", { clear = true }),
    callback = function()
        vim.cmd.tabdo("wincmd =")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Close buffer with `q`",
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

vim.api.nvim_create_autocmd("BufWinEnter", {
    desc = "Smart window position: Open in vertical if screen is wide enough",
    group = utils.augroup("SmartWinPos", { clear = true }),
    pattern = { "fugitive://*//", "*COMMIT_EDITMSG", "*/doc/*" },
    callback = function(ev)
        local target_fts = { "fugitive", "help", "gitcommit" }
        local ft = vim.bo[ev.buf].filetype
        if not vim.list_contains(target_fts, ft) then
            return
        end
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if ev.buf == vim.api.nvim_win_get_buf(win) then
                local win_w = vim.api.nvim_win_get_width(win)
                local vim_w = vim.o.columns
                if vim_w >= 100 and win_w > math.floor(vim_w / 2) then
                    vim.cmd.wincmd("L")
                elseif win_w < 50 then
                    vim.cmd.wincmd("J")
                end
            end
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Auto create dir when saving a file, in case some intermediate directory does not exist",
    group = utils.augroup("AutoCreateDir", { clear = true }),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Open Oil file explorer if nvim is started with a directory as the argument.",
    group = utils.augroup("VimEnter", { clear = true }),
    callback = function()
        if vim.fn.argc() ~= 1 then
            return
        end
        local dir = vim.fn.argv(0) --[[@as string]]
        if vim.fn.isdirectory(dir) == 1 then
            require("oil").open(dir)
            -- pcall(vim.cmd([[bdelete #]])) -- optional: close the default 'No Name' buffer
        end
    end,
    once = true,
})

local home = os.getenv("HOME") --[[@as string]]
local chezmoi_source = os.getenv("CHEZMOI_SOURCE") --[[@as string]]

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Auto add managed files to chezmoi on save",
    group = utils.augroup("ChezmoiAdd", { clear = true }),
    pattern = {
        string.format("%s/.config/**/*", home),
        string.format("%s/.local/script/*", home),
        string.format("%s/.claude/skills/**/*", home),
        string.format("%s/.claude/rules/**/*", home),
        string.format("%s/.claude/agents/**/*", home),
        string.format("%s/.claude/hooks/**/*", home),
    },
    callback = function(args)
        if args.file:match("COMMIT_EDITMSG$") or args.file:match("git-rebase-merge$") then
            return
        end
        local fname = args.match:gsub(home, "~")
        local is_managed = #vim.fn.system({ "chezmoi", "managed", args.match }) ~= 0

        local function chezmoi_add()
            local result = vim.fn.system({ "chezmoi", "add", args.match })
            if vim.v.shell_error == 0 then
                vim.notify(fname, vim.log.levels.INFO, { key = "Chezmoi", annote = "Chezmoi added" })
            else
                vim.notify(result, vim.log.levels.ERROR, { key = "Chezmoi", annote = "Chezmoi add failed" })
            end
        end

        if is_managed then
            chezmoi_add()
        else
            vim.ui.input({
                prompt = string.format("Do you want to add `%s` to chezmoi? [Y/n] ", fname),
            }, function(input)
                if input and vim.trim(input) == "Y" then
                    chezmoi_add()
                else
                    vim.notify(fname, vim.log.levels.INFO, { key = "Chezmoi", annote = "Chezmoi add skipped" })
                end
            end)
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Auto apply chezmoi source to target on save",
    group = utils.augroup("ChezmoiApply", { clear = true }),
    pattern = string.format("%s/**/*", chezmoi_source),
    callback = function(args)
        local excluded_filetypes = { "gitcommit", "gitrebase" }
        if vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
            return
        end
        local result = vim.fn.system({ "chezmoi", "apply", "--source-path", args.match })
        if vim.v.shell_error == 0 then
            local fname = args.match:gsub(chezmoi_source .. "/", "")
            vim.notify(fname, vim.log.levels.INFO, { key = "Chezmoi", annote = "Chezmoi applied" })
        else
            vim.notify(result, vim.log.levels.ERROR, { key = "Chezmoi", annote = "Chezmoi apply failed" })
        end
    end,
})
