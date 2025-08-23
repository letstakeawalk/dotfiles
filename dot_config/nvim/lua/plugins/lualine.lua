return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "ThePrimeagen/harpoon",
    },
    event = "VeryLazy",
    config = function()
        require("config.lualine")
    end,
}
