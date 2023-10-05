return {
    "tpope/vim-dadbod",
    dependencies = {
        "kristijanhusak/vim-dadbod-ui",
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "plsql", "mysql" } },
    },
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
        { "<leader>db", "<cmd>DBUI<cr>", desc = "DBUI" },
    },
    config = function()
        -- DBUI
        vim.g.db_ui_use_nerd_fonts = 1

        -- DB completion
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("DadbodCompletion"),
            pattern = { "sql", "mysql", "plsql" },
            callback = function()
                require("cmp").setup.buffer({
                    sources = {
                        { name = "vim-dadbod-completion" },
                    },
                })
            end,
        })
    end,
}
