vim.pack.add({
    "gh:j-hui/fidget.nvim",
    "gh:nvim-telescope/telescope.nvim",
})

require("fidget").setup({
    notification = {
        override_vim_notify = true,
        window = { winblend = 0, border = "single", x_padding = 0 },
    },
})

require("telescope").load_extension("fidget")

local set = require("utils.keymap").set
set("n", "<leader>tn", "<cmd>Telescope fidget<cr>", { desc = "Fidget history" })
set("n", "<leader>dN", "<cmd>Fidget history<cr>", { desc = "Fidget history" })
