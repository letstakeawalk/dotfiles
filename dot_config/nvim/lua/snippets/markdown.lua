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

local snippets = {
    s("h1", t("# ")),
    s("h2", t("## ")),
    s("h3", t("### ")),
    s("h4", t("#### ")),
    s("h5", t("##### ")),
    s("h6", t("###### ")),
    s("t", t("- [ ] ")),
    s("ul", t("- ")),
    s("ol", t("1. ")),
    s("link", fmt("[{}]({})", { i(1), i(2) })),
    s("code", fmt("```{}```", { i(1, "lang") })),
    -- tags
    s("due", fmta("[due::<>]", { i(1, "YYYY-mm-dd") })),
    s("started", fmta("[started::<>]", { i(1, "YYYY-mm-dd") })),
    s("completed", fmta("[completed::<>]", { i(1, "YYYY-mm-dd") })),
    s("canceled", fmta("[canceled::<>]", { i(1, "YYYY-mm-dd") })),
    s("hold", fmta("[hold::<>]", { i(1, "YYYY-mm-dd") })),
    s("priority", fmta("[priority::<>]", { i(1, "1") })),
    s("project", fmta("[project::<>]", { i(1, "YYYY-mm-dd") })),
    -- frontmatter
    s(
        "fm",
        c(1, {
            fmt(
                [[
                ---
                aliases: {}
                tags: {}
                ---
                
                ]],
                {
                    i(1, "aliases"),
                    i(2, "tags"),
                }
            ),
            fmt(
                [[
                ---
                aliases: {}
                tags: {}
                project: {}
                status: {}

                ---
                ]],
                {
                    i(1, "aliases"),
                    i(2, "tags"),
                    i(3, "project"),
                    c(4, {
                        t("draft"),
                        t("wip"),
                        t("complete"),
                        t("idle"),
                        t("dropped"),
                    }),
                }
            ),
            fmt(
                [[
                ---
                project: {}
                status: {}

                ---
                ]],
                {
                    i(1, "project"),
                    c(2, {
                        t("draft"),
                        t("wip"),
                        t("complete"),
                        t("idle"),
                        t("dropped"),
                    }),
                }
            ),
        })
    ),
}

return snippets
