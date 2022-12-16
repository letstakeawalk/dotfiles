local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selectiond
	history = true,
	-- This is cool cause if you have dynamic snippets, it updates as you type!
	update_events = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = { virt_text = { { "<--" } } },
		},
	},
})

vim.keymap.set({ "i", "s" }, "<C-t>", function()
	if ls.expand_or_locally_jumpable() then
		ls.jump(1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-s>", function()
	if ls.locally_jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-r>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

local load_snippets = function()
	for _, fname in ipairs({ "snippets", "python" }) do
		vim.cmd.source(string.format("~/.config/nvim/lua/snippets/%s.lua", fname))
	end
end
load_snippets()
vim.keymap.set("n", "<leader>SS", load_snippets, { desc = "Reload snippets" })
