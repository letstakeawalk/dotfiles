return {
    "rmagatti/auto-session",
    event = "VimEnter",
    keys = {
        { "<leader>st", "<cmd>Telescope session-lens<cr>", desc = "Search sessions" },
        { "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save session" },
        { "<leader>sr", "<cmd>SessionRestore<cr>", desc = "Restore session" },
        { "<leader>sd", "<cmd>SessionDelete<cr>", desc = "Delete session" },
    },
    init = function() vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions" end,
    opts = {
        log_level = "error", -- 'debug', 'info', 'error'
        auto_session_enable_last_session = false, -- auto load last session if no session found in cwd
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true, -- auto save/restore
        auto_session_create_enabled = true, -- session auto creation
        auto_save_enabled = true, -- true false nil -- auto save current session
        auto_restore_enabled = true, -- true false nil -- auto restore last session of cwd
        auto_session_suppress_dirs = nil,
        auto_session_allowed_dirs = {
            "~/Workspace/Dev/*",
            "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes", -- obsidian vault
            "~/.local/share/chezmoi/*", -- dotfiles
        },
        auto_session_use_git_branch = false, -- true false nil -- use git branch to differentiate sessions
        bypass_session_save_file_types = nil, -- table: Bypass auto save when only buffer open is one of these file types
        session_lens = {
            buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
            load_on_setup = true, -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
            theme_conf = { border = true, winblend = 0 },
            previewer = false,
        },
        -- Already set as default. No need to set again.
        -- cwd_change_handling = { -- Config for handling the DirChangePre and DirChanged autocmds, can be set to nil to disable altogether
        --     restore_upcoming_session = true, -- boolean: restore session for upcoming cwd on cwd change
        --     pre_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChangedPre` autocmd
        --     post_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChanged` autocmd
        -- },
    },
}
