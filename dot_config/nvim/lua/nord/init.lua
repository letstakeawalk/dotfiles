-- stylua: ignore start

local M = {
    c00d_black   = "#272C36", -- #272C36 --
    c00_black    = "#2E3440", -- #2E3440 -- background
    c00b_black   = "#353C4A", -- #353C4A -- statusline, folded
    c01_gray     = "#3B4252", -- #3B4252 -- cursor line
    c02_gray     = "#434C5E", -- #434C5E -- visual selection
    c03_gray     = "#4C566A", -- #4C566A --
    c03b_gray    = "#616E88", -- #616E88 -- comment, float border, conceal
    c04d_white   = "#98A2B5", -- #98A2B5 -- unmatched fuzzy result
    c04_white    = "#D8DEE9", -- #D8DEE9 -- foreground
    c05_white    = "#E5E9F0", -- #E5E9F0 --
    c06_white    = "#ECEFF4", -- #ECEFF4 --
    c04_offwhite = "#E9E3D8", -- #E9E3D8
    c05_offwhite = "#F0ECE5", -- #F0ECE5
    c06_offwhite = "#F4F1EC", -- #F4F1EC
    c07_teal     = "#8FBCBB", -- #8FBCBB --
    c08_cyan     = "#88C0D0", -- #88C0D0 -- function
    c09_glacier  = "#81A1C1", -- #81A1C1 -- keyword, info
    c10_blue     = "#5E81AC", -- #5E81AC -- hint, cursearch
    c11_red      = "#BF616A", -- #BF616A -- error
    c12_orange   = "#D08770", -- #D08770 --
    c13_yellow   = "#EBCB8B", -- #EBCB8B -- warn
    c14_green    = "#A3BE8C", -- #A3BE8C -- string
    c15_purple   = "#B48EAD", -- #B48EAD -- number

    c07d_jade    = "#729696", -- #729696
    c08d_cyan    = "#6D9AA6", -- #6D9AA6
    c09d_glacier = "#67819A", -- #67819A
    c10d_blue    = "#4B678A", -- #4B678A -- search
    c10dd_blue   = "#384D67", -- #384D67
    c11d_red     = "#994E55", -- #994E55
    c11dd_red    = "#733A40", -- #733A40
    c12d_orange  = "#A66C5A", -- #A66C5A
    c13d_yellow  = "#BCA26F", -- #BCA26F
    c13dd_yellow = "#8D7A53", -- #8D7A53
    c13vd_yellow = "#5E5138", -- #5E5138
    c14d_green   = "#829870", -- #829870
    c14dd_green  = "#627254", -- #627254
    c14vd_green  = "#414C38", -- #414C38
    c15d_purple  = "#90728A", -- #90728A

    c07b_mint    = "#A5C9C9", -- #A5C9C9
    c08b_aqua    = "#A0CDD9", -- #A0CDD9
    c09b_glacier = "#9AB4CD", -- #9AB4CD
    c10b_blue    = "#7E9ABD", -- #7E9ABD
    c11b_red     = "#CC8188", -- #CC8188
    c12b_orange  = "#D99F8D", -- #D99F8D
    c13b_yellow  = "#EFD5A2", -- #EFD5A2
    c14b_green   = "#B5CBA3", -- #B5CBA3
    c15b_purple  = "#C3A5BD", -- #C3A5BD

}

M.bg         = M.c00_black
M.fg         = M.c04_white
M.visual     = M.c02_gray
M.comment    = M.c03b_gray
M.border     = M.c03b_gray
M.cursorline = M.c01_gray
M.nontext    = M.c03_gray
M.error = M.c11_red     -- #BF616A c11 red
M.warn  = M.c13_yellow  -- #EBCB8B c13 yellow
M.info  = M.c09_glacier -- #81A1C1 c09 glacier
M.hint  = M.c10_blue    -- #5E81AC c10 blue
M.ok    = M.c14_green   -- #A3BE8C c14 green
M.diff = {
    add_br = "#005D52",
    add_dk = "#002420",
    del_br = "#5C003D",
    del_dk = "#240018",
    change = "#6C5B00"
}

return M
