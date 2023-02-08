local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	-- lazy config
	defaults = {
		lazy = true,
	},
	ui = {
		border = "double",
	},
	install = {
		colorscheme = { "nord", "habamax" },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"zipPlugin",
				"matchit",
				-- "matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
			},
		},
	},
})

vim.api.nvim_set_keymap("n", "<leader>iz", "<cmd>Lazy<cr>", { desc = "Lazy" })

vim.api.nvim_set_hl(0, "LazyButtonActive", { link = "LazyH1" })
