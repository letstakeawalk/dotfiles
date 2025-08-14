---@diagnostic disable: unused-local
local ls = require("luasnip")
local types = require("luasnip.util.types")
local s = ls.snippet -- s(<trigger>, <nodes>)
local sn = ls.snippet_node
local c = ls.choice_node
local i = ls.insert_node -- i(<position>, [default_text])
local t = ls.text_node
local f = ls.function_node -- f(fn, argnode_ref, [args]) fn(argnode_txt, parent, user_args)
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt -- fmt(<fmt_string>, {...nodes})
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep -- rep(<position>)
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local function from_today(format, days)
    return os.date(format, os.time() + days * 24 * 60 * 60)
end

return {
    -- Current date & time. MM/DD/YY HH:MM
    s(
        "now",
        c(1, {
            p(os.date, "%Y.%m.%d %H:%M"),
            p(os.date, "%Y-%m-%d %H:%M"),
            p(os.date, "%Y/%m/%d %H:%M"),
        })
    ),
    s(
        "today",
        c(1, {
            p(os.date, "%Y.%m.%d.%a"),
            p(os.date, "%Y.%m.%d"),
            p(os.date, "%Y-%m-%d-%a"),
            p(os.date, "%Y-%m-%d"),
            p(os.date, "%A, %B %d, %Y"),
        })
    ),
    s(
        "yesterday",
        c(1, {
            p(from_today, "%Y.%m.%d.%a", -1),
            p(from_today, "%Y.%m.%d", -1),
            p(from_today, "%Y-%m-%d-%a", -1),
            p(from_today, "%Y-%m-%d", -1),
            p(from_today, "%A, %B %d, %Y", -1),
        })
    ),
    s(
        "tomorrow",
        c(1, {
            p(from_today, "%Y.%m.%d.%a", 1),
            p(from_today, "%Y.%m.%d", 1),
            p(from_today, "%Y-%m-%d-%a", 1),
            p(from_today, "%Y-%m-%d", 1),
            p(from_today, "%A, %B %d, %Y", 1),
        })
    ),
    s(
        "nextweek",
        c(1, {
            p(from_today, "%Y.%m.%d.%a", 7),
            p(from_today, "%Y.%m.%d", 7),
            p(from_today, "%Y-%m-%d-%a", 7),
            p(from_today, "%Y-%m-%d", 7),
            p(from_today, "%A, %B %d, %Y", 7),
        })
    ),
    s(
        "lastweek",
        c(1, {
            p(from_today, "%Y.%m.%d.%a", -7),
            p(from_today, "%Y.%m.%d", -7),
            p(from_today, "%Y-%m-%d-%a", -7),
            p(from_today, "%Y-%m-%d", -7),
            p(from_today, "%A, %B %d, %Y", -7),
        })
    ),
}

-- TODO: todo comments
-- https://github.com/L3MON4D3/LuaSnip/wiki/Cool-Snippets#all---todo-commentsnvim-snippets
