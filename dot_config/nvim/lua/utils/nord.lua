-- stylua: ignore start
local nord = {
    c00_blk_dk  = "#272C36", -- #272C36
    c00_blk     = "#2E3440", -- #2E3440 background
    c00_blk_br  = "#353C4A", -- #353C4A
    c01_gry     = "#3B4252", -- #3B4252 cursor line
    c02_gry     = "#434C5E", -- #434C5E visual selection
    c03_gry     = "#4C566A", -- #4C566A
    c03_gry_br  = "#616E88", -- #616E88 comment, float border, conceal 
    c04_wht_dk  = "#98A2B5", -- #98A2B5 unmatched fuzzy result 
    c04_wht     = "#D8DEE9", -- #D8DEE9 foreground 
    c05_wht     = "#E5E9F0", -- #E5E9F0
    c06_wht     = "#ECEFF4", -- #ECEFF4
    c07_jade    = "#8FBCBB", -- #8FBCBB
    c08_teal    = "#88C0D0", -- #88C0D0 function 
    c09_glcr    = "#81A1C1", -- #81A1C1 keyword, info 
    c10_blue    = "#5E81AC", -- #5E81AC hint 
    c11_red     = "#BF616A", -- #BF616A error 
    c12_orng    = "#D08770", -- #D08770
    c13_ylw     = "#EBCB8B", -- #EBCB8B warn 
    c14_grn     = "#A3BE8C", -- #A3BE8C string 
    c15_prpl    = "#B48EAD", -- #B48EAD number 

    c07_jade_br = "#A5C9C9", -- #A5C9C9
    c07_jade_dk = "#729696", -- #729696
    c08_teal_br = "#A0CDD9", -- #A0CDD9
    c08_teal_dk = "#6D9AA6", -- #6D9AA6
    c09_glcr_br = "#9AB4CD", -- #9AB4CD
    c09_glcr_dk = "#67819A", -- #67819A
    c10_blue_br = "#7E9ABD", -- #7E9ABD
    c10_blue_dk = "#4B678A", -- #4B678A
    c11_red_br  = "#CC8188", -- #CC8188
    c11_red_dk  = "#994E55", -- #994E55
    c12_orng_br = "#D99F8D", -- #D99F8D
    c12_orng_dk = "#A66C5A", -- #A66C5A
    c13_ylw_br  = "#EFD5A2", -- #EFD5A2
    c13_ylw_dk  = "#BCA26F", -- #BCA26F
    c14_grn_br  = "#B5CBA3", -- #B5CBA3
    c14_grn_dk  = "#829870", -- #829870
    c15_prpl_br = "#C3A5BD", -- #C3A5BD
    c15_prpl_dk = "#90728A", -- #90728A
}

nord.bg         = nord.c00_blk   -- #2E3440 c00 black
nord.fg         = nord.c04_wht   -- #D8DEE9 c04 white
nord.visual     = nord.c02_gry   -- #434C5E c02_gray
nord.cursorline = nord.c01_gry   -- #3B4252 c01 gray
nord.error      = nord.c11_red   -- #BF616A c11 red
nord.warn       = nord.c13_ylw   -- #EBCB8B c13 yellow
nord.info       = nord.c08_teal  -- #81A1C1 c09 glacier
nord.hint       = nord.c10_blue  -- #5E81AC c10 blue
nord.ok         = nord.c14_grn   -- #A3BE8C c14 green

return nord
