vim.pack.add({ "gh:monaqa/dial.nvim" })

local set = require("utils.keymap").set
set(
    "n",
    "<C-a>",
    function() require("dial.map").manipulate("increment", "normal") end,
    { desc = "Increment" }
)
set(
    "n",
    "<C-x>",
    function() require("dial.map").manipulate("decrement", "normal") end,
    { desc = "Decrement" }
)
set(
    "n",
    "g<C-a>",
    function() require("dial.map").manipulate("increment", "gnormal") end,
    { desc = "Increment" }
)
set(
    "n",
    "g<C-x>",
    function() require("dial.map").manipulate("decrement", "gnormal") end,
    { desc = "Decrement" }
)
set(
    "v",
    "<C-a>",
    function() require("dial.map").manipulate("increment", "visual") end,
    { desc = "Increment" }
)
set(
    "v",
    "<C-x>",
    function() require("dial.map").manipulate("decrement", "visual") end,
    { desc = "Decrement" }
)
set(
    "v",
    "g<C-a>",
    function() require("dial.map").manipulate("increment", "gvisual") end,
    { desc = "Increment" }
)
set(
    "v",
    "g<C-x>",
    function() require("dial.map").manipulate("decrement", "gvisual") end,
    { desc = "Decrement" }
)

local augend = require("dial.augend")
require("dial.config").augends:register_group({
    default = {
        augend.integer.alias.decimal, -- nonnegative decimal number
        augend.integer.alias.hex, -- nonnegative hex number
        augend.integer.alias.octal,
        augend.integer.alias.binary,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
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
        augend.date.new({
            pattern = "%b",
            default_kind = "day",
            only_valid = true,
            word = false,
        }),
        augend.date.new({
            pattern = "%B",
            default_kind = "day",
            only_valid = true,
            word = false,
        }),
        augend.semver.alias.semver,
    },
})
