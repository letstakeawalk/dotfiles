return {
    "nvim-focus/focus.nvim",
    event = "VeryLazy",
    keys = { { "<leader>df", "<cmd>FocusToggle<cr>", desc = "Focus Toggle" } },
    opts = {
        ui = {
            signcolumn = false,
            cursorline = false,
        },
        autoresize = {
            height_quickfix = 10, -- Set the height of quickfix panel
        },
    },
    config = function(_, opts)
        require("focus").setup(opts)

        local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

        local ignore_filetypes = { "qf", "undotree", "aerial", "diff" }
        local ignore_buftypes = { "nofile", "prompt", "popup", "quickfix" }

        vim.api.nvim_create_autocmd({ "FileType" }, {
            group = augroup,
            -- pattern = ignore_filetypes,
            callback = function(_)
                if
                    vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
                    or vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
                then
                    vim.b.focus_disable = true
                else
                    vim.b.focus_disable = false
                end
            end,
            desc = "Disable focus autoresize for FileType",
        })
    end,
}
