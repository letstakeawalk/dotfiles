--[[
-- Setup initial configuration,
-- 
-- Primarily just download and execute lazy.nvim
--]]
vim.g.mapleader = " "
vim.cmd.colorscheme("nord")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up lazy, and load my `lua/plugins/` folder
require("lazy").setup({ import = "plugins" }, {
    defaults = { lazy = true },
    dev = {
        ---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
        path = "$WORKSPACE/projects",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {}, -- For example, {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
    },
    ui = {
        border = "double",
        custom_keys = {},
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "zipPlugin",
                "tarPlugin",
                "netrwPlugin",
                "tohtml",
                "tutor",
                -- "matchit",
                -- "matchparen",
            },
        },
    },
    change_detection = { notify = false },
})

vim.keymap.set("n", "<leader>iz", "<cmd>Lazy<cr>", { desc = "Lazy Info" })

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.omni_sql_no_default_maps = 1

-- checkout rocks.nvim for plugin management -- https://github.com/nvim-neorocks/rocks.nvim
