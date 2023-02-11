local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local c = ls.choice_node
local d = ls.dynamic_node
local t = ls.text_node
local i = ls.insert_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt -- fmt(<fmt_string>, {...nodes})

ls.cleanup()

local function no_restore(args, _)
    return sn(nil, { i(1, args[1]), t("  |  "), i(2, "user_text") })
end

local function simple_restore2(args, _)
    return sn(nil, { i(1, args[1]), t("  |  "), r(2, "dyn", i(nil, args[1])) })
end

ls.add_snippets("all", {
    s("norest", {
        i(1, "preset"),
        t({ "", "" }),
        d(2, no_restore, 1),
    }),
    s("rest", {
        i(1, "preset"),
        t({ "", "" }),
        d(2, simple_restore2, 1),
    }),
    s("trig", {
        c(1, {
            t("Ugh boring, a text node"),
            t("Foo"),
            t("Bar"),
        }, {}),
    }),
})

-- see latex infinite list for the idea. Allows to keep adding arguments via choice nodes.
local function py_init()
    return sn(
        nil,
        c(1, {
            t(""),
            sn(1, {
                t(", "),
                i(1),
                d(2, py_init),
            }),
        })
    )
end

-- splits the string of the comma separated argument list into the arguments
-- and returns the text-/insert- or restore-nodes
local function to_init_assign(args)
    local tab = {}
    local a = args[1][1]
    if #a == 0 then
        table.insert(tab, t({ "", "\tpass" }))
    else
        local cnt = 1
        for e in string.gmatch(a, " ?([^,]*) ?") do
            if #e > 0 then
                table.insert(tab, t({ "", "\tself." }))
                -- use a restore-node to be able to keep the possibly changed attribute name
                -- (otherwise this function would always restore the default, even if the user
                -- changed the name)
                table.insert(tab, i(cnt, e))
                -- table.insert(tab, r(cnt, tostring(cnt), i(nil, e)))
                table.insert(tab, t(" = "))
                table.insert(tab, t(e))
                cnt = cnt + 1
            end
        end
    end
    return sn(nil, tab)
end

-- create the actual snippet
ls.add_snippets(
    "all",
    { s(
        "pyinit",
        fmt([[def __init__(self{}):{}]], {
            d(1, py_init),
            d(2, to_init_assign, { 1 }),
        })
    ) }
)
