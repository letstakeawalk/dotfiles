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

-- print("snippets loaded")
ls.cleanup()
ls.add_snippets("all", {
	-- Current date & time. MM/DD/YY - HH:MM
	s("currtime", p(os.date, "%Y/%m/%d - %H:%M")),
	s("currdate", p(os.date, "%Y/%m/%d")),
})

-- lua
ls.add_snippets("lua", {
	s(
		"req",
		fmt([[local {} = require "{}"]], {
			f(function(args)
				local parts = vim.split(args[1][1], ".", { plain = true, trimempty = true })
				vim.pretty_print(parts)
				return parts[#parts] or ""
			end, { 1 }),
			i(1),
		})
	),
	s("ppr", fmt("vim.pretty_print({})", i(1))),
})

-- markdown
-- TODO
-- - toggle task. prepend task if not. <leader>mx
-- - convert to task. <leader>mt
-- - convert to ul. <leader>mu
-- - convert to ol. <leader>mo
ls.add_snippets("markdown", {
	s("-[]", t("- [ ] ")),
})
