return {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
        { "<C-a>",  "<Plug>(dial-increment)", mode = "n", desc = "Increment" },
        { "<C-x>",  "<Plug>(dial-decrement)", mode = "n", desc = "Decrement" },
        { "<C-a>",  "<Plug>(dial-increment)", mode = "v", desc = "Increment" },
        { "<C-x>",  "<Plug>(dial-decrement)", mode = "v", desc = "Decrement" },
        { "g<C-a>", "<Plug>(dial-increment)", mode = "n", desc = "Increment" },
        { "g<C-x>", "<Plug>(dial-decrement)", mode = "n", desc = "Decrement" },
        { "g<C-a>", "<Plug>(dial-increment)", mode = "v", desc = "Increment" },
        { "g<C-x>", "<Plug>(dial-decrement)", mode = "v", desc = "Decrement" },
    },
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group({
            default = {
                augend.integer.alias.decimal, -- nonnegative decimal number
                augend.integer.alias.hex, -- nonnegative hex number
                augend.integer.alias.octal,
                augend.integer.alias.binary,
                augend.date.alias["%Y/%m/%d"],
                augend.date.alias["%Y-%m-%d"],
                augend.date.alias["%H:%M"],
                augend.date.new({
                    pattern = "%Y.%m.%d",
                    default_kind = "day",
                    only_valid = true,
                    word = false,
                }),
                augend.date.new({
                    pattern = "%a",
                    default_kind = "day",
                    only_valid = true,
                    word = false,
                }),
                augend.date.new({
                    pattern = "%A",
                    default_kind = "day",
                    only_valid = true,
                    word = false,
                }),
                augend.semver.alias.semver,
            },
        })
    end,
}
