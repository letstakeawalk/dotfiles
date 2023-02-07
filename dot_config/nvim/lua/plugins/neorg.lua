-- https://github.com/nvim-neorg/neorg
return {
	"nvim-neorg/neorg",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "nvim-neorg/neorg-telescope",
		"nvim-telescope/telescope.nvim",
	},
	build = ":Neorg sync-parsers",
	cmd = "Neorg",
	ft = "norg",
	init = function()
		vim.keymap.set("n", "<leader>nh", "<cmd>Neorg workspace home<cr>", { desc = "Home" })
		vim.keymap.set("n", "<leader>nw", "<cmd>Neorg workspace work<cr>", { desc = "Work" })
		vim.keymap.set("n", "<leader>nt", "<cmd>Neorg toggle-concealer<cr>", { desc = "Work" })
	end,
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.norg.concealer"] = {},
				["core.norg.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.norg.dirman"] = {
					config = {
						workspaces = {
							home = "~/Workspace/notes/home",
							work = "~/Workspace/notes/work",
						},
					},
				},
				-- ["core.norg.journal"] = {},
				-- ["core.norg.qol.toc"] = {},
				-- ["core.presenter"] = {
				-- 	zen_mode = "zen-mode",
				-- },
				["core.integrations.nvim-cmp"] = {},
				-- ["core.integrations.telescope"] = {},
			},
		})

		-- local neorg_callbacks = require("neorg.callbacks")
		--
		-- neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
		-- 	-- Map all the below keybinds only when the "norg" mode is active
		-- 	keybinds.map_event_to_mode("norg", {
		-- 		n = { -- Bind keys in normal mode
		-- 			{ "<C-s>", "core.integrations.telescope.find_linkable" },
		-- 		},
		--
		-- 		i = { -- Bind in insert mode
		-- 			{ "<C-l>", "core.integrations.telescope.insert_link" },
		-- 		},
		-- 	}, {
		-- 		silent = true,
		-- 		noremap = true,
		-- 	})
		-- end, function() end)
	end,
}
