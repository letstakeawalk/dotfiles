local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- path to lazy specs
    { import = "plugins" },
    { import = "plugins.coding" }, -- coding essentials
    { import = "plugins.language_servers" }, -- language servers
    -- { import = "plugins.debug" }, -- debuging tool
    { import = "plugins.ui" }, -- ui
    { import = "plugins.ui-enhancers" }, -- ui enhancers
    { import = "plugins.utils" }, -- utility plugins
}, {
    -- lazy config
    defaults = { lazy = true },
    dev = {
        -- directory where you store your local plugin projects
        path = "~/Workspace/dev/opensrc",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {}, -- For example {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
    },
    ui = { border = "double" },
    install = { colorscheme = { "nord", "habamax" } },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "zipPlugin",
                "matchit",
                -- "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
            },
        },
    },
    change_detection = { notify = false },
})

vim.api.nvim_set_keymap("n", "<leader>iz", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.api.nvim_set_hl(0, "LazyButtonActive", { link = "LazyH1" })
