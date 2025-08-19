local lualine = require("lualine")

local function location()
    return ":%l/%L :%-2v"
end

local function mode()
    return " " .. require("lualine.utils.mode").get_mode()
end

local function harpoon_files()
    local harpoon = require("harpoon")
    local contents = {}
    local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
    for index = 1, harpoon:list():length() do
        local fpath = harpoon:list():get(index).value
        local fname = fpath == "" and "(empty)" or vim.fn.fnamemodify(fpath, ":t")
        local parent = vim.fn.fnamemodify(fpath, ":h:t")
        local filters = {
            "mod.rs",
            "init.lua",
            "__init__.py",
            "index.js",
            "index.jsx",
            "index.ts",
            "index.tsx",
            "index.html",
        }
        if vim.tbl_contains(filters, fname) then
            fname = parent .. "/" .. fname
        end

        if current_file_path == fpath then
            contents[index] = string.format("%%#HarpoonNumberActive#  %s. %%#HarpoonActive#%s  ", index, fname)
        else
            contents[index] = string.format("%%#HarpoonNumberInactive#  %s. %%#HarpoonInactive#%s  ", index, fname)
        end
    end

    return table.concat(contents)
end

local nord = require("utils.nord")
local theme = {
    normal = {
        a = { fg = nord.c01_gry, bg = nord.c09_glcr, gui = "bold" },
        b = { fg = nord.c04_wht, bg = nord.c02_gry },
        c = { fg = nord.c04_wht_dk, bg = nord.c00_blk_br },
    },
    insert = {
        a = { fg = nord.c01_gry, bg = nord.c04_wht, gui = "bold" },
        b = { fg = nord.c04_wht, bg = nord.c02_gry },
        c = { fg = nord.c04_wht_dk, bg = nord.c00_blk_br },
    },
    visual = {
        a = { fg = nord.c01_gry, bg = nord.c15_prpl, gui = "bold" },
        b = { fg = nord.c04_wht, bg = nord.c02_gry },
        c = { fg = nord.c04_wht_dk, bg = nord.c00_blk_br },
    },
    replace = {
        a = { fg = nord.c01_gry, bg = nord.c13_ylw, gui = "bold" },
        b = { fg = nord.c04_wht, bg = nord.c02_gry },
        c = { fg = nord.c04_wht_dk, bg = nord.c00_blk_br },
    },
    command = {
        a = { fg = nord.c01_gry, bg = nord.c12_orng_br, gui = "bold" },
        b = { fg = nord.c04_wht, bg = nord.c02_gry },
        c = { fg = nord.c04_wht_dk, bg = nord.c00_blk_br },
    },
    inactive = {
        a = { fg = nord.c04_wht, bg = nord.c00_blk_dk, gui = "bold" },
        b = { fg = nord.c04_wht, bg = nord.c00_blk_dk },
        c = { fg = nord.c04_wht_dk, bg = nord.c00_blk_br },
    },
}

lualine.setup({
    options = {
        icons_enabled = true,
        theme = theme,
        section_separators = { left = "", right = "" }, --   
        component_separators = { left = "", right = "" }, -- 
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            -- tabline = 1000,
            -- winbar = 1000,
        },
    },
    sections = {
        lualine_a = { mode },
        lualine_b = {
            { "branch", icon = " 󰘬", separator = "", padding = 1 },
            {
                "diff",
                symbols = { added = "+", modified = "~", removed = "-" },
                colored = true,
                diff_color = {
                    added = { fg = nord.c14_grn },
                    modified = { fg = nord.c13_ylw },
                    removed = { fg = nord.c11_red },
                },
                padding = { right = 1 },
            },
            {
                "diagnostics",
                symbols = { error = "E", warn = "W", hint = "H", info = "I" },
                padding = 1,
            },
        },
        lualine_c = {
            -- { "filetype", icon_only = true, separator = "", padding = { left = 2 } },
            { "filename", path = 1, padding = { left = 2 } }, -- 1: rel, 2: abs, 3:abs(~), 4: filename
        },
        lualine_x = {
            -- { "diagnostics", symbols = { error = " ", warn = " ", hint = " ", info = " " } },
            "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { location },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { location },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {},
    tabline = {
        lualine_a = { { harpoon_files, separator = { "" }, padding = 0 } },
    },
})
