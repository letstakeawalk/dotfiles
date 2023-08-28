-- stylua: ignore start
local M = {
    c00_blk_dk = "#272C36", -- 220, 28, 21
    c00_blk    = "#2E3440", -- 220, 28, 25 -- bg
    c00_blk_br = "#353C4A", -- 220, 28, 29
    c01_gry    = "#3B4252", -- 222, 28, 32 -- cursor line
    c02_gry    = "#434C5E", -- 220, 29, 37 -- visual selection
    c03_gry    = "#4C566A", -- 220, 28, 42
    c03_gry_br = "#616E88", -- 220, 29, 53 -- comment, float border,
    c04_wht_dk = "#98A2B5", -- 219, 16, 71 -- unmatched fuzzy result
    c04_wht    = "#D8DEE9", -- 219, 7,  91 -- fg
    c05_wht    = "#E5E9F0", -- 218, 5,  94
    c06_wht    = "#ECEFF4", -- 218, 3,  96
    c07_jade   = "#8FBCBB", -- 179, 24, 74
    c08_teal   = "#88C0D0", -- 193, 35, 82 -- function
    c09_glcr   = "#81A1C1", -- 210, 33, 76 -- keyword, info
    c10_blue   = "#5E81AC", -- 213, 45, 67 -- hint
    c11_red    = "#BF616A", -- 354, 49, 75 -- error
    c12_orng   = "#D08770", -- 14,  46, 82
    c13_ylw    = "#EBCB8B", -- 40,  41, 92 -- warn
    c14_grn    = "#A3BE8C", -- 92,  26, 75 -- string
    c15_prpl    = "#B48EAD", -- 311, 21, 71 -- number
    -- c11_red_l  = "#BF757C", -- 354, 39, 75
    -- c12_orng_l = "#D09786", -- 14,  36, 82
    -- c13_ylw_l  = "#EBD3A2", -- 40,  31, 92
    -- c14_grn_l  = "#AEBEA0", -- 92,  16, 75
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
