-- set tab size to 4
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("TabSizeFour", {}),
	pattern = { "python", "rust", "c", "cpp" },
	callback = function()
		vim.api.nvim_buf_set_option(0, "tabstop", 4)
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- auto add config files to chezmoi
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("Chezmoi", {}),
	pattern = { vim.env.XDG_CONFIG_HOME .. "/nvim/**/*.lua" },
	callback = function()
		vim.cmd([[!chezmoi add "%"]])
	end,
})

-- -- set spell on txt, md, tex, gitcommit ft
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "gitcommit", "markdown" },
-- 	callback = function()
-- 		vim.opt_local.wrap = true
-- 		vim.opt_local.spell = true
-- 	end,
-- })
