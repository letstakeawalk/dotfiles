-- gitsign
require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Goto next hunk" })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Goto prev hunk" })

		-- Actions
		map({ "n", "v" }, "<leader>Gs", ":Gitsigns stage_hunk<CR>", { desc = "Git stage hunk" })
		map({ "n", "v" }, "<leader>Gr", ":Gitsigns reset_hunk<CR>", { desc = "Git reset hunk" })
		map("n", "<leader>GS", gs.stage_buffer, { desc = "Git stage buffer" })
		map("n", "<leader>GR", gs.reset_buffer, { desc = "Git reset buffer" })
		map("n", "<leader>Gu", gs.undo_stage_hunk, { desc = "Git undo stage hunk" })
		map("n", "<leader>Gp", gs.preview_hunk, { desc = "Git preview hunk" })
		map("n", "<leader>Gb", function() gs.blame_line({ full = true }) end, { desc = "Git blame" })
		map("n", "<leader>GB", gs.toggle_current_line_blame, { desc = "Git blame toggle" })
		map("n", "<leader>Gd", gs.diffthis, { desc = "Git diff" })
		map("n", "<leader>GD", function() gs.diffthis("~") end, { desc = "Git diff" })
		map("n", "<leader>Gx", gs.toggle_deleted, { desc = "Git toggle deleted" })
		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git select hunk" })
	end,
})

-- junegunn/gv.vim
vim.keymap.set("n", "<leader>gv", ":GV<cr>", { desc = "Git Commit Browser" })
vim.keymap.set("n", "<leader>gV", ":GV!<cr>", { desc = "Git BufCommit Browser" })
