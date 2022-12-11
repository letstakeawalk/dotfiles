local ls = require("luasnip")
local types = require("luasnip.util.types")
local s = ls.snippet -- s(<trigger>, <nodes>)
local sn = ls.snippet_node -- sn(jump_idx, nodes, node_opts)
local isn = ls.indent_snippet_node -- isn(jump_idx, nodes, indentstr, node_opts) indentstr = "$PARENT_INDENT"
local c = ls.choice_node -- c(jump_idx, choices, node_opts)
local i = ls.insert_node -- i(position, [default_text])
local t = ls.text_node -- t(text)
local f = ls.function_node -- f(fn, argnode_refs, [{user_args="v"}]) fn(args, parent, user_args)
local d = ls.dynamic_node -- d(jump_idx, fn, node_refs, opts)
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

-- print("python snips loaded")

ls.add_snippets("python", {
	-- class
	s(
		"cla",
		fmt(
			[[class {}({}):
    def __init__(self{}):
        {}{}]],
			{ i(1, "FooBar"), i(2), i(3), i(4, "pass"), i(0) }
		)
	),
	-- dataclass
	s(
		"clad",
		fmt(
			[[@dataclass
class {}:
    {}{}]],
			{ i(1, "FooBar"), i(2, "pass"), i(0) }
		)
	),
	-- function
	s(
		"def",
		fmt(
			[[def {}({}) -> {}:
    {}{}]],
			{ i(1, "foo_bar"), i(2), i(3, "None"), i(4, "pass"), i(0) }
		)
	),
	-- method
	s(
		"defs",
		fmt(
			[[def {}(self{}) -> {}:
    {}{}]],
			{ i(1, "foo_bar"), i(2), i(3, "None"), i(4, "pass"), i(0) }
		)
	),
	-- async function
	s(
		"adef",
		fmt(
			[[async def {}({}):
    {}{}]],
			{ i(1, "foo_bar"), i(2), i(3, "pass"), i(0) }
		)
	),
	-- import ...
	s("im", fmt("import {}", { i(1, "package/module") })),
	-- from ... import ...
	s("fim", fmt("from {} import {}", { i(1, "package/module"), i(2, "name") })),
	-- from ... import ... as ...
	s("fima", fmt("from {} import {} as {}", { i(1, "package/module"), i(2, "name"), i(3) })),
	-- for-loop
	s(
		"for",
		fmt(
			[[for {} in {}:
    {}{}]],
			{ i(1, "elem"), i(2, "iterable"), i(3, "pass"), i(0) }
		)
	),
	-- for-loop in enumerate
	s(
		"fore",
		fmt(
			[[for i, {} in enumerate({}):
    {}{}]],
			{ i(1, "elem"), i(2, "iterable"), i(3, "pass"), i(0) }
		)
	),
	-- for-loop in range
	s(
		"fore",
		fmt(
			[[for i, {} in range({}):
    {}{}]],
			{ i(1, "elem"), i(2, "iterable"), i(3, "pass"), i(0) }
		)
	),
	-- TODO: reST style by Sphinx docstring
	-- http://daouzli.com/blog/docstring.html#formats
	s(
		"cdoc",
		fmt(
			[[
"""{}{}
TC: O({})
SP: O({})
"""{}
]],
			{ p(os.date, "%Y/%m/%d"), i(1), i(2), i(3), i(0) }
		)
	),
	-- disable diagnostic for this file
	s(
		"lintdisable",
		t({
			"# pylint: skip-file",
			"# ruff: noqa",
			"# type: ignore",
		})
	),
})

-------------------------------------------------------------------------------
-- TEST AREA ------------------------------------------------------------------
-------------------------------------------------------------------------------

-- https://github.com/L3MON4D3/LuaSnip/wiki/Cool-Snippets#python---function-definition-with-dynamic-virtual-text
-- Allows to keep adding arguments via choice nodes.
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

local function initialize(args)
	local nodes = {}
	local arg = args[1][1]
	vim.pretty_print(arg)
	if #arg == 0 then
		table.insert(nodes, t({ "", "\tpass" }))
	else
		for e in string.gmatch(a, " ?([^,]*) ?") do
			if #e > 0 then
				local token = vim.split(e, ":")
				local param = token[1]
				local type = token[2] and ":" .. token[2] or ""
				table.insert(nodes, t({ "", "\tself." }))
				table.insert(nodes, i(nil, param))
				-- table.insert(nodes, r(count, tostring(count), i(nil, param)))
				table.insert(nodes, t(type))
				table.insert(nodes, t(" = "))
				table.insert(nodes, t(param))
			end
		end
	end
	return sn(nil, nodes)
end

-- ls.add_snippets("all", {
-- 	s(
-- 		"cinit",
-- 		fmt([[def __init__(self{}):{}]], {
-- 			d(1, py_init),
-- 			d(2, to_init_assign, { 1 }),
-- 		})
-- 	),
-- 	s("init", fmt([[def __init__(self{}):{}]], { i(1), d(2, initialize, { 1 }) })),
-- })
