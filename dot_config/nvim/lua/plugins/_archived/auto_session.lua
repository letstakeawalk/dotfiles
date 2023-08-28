-- TODO: remove
return {
    "rmagatti/auto-session",
    enabled = false,
    cmd = { "SessionSave", "SessionRestore", "SessionDelete", "Autosession" },
    keys = {
        { "<leader>ss", ":SessionSave<CR>", desc = "Save session" },
        { "<leader>sr", ":SessionRestore<CR>", desc = "Restore session" },
        { "<leader>sd", ":SessionDelete<CR>", desc = "Delete session" },
        { "<leader>sa", ":Autosession search<CR>", desc = "Search session" },
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("auto-session").setup({
            log_level = "info",
            auto_session_enable_last_session = false,
            auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
            auto_session_enabled = true,
            auto_session_create_enabled = true,
            auto_save_enabled = true,
            auto_restore_enabled = true,
            auto_session_suppress_dirs = nil,
            -- auto_session_allowed_dirs = { "~/Workspace/Projects/*", "$CHEZMOI_SOURCE", "~/.local/share/chezmoi/dot_config/nvim" },
            auto_session_use_git_branch = nil,
            -- the configs below are lua only
            bypass_session_save_file_types = nil,
        })
    end,
}
