return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
    keys = {
        { "<leader>rd", function() require("neogen").generate({}) end, desc = "Generate annotation" },
        { "<M-d>", function() require("neogen").generate({}) end, desc = "Generate annotation", mode = "i" },
    },
    opts = { snippet_engine = "luasnip" },
}
