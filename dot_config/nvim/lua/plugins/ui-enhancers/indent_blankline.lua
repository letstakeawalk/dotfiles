return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    init = function()
        local nord = require("utils.nord")
        vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = nord.c01_gry })
        vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = nord.c09_glcr })
    end,
    opts = {
        show_current_context = true, -- current context highlight
        show_current_context_start = false,
        use_treesitter = true,
        filetype_exclude = { "help", "dashboard", "NvimTree", "norg" },
    },
}
