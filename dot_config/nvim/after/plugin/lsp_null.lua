-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require("null-ls")
local util = require("lspconfig/util")
local methods = require("null-ls.methods")
local helpers = require("null-ls.helpers")

local function ruff_fix()
	return helpers.make_builtin({
		name = "ruff",
		meta = {
			url = "https://github.com/charliermarsh/ruff/",
			description = "An extremely fast Python linter, written in Rust.",
		},
		method = methods.internal.FORMATTING,
		filetypes = { "python" },
		generator_opts = {
			command = "ruff",
			args = { "--fix", "-e", "-n", "--stdin-filename", "$FILENAME", "-" },
			to_stdin = true,
		},
		factory = helpers.formatter_factory,
	})
end

null_ls.setup({
	debug = false,
	root_dir = util.root_pattern(".git", "pyproject.toml", "Pipfile"),
	sources = {
		-- code action
		null_ls.builtins.code_actions.eslint, -- js, ts
		-- null_ls.builtins.code_actions.gitsigns, -- gitsign.nvim

		-- diagnostics
		null_ls.builtins.diagnostics.eslint, -- js, ts
		null_ls.builtins.diagnostics.gitlint, -- git commit msg
		null_ls.builtins.diagnostics.hadolint, -- docker
		null_ls.builtins.diagnostics.write_good, -- english
		-- null_ls.builtins.diagnostics.markdownlint, -- markdown

		-- formatting
		null_ls.builtins.formatting.prettier, -- etc
		null_ls.builtins.formatting.stylua, -- lua
		null_ls.builtins.formatting.taplo, -- toml
		null_ls.builtins.formatting.rustfmt, -- rust
		-- null_ls.builtins.formatting.rustywind,

		-- python
		-- ruff_fix(),
		null_ls.builtins.diagnostics.ruff, -- linter
		null_ls.builtins.diagnostics.mypy, -- type checker
		null_ls.builtins.diagnostics.pylint, -- linter
		null_ls.builtins.formatting.black, -- formatter: style
		null_ls.builtins.formatting.isort, -- formatter: import statment
		-- null_ls.builtins.diagnostics.bandit,  -- check back later for PR

		-- sql
		-- null_ls.builtins.formatting.sqlformat, -- TODO need python 3.9
		-- null_ls.builtins.diagnostics.sqlfluff.with({
		-- 	extra_args = { "--dialect", "ansi" }, -- postgres
		-- }),
		-- null_ls.builtins.formatting.sqlfluff.with({
		-- 	extra_args = { "--dialect", "ansi" }, -- "postgres"
		-- }),

		-- ruby
		-- null_ls.builtins.diagnostics.rubocop,
		-- null_ls.builtins.formatting.rubocop,

		-- future checkout
		-- terrafmt
		-- dprint
	},
	-- diagnostics_format = "#{m} [#{c}]",
	diagnostics_format = "#{m}",
	-- diagnostics_format = "#{m} [#{c}] (#{s})",
})
