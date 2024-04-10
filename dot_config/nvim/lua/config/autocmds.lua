local augroup = function(name)
    return vim.api.nvim_create_augroup("Cstm" .. name, { clear = true })
end

-- format options (override default options set by ftplugin)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "rust", "python", "lua" },
    group = augroup("FormatOptions"),
    callback = function()
        vim.bo.formatoptions = "cqlj"
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("ResizeSplits"),
    callback = function()
        vim.cmd.tabdo("wincmd =")
    end,
})

-- close some filetypes with `q`
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("CloseQ"),
    pattern = {
        "git",
        "fugitive",
        "qf",
        "help",
        "man",
        "query", -- tree-sitter playground
        "lspinfo",
        "startuptime",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>bwipe<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("AutoCreateDir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Tab configuration
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("TabTwo"),
    pattern = { "json", "yaml", "css" }, -- { "html", "typescript", "javascript", "svelte", "vue" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- Chezmoi: auto add config files to chezmoi source
vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup("ChezmoiAdd"),
    pattern = { vim.env.XDG_CONFIG_HOME .. "/**/*" },
    ---@param ev { file: string, match: string }
    callback = function(ev)
        local result = vim.fn.system({ "chezmoi", "add", ev.match })
        if vim.v.shell_error == 0 then
            vim.notify("Chezmoi added: " .. ev.file)
        else
            vim.notify("Chezmoi add failed: " .. result, vim.log.levels.WARN)
        end
    end,
})

-- Chezmoi: auto apply config files to target path
vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup("ChezmoiApply"),
    pattern = { vim.env.CHEZMOI_SOURCE .. "/**/*" },
    ---@param ev { file: string, match: string }
    callback = function(ev)
        if vim.bo.filetype == "gitcommit" or vim.bo.filetype == "gitrebase" then
            return
        end
        local result = vim.fn.system({ "chezmoi", "apply", "--source-path", ev.match })
        if vim.v.shell_error == 0 then
            vim.notify("Chezmoi applied: " .. ev.file)
        else
            vim.notify("Chezmoi apply failed: " .. result, vim.log.levels.WARN)
        end
    end,
})
