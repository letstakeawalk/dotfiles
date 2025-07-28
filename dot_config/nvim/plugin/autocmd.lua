local utils = require("utils")

-- resize splits on vim resize
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
        "git",
        "gitsigns-blame",
        "fugitive",
        "qf",
        "help",
        "man",
        "query",
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

-- Tab width: 2
vim.api.nvim_create_autocmd("FileType", {
    group = utils.augroup("TabTwo", { clear = true }),
    pattern = { "json", "yaml", "css" }, -- { "html", "typescript", "javascript", "svelte", "vue" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- Chezmoi: auto add config files to chezmoi source
vim.api.nvim_create_autocmd("BufWritePost", {
    group = utils.augroup("ChezmoiAdd", { clear = true }),
    pattern = {
        string.format("%s/*", os.getenv("XDG_CONFIG_HOME")),
    },
    ---@param ev { buf: integer, file: string, match: string }
    callback = function(ev)
        local fname = string.gsub(ev.match, os.getenv("HOME") or "", "~")
        local managed = #vim.fn.system({ "chezmoi", "managed", ev.match }) ~= 0
        if not managed then
            vim.ui.input({
                prompt = string.format(" Do you want to add %s to chezmoi? [y/n] ", fname),
            }, function(input)
                if input and vim.trim(input) == "y" then
                    managed = true
                end
            end)
        end
        local notify = require("fidget").notify
        if managed then
            local result = vim.fn.system({ "chezmoi", "add", ev.match })
            if vim.v.shell_error == 0 then
                notify(fname, vim.log.levels.INFO, { key = "Chezmoi", annote = "Chezmoi added" })
            else
                notify(result, vim.log.levels.ERROR, { key = "Chezmoi", annote = "Chezmoi add failed" })
            end
        else
            notify(fname, vim.log.levels.INFO, { key = "Chezmoi", annote = "Chezmoi add skipped" })
        end
    end,
})

-- Chezmoi: auto apply config files to target path
vim.api.nvim_create_autocmd("BufWritePost", {
    group = utils.augroup("ChezmoiApply", { clear = true }),
    pattern = string.format("%s/**/*", os.getenv("CHEZMOI_SOURCE")),
    ---@param ev { buf: integer, file: string, match: string }
    callback = function(ev)
        local excluded_fts = { "gitcommit", "gitrebase" }
        if vim.tbl_contains(excluded_fts, vim.bo.filetype) then
            return
        end
        local notify = require("fidget").notify
        local result = vim.fn.system({ "chezmoi", "apply", "--source-path", ev.match })
        if vim.v.shell_error == 0 then
            local fname = string.gsub(ev.match, os.getenv("CHEZMOI_SOURCE") .. "/" or "", "")
            notify(fname, vim.log.levels.INFO, { key = "Chezmoi", annote = "Chezmoi applied" })
        else
            notify(result, vim.log.levels.ERROR, { key = "Chezmoi", annote = "Chezmoi apply failed" })
        end
    end,
})
