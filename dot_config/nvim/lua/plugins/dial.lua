return {
    "monaqa/dial.nvim",
    keys = {
        { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
        { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Increment" },
        { "<C-a>", function() return require("dial.map").inc_visual() end, mode = "v", expr = true, desc = "Increment" },
        { "<C-x>", function() return require("dial.map").dec_visual() end, mode = "v", expr = true, desc = "Increment" },
        { "g<C-a>", function() return require("dial.map").inc_gvisual() end, mode = "v", expr = true, desc = "Increment" },
        { "g<C-x>", function() return require("dial.map").dec_gvisual() end, mode = "v", expr = true, desc = "Increment" },
    },
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group({
            augend.integer.alias.decimal, -- nonnegative decimal number
            augend.integer.alias.hex, -- nonnegative hex number
            augend.integer.alias.octal,
            augend.integer.alias.binary,
            -- date (2022/02/19, etc.)
            augend.date.new({
                pattern = "%Y/%m/%d",
                default_kind = "day",
            }),
            augend.date.new({
                pattern = "%Y-%m-%d",
                default_kind = "day",
            }),
            augend.date.new({
                pattern = "%m/%d",
                default_kind = "day",
                only_valid = true,
            }),
            augend.date.new({
                pattern = "%H:%M",
                default_kind = "day",
                only_valid = true,
            }),
            augend.semver,
        })
    end,
}
