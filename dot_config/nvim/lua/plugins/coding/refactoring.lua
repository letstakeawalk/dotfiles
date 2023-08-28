return {
    "ThePrimeagen/refactoring.nvim", -- refactoring library
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    config = true,
}
