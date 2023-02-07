return {
	"nathom/filetype.nvim",
	lazy = false,
	-- enabled = false,
	config = function()
		local ft = require("filetype")
		ft.setup({
			overrides = {
				extensions = {
					-- Set the filetype of *.pn files to potion
					ron = "ron",
				},
			},
		})
		ft.resolve()
	end,
}
