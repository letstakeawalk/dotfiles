-- stylua: ignore start
local M = {
    c00_blk_dk  = "#272C36",
    c00_blk     = "#2E3440", -- bg
    c00_blk_br  = "#353C4A",
    c01_gry     = "#3B4252", -- cursor line
    c02_gry     = "#434C5E", -- visual selection
    c03_gry     = "#4C566A",
    c03_gry_br  = "#616E88", -- comment, float border,
    c04_wht_dk  = "#98A2B5", -- unmatched fuzzy result
    c04_wht     = "#D8DEE9", -- fg
    c05_wht     = "#E5E9F0",
    c06_wht     = "#ECEFF4",
    c07_jade    = "#8FBCBB",
    c08_teal    = "#88C0D0", -- function
    c09_glcr    = "#81A1C1", -- keyword, info
    c10_blue    = "#5E81AC", -- hint
    c11_red     = "#BF616A", -- error
    c12_orng    = "#D08770",
    c13_ylw     = "#EBCB8B", -- warn
    c14_grn     = "#A3BE8C", -- string
    c15_prpl    = "#B48EAD", -- number

    c07_jade_br = "#A5C9C9", c07_jade_dk = "#729696",
    c08_teal_br = "#A0CDD9", c08_teal_dk = "#6D9AA6",
    c09_glcr_br = "#9AB4CD", c09_glcr_dk = "#67819A",
    c10_blue_br = "#7E9ABD", c10_blue_dk = "#4B678A",
    c11_red_br  = "#CC8188", c11_red_dk  = "#994E55",
    c12_orng_br = "#D99F8D", c12_orng_dk = "#A66C5A",
    c13_ylw_br  = "#EFD5A2", c13_ylw_dk  = "#BCA26F",
    c14_grn_br  = "#B5CBA3", c14_grn_dk  = "#829870",
    c15_prpl_br = "#C3A5BD", c15_prpl_dk = "#90728A",
}

M.bg         = M.c00_blk -- c00 black
M.fg         = M.c04_wht -- c04 white
M.visual     = M.c02_gry -- c02_grry
M.cursorline = M.c01_gry -- c01 gray
M.error      = M.c11_red -- c11 red
M.warn       = M.c13_ylw -- c13 yellow
M.info       = M.c08_teal -- c09 glacier
M.hint       = M.c10_blue -- c10 blue
M.ok         = M.c14_grn -- c14 green
-- stylua ignore end

return M
