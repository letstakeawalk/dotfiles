return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context", -- code context winbar
        "nvim-treesitter/nvim-treesitter-textobjects", -- treesitter module
        "JoosepAlviste/nvim-ts-context-commentstring", -- context commentstring
        -- "RRethy/nvim-treesitter-endwise", -- endwise lua, ruby, etc
        "windwp/nvim-ts-autotag", -- auto closes tags for html, react, etc
    },
    event = { "BufReadPre", "BufNewFile" },
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
        require("config.treesitter")
    end,
}
