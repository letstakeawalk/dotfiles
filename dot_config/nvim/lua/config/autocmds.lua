local augroup = function(name) return vim.api.nvim_create_augroup("Cstm" .. name, { clear = true }) end

-- format options (override default options set by ftplugin)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "rust", "python", "lua" },
    group = augroup("FormatOptions"),
    callback = function()
        -- vim.notify("BufRead FormatOptions", vim.log.levels.WARN)
        vim.bo.formatoptions = "cqlj"
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("ResizeSplits"),
    callback = function() vim.cmd("tabdo wincmd =") end,
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
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- open some filetypes on vertical split
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("VertSplit"),
    pattern = { "help", "fugitive", "git" },
    callback = function()
        vim.cmd("wincmd L")
        -- vim.notify("VertSplit autocmd")
        -- vim.notify("winwidth: " .. vim.fn.winwidth(0))
        -- if vim.fn.winwidth(0) / 2 > 80 then
        --     vim.cmd.wincmd("L")
        -- else
        --     vim.cmd.wincmd("J")
        -- end
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

-- auto add config files to chezmoi source
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

-- auto apply config files to target path
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = augroup("ChezmoiApply"),
    pattern = { vim.env.CHEZMOI_SOURCE .. "/**/*" },
    ---@param ev { file: string, match: string }
    callback = function(ev)
        if vim.bo.filetype == "gitcommit" or vim.bo.filetype == "gitrebase" then
            vim.notify("Git file, not applying")
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

-- Tab configuration
local function set_tabstop(size)
    vim.opt_local.tabstop = size
    vim.opt_local.softtabstop = size
    vim.opt_local.shiftwidth = size
end
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("TabTwo"),
    pattern = { "json", "yaml", "css" }, -- { "html", "typescript", "javascript", "svelte", "vue" },
    callback = function() set_tabstop(2) end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--     group = augroup("Wrap"),
--     pattern = { "markdown" },
--     callback = function() vim.opt_local.wrap = true end,
-- })

-- filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    group = augroup("Markdown"),
    callback = function()
        -- vim.notify("FileType Markdown", vim.log.levels.WARN)
        -- vim.bo.formatoptions = "tcqnlj"
        vim.bo.formatoptions = "tcqj"
        -- vim.wo.wrap = true

        -- task management
        local task = require("utils.task")
        vim.keymap.set("i", "<C-x>", task.toggle_completion, { desc = "Toggle Task", buffer = true })
        -- vim.keymap.set("n", "<leader>nx", task.toggle_task, { desc = "Toggle List/Task", buffer = true })
        vim.keymap.set("n", "<leader>nax", task.toggle_completion, { desc = "Toggle Task", buffer = true })
        vim.keymap.set("n", "<leader>nac", task.toggle_canceled, { desc = "Set Canceled Tag", buffer = true })
        vim.keymap.set("n", "<leader>nas", task.toggle_started, { desc = "Set Started Tag", buffer = true })
        vim.keymap.set("n", "<leader>nad", task.toggle_due, { desc = "Set Due Date", buffer = true })
        vim.keymap.set("n", "<leader>naS", task.toggle_scheduled, { desc = "Set Scheduled Date", buffer = true })
        vim.keymap.set("n", "<leader>nap", task.toggle_priority, { desc = "Set Priority", buffer = true })
        vim.keymap.set("n", "<leader>nar", task.toggle_project, { desc = "Set Project", buffer = true })

        -- TODO: formatlistpattern for lists & tasks
        -- vim.cmd("set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|\\s*[-+*]\\(\\s\\[[^]]\\]\\)\\?\\s\\+")
        -- vim.opt_local.formatlistpat="\\"
        -- vim.cm("set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|\\s*[-+*]\\(\\s\\[[^]]\\]\\)\\?\\s\\+")
        -- ^\\s*\\d\\+\\.\\s\\+
        -- \\|
        -- ^\\s*[-+*]\\s\\+
        -- \\|
        -- ^\\s*[-+*]\\s\\[[^]]\\]
        vim.bo.formatlistpat = [[^\s*\d\+\.\s\+|\s*[-+*]\s\+]]

        -- formatlistpat=
        -- ^\s*\d\+\.\s\+  \|
        -- ^\s*[-*+]\s\+   \|
        -- ^\[^\ze[^\]]\+\]:\&^.\{4\}
    end,
})
vim.api.nvim_create_autocmd("BufRead", {
    group = augroup("Zshrc"),
    pattern = { "dot_zshrc" },
    callback = function() vim.bo.filetype = "zsh" end,
})
