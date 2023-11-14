return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufRead",
    config = function()
        local ibl = require("ibl")
        ibl.setup({
            indent = { char = "│" },
            scope = {
                show_start = false, -- underline of the scope
                show_end = false,
                highlight = "Type", -- nord.c09_glcr
            },
            exclude = { filetypes = { "help", "NvimTree" } },
        })
    end,
}
