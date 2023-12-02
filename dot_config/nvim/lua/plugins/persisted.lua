return {
    "olimorris/persisted.nvim",
    event = "VimEnter",
    keys = {
        { "<leader>st", "<cmd>Telescope persisted<cr>", desc = "Search sessions" },
        { "<leader>sl", "<cmd>SessionLoad<cr>", desc = "Load session" },
        { "<leader>sd", "<cmd>SessionDelete<cr>", desc = "Delete session" },
        { "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save session" },
    },
    cmd = {
        "SessionToggle", -- determines whether to load, start, or stop a session
        "SessionStart", -- start recording a session. Useful if `autosave = false`
        "SessionStop", -- stop recording a session
        "SessionSave", -- save the current session
        "SessionLoad", -- load the session for the current dir and branch (if git_use_branch = true)
        "SessionLoadLast", -- load the most recent session
        "SessionDelete", -- delete current session
    },
    init = function()
        vim.o.sessionoptions = "buffers,curdir,folds,winsize,winpos"
        local augroup = vim.api.nvim_create_augroup("PersistedHooks", {})
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "PersistedTelescopeLoadPre",
            group = augroup,
            callback = function()
                -- save currently loaded session
                require("persisted").save({ session = vim.g.persisted_loaded_session })
                -- delete all buffers
                ---@diagnostic disable-next-line: param-type-mismatch
                pcall(vim.cmd, "%bd!")
                -- NOTE: perhaps quit language servers?
            end,
        })
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "PersistedTelescopeLoadPost",
            group = augroup,
            callback = function()
                vim.g.persisting = true -- autosave loaded session
            end,
        })
    end,
    opts = {
        save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
        silent = false, -- silent nvim message when sourcing session file
        use_git_branch = true, -- create session files based on the branch of the git enabled repository
        autosave = true, -- automatically save session files when exiting Neovim
        -- function to determine if a session should be autosaved
        should_autosave = function()
            local filter = { "alpha", "NvimTree", "help", "fugitive", "oil", "aerial" }
            return not vim.tbl_contains(filter, vim.bo.filetype)
        end,
        autoload = true, -- automatically load the session for the cwd on Neovim startup
        -- function to run when `autoload = true` but there is no session to load
        on_autoload_no_session = function() vim.notify("No session found for the current directory", vim.log.levels.WARN) end,
        follow_cwd = true, -- change session file name to match current working directory if it changes
        -- table of dirs that the plugin will auto-save and auto-load from
        allowed_dirs = {
            "~/Workspace/Dev",
            "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes", -- obsidian vault
            "~/.local/share/chezmoi", -- dotfiles
        },
        -- table of dirs that are ignored when auto-saving and auto-loading
        -- ignored_dirs = { "~/.config", },
        telescope = { -- options for the telescope extension
            reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
        },
    },
}
