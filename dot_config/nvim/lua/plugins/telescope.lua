return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-symbols.nvim", -- symbol picker
		"tsakirist/telescope-lazy.nvim", -- lazy.nvim
		"ahmedkhalf/project.nvim",
	},
	cmd = { "Telescope" },
	init = function()
		-- keymaps
		vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Telescope Files" })
		vim.keymap.set("n", "<leader>p", "<cmd>Telescope live_grep<cr>", { desc = "Telescope Live Grep" })
		vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>tc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
		vim.keymap.set("n", "<leader>th", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
		vim.keymap.set("n", "<leader>tH", "<cmd>Telescope highlights<cr>", { desc = "Highlight" })
		vim.keymap.set("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
		vim.keymap.set("n", "<leader>tm", "<cmd>Telescope marks<cr>", { desc = "Marks" })
		vim.keymap.set("n", "<leader>tq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix" })
		vim.keymap.set("n", "<leader>tA", "<cmd>Telescope autocommands<cr>", { desc = "Autocmd" })
		vim.keymap.set("n", "<leader>ts", "<cmd>Telescope spell_suggest<cr>", { desc = "Spell suggest" })
		vim.keymap.set("n", "<leader>tS", "<cmd>Telescope symbols<cr>", { desc = "Symbols" })
		vim.keymap.set("n", "<leader>tr", "<cmd>Telescope resume<cr>", { desc = "Resume" })
		-- lsp pickers
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP References" })
		vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP Implementations" })
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "LSP Definitions" })
		vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "LSP TypeDefinitions" })
		-- git
		vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
		vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
		vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_bcommits<cr>", { desc = "Git Buf Commits" })
		vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
		vim.keymap.set("n", "<leader>gS", "<cmd>Telescope git_stash<cr>", { desc = "Git Stash" })
		-- extensions
		vim.keymap.set("n", "<leader>tl", "<cmd>Telescope lazy<cr>", { desc = "Lazy" })
		vim.keymap.set("n", "<leader>tp", "<cmd>Telescope projects<cr>", { desc = "Projects" })
		vim.keymap.set("n", "<leader>ta", "<cmd>Telescope aerial<cr>", { desc = "Aerial" })
	end,
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_strategy = "center", -- horizontal, center, vertical
				layout_config = {
					width = 80,
					height = 0.25,
				},
				borderchars = {
					prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
					results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
					preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				},
				results_title = false,
				sorting_strategy = "ascending",
				prompt_prefix = "   ", -- ' 🔭🔎 ',
				selection_caret = "  ",
				multi_icon = "  ",
				entry_prefix = "   ",
				mappings = {
					i = {
						["<ESC>"] = actions.close,
						["<C-h>"] = "which_key",
					},
					n = {
						["k"] = actions.move_selection_next,
						["h"] = actions.move_selection_previous,
					},
				},
			},
			pickers = {},
			extensions = {
				lazy = {
					mappings = {
						open_in_browser = "<C-o>",
						open_in_file_browser = "<M-b>",
						open_in_find_files = "<C-f>",
						open_in_live_grep = "<C-g>",
						open_plugins_picker = "<C-p>", -- Works only after having called first another action
						open_lazy_root_find_files = "<C-r>f",
						open_lazy_root_live_grep = "<C-r>g",
					},
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("lazy")
		telescope.load_extension("projects")
		telescope.load_extension("aerial")
		-- telescope.load_extension("neorg")

		-- highlight
		local nord = require("utils").nord
		vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "FloatTitle" })
		vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
		vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "TelescopeTitle" })
		vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = nord.c04, bold = true })
		vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { fg = nord.c04_dk0 })

		-- list of extensions
		-- https://github.com/sudormrfbin/cheatsheet.nvim
		-- https://github.com/nvim-telescope/telescope-dap.nvim
		-- https://github.com/danielpieper/telescope-tmuxinator.nvim
		-- https://github.com/nvim-neorg/neorg-telescope

		-- https://github.com/barrett-ruth/telescope-http.nvim
		-- https://github.com/chip/telescope-software-licenses.nvim
	end,
}
