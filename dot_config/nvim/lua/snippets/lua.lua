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

return {
    s(
        "req",
        fmt([[local {} = require("{}")]], {
            f(function(args)
                local parts = vim.split(args[1][1], ".", { plain = true, trimempty = true })
                return parts[#parts] or ""
            end, { 1 }),
            i(1, "plugin"),
        })
    ),
    s(
        "print",
        fmt([[vim.print("{}=", {})]], { f(function(args)
            return args[1]
        end, 1), i(1, "variable") })
    ),
    s("si", t("-- stylua: ignore")),
    s("sis", t("-- stylua: ignore start")),
    s("sie", t("-- stylua: ignore end")),
}
