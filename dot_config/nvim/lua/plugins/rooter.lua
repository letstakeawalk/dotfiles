return {
	"airblade/vim-rooter",
	event = "VeryLazy",
	config = function()
		vim.g.rooter_patterns = {
			".git",
			-- python
			"pyproject.toml",
			"requirements.txt",
			"Pipfile",
			"pyrightconfig.json",
			-- ts
			"package.json",
			"tsconfig.json",
			"jsconfig.json",
			-- rust
			"Cargo.toml",
			-- go
			"go.mod",
			-- lua
			"init.lua",
			"selene.toml",
			"selene.yml",
		}
	end,
}
