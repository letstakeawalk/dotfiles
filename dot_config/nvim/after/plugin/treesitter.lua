require("nvim-treesitter.configs").setup({
	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = {
		"bash",
		"c",
		"c_sharp",
		"cmake",
		"comment",
		"cpp",
		"css",
		"dockerfile",
		"gitcommit",
		"gitignore",
		"gitattributes",
		"go",
		"html",
		"java",
		"javascript",
		"json",
		"jsonc",
		--[[ "kotlin", ]]
		"latex",
		"lua",
		"markdown",
		"markdown_inline",
		"norg", -- norg note plugin
		"python",
		"ruby",
		"rust",
		"sql",
		"typescript",
		"vim",
		"yaml",
	},

	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- List of parsers to ignore installing
	ignore_install = {},

	highlight = {
		enable = true, -- `false` will disable the whole extension
		disable = { "markdown", "markdown_inline" },
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		-- additional_vim_regex_highlighting = false,
		-- additional_vim_regex_highlighting = { "markdown", "markdown_inline" },
	},

	indent = {
		enable = false,
		disable = {},
	},

	-- text objects module
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["acl"] = "@class.outer",
				["icl"] = "@class.inner",
				["aco"] = "@conditional.outer",
				["ico"] = "@conditional.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["aP"] = "@parameter.outer",
				["iP"] = "@parameter.inner",
				-- ["cm"] = "@comment.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]f"] = "@function.outer",
				[")("] = "@function.outer",
				["]["] = "@class.outer",
				[")p"] = "@parameter.inner",
				[")c"] = "@conditional.inner",
				[")l"] = "@loop.inner",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]F"] = "@function.outer",
				["))"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[f"] = "@function.outer",
				["(("] = "@function.outer",
				["[["] = "@class.outer",
				["(p"] = "@parameter.inner",
				["(c"] = "@conditional.inner",
				["(l"] = "@loop.inner",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[F"] = "@function.outer",
				["()"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = { ["<leader>rs"] = "@parameter.inner" },
			swap_previous = { ["<leader>rS"] = "@parameter.inner" },
		},
	},

	-- nvim-ts-context-commentstring module
	context_commentstring = {
		enable = true,
		enable_autocmd = false, -- for Comment.nvim
	},

	-- autotag module
	autotag = { enable = true },

	-- endwise module
	endwise = { enable = true },

	-- playground
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,
		persist_queries = false,
	},
})

-- code context winbar
require("treesitter-context").setup({ enable = true })

-- Custom highlight captures
vim.api.nvim_set_hl(0, "@text.danger", { link = "DiagnosticError" })
vim.api.nvim_set_hl(0, "@text.warning", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "@text.note", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })

-- vim.opt.foldmethod     = 'expr'
-- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
---WORKAROUND TODO: make this work only for markdown
vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
	pattern = "*.md",
	callback = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldenable = true
		-- vim.opt.foldenable = false
	end,
})
---ENDWORKAROUND
