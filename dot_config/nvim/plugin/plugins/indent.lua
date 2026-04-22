vim.pack.add({ "gh:saghen/blink.indent" })

require("blink.indent").setup({
    blocked = {
        -- default: 'terminal', 'quickfix', 'nofile', 'prompt'
        buftypes = { include_defaults = true },
        -- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
        filetypes = { include_defaults = true },
    },
    mappings = {
        border = "both", -- 'top', 'bottom', 'both', 'none'
        -- textobjects (e.g. `y2ii` to yank current and outer scope)
        object_scope = "ii",
        object_scope_with_border = "ai",
        -- motions
        goto_top = "", -- "[i",
        goto_bottom = "", -- "]i",
    },
    static = {
        enabled = true,
        char = "│", --"▎",
        whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
        highlights = { "BlinkIndent" }, -- { 'BlinkIndentRed', 'BlinkIndentOrange', 'BlinkIndentYellow', 'BlinkIndentGreen', 'BlinkIndentViolet', 'BlinkIndentCyan' }
    },
    scope = {
        enabled = true,
        char = "│", --"▎",
        highlights = { "BlinkIndentScope" }, -- { "BlinkIndentOrange", "BlinkIndentViolet", "BlinkIndentBlue" }
        underline = {
            enabled = false,
            -- highlights = { "BlinkIndentOrangeUnderline", "BlinkIndentVioletUnderline", "BlinkIndentBlueUnderline", },
        },
    },
})

-- vim.pack.add({ "gh:lukas-reineke/indent-blankline.nvim" })
--
-- require("ibl").setup({
--     indent = { char = "│" },
--     scope = {
--         show_start = false, -- underline of the scope
--         show_end = false,
--     },
-- })
