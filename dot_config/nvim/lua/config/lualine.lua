---@alias label string label to be displayed on tabline
---@alias parent string parents of label (path)
---@alias fullpath string fullpath of the harpoon item
---@alias index integer index of the harpoon item
---@alias LualineHarpoonItem {[1]: index, [2]: label, [3]: parent, [4]: fullpath} -- {index, label, parent, fullpath}
---@alias LualineLabelHarpoonMap {[label]: LualineHarpoonItem[]}

local lualine = require("lualine")

local function location()
    return ":%l/%L :%-2v"
end

local function mode()
    return " " .. require("lualine.utils.mode").get_mode()
end

-- stylua: ignore
local harpoon_fname_filters = {
    "Cargo.toml", "mod.rs", "lib.rs", "main.rs",
    "init.lua",
    "__init__.py",
    "index.js", "index.jsx", "index.ts", "index.tsx",
    "+page.svelte", "+page.server.js", "+page.server.ts", "+layout.svelte", "+layout.server.js", "+layout.server.ts", "+error.svelte",
    "index.html",
}
local harpoon_ft_filters = {
    ["rs"] = { "^src", "^tests" },
}

---@param hmap LualineLabelHarpoonMap
---@return LualineLabelHarpoonMap
local function resolve_duplicate_labels(hmap)
    for label, items in pairs(hmap) do
        if #items > 1 then
            local new_label ---@type string
            for _, item in ipairs(items) do
                new_label = label
                local index, _, parent, fpath = unpack(item)
                if parent ~= "." then
                    new_label = vim.fn.fnamemodify(parent, ":t") .. "/" .. label
                    parent = vim.fn.fnamemodify(parent, ":h")
                end
                local ext = vim.fn.fnamemodify(new_label, ":e")
                if harpoon_ft_filters[ext] then
                    for _, filter in ipairs(harpoon_ft_filters[ext]) do
                        if new_label:match(filter) then
                            new_label = vim.fn.fnamemodify(parent, ":t") .. "/" .. new_label
                            parent = vim.fn.fnamemodify(parent, ":h")
                        end
                    end
                end
                hmap[new_label] = hmap[new_label] or {}
                table.insert(hmap[new_label], { index, new_label, parent, fpath })
            end
            hmap[label] = nil -- Remove the old label
        end
    end
    for _, items in pairs(hmap) do
        if #items > 1 then
            return resolve_duplicate_labels(hmap)
        end
    end
    return hmap
end

local function harpoon_files()
    local harpoon = require("harpoon")
    local current_fpath = vim.fn.expand("%")

    local hmap = {} ---@type LualineLabelHarpoonMap
    for index = 1, harpoon:list():length() do
        local fpath = harpoon:list():get(index).value
        if #fpath == 0 then
            goto continue
        end
        local label = vim.fn.fnamemodify(fpath, ":t")
        if vim.tbl_contains(harpoon_fname_filters, label, {}) then
            label = string.format("%s/%s", vim.fn.fnamemodify(fpath, ":h:t"), label)
        end
        local parent = vim.fn.fnamemodify(fpath, ":h")
        hmap[label] = hmap[label] or {}
        table.insert(hmap[label], { index, label, parent, fpath })
        ::continue::
    end

    hmap = resolve_duplicate_labels(hmap)

    local list = {} ---@type LualineHarpoonItem[]
    for _, items in pairs(hmap) do
        if #items > 1 then
            vim.notify("harpoon duplicate resolve unexpectedly failed", vim.log.levels.WARN)
        end
        list[#list + 1] = items[1]
    end

    table.sort(list, function(a, b)
        -- sort by index
        return a[1] < b[1]
    end)

    local items = vim.tbl_map(function(item)
        ---@diagnostic disable-next-line: unused-local
        local index, label, parent, fullpath = unpack(item)
        if current_fpath:match(fullpath) then
            return string.format("%%#HarpoonNumberActive#  %d. %%#HarpoonActive#%s  ", index, label)
        else
            return string.format("%%#HarpoonNumberInactive#  %d. %%#HarpoonInactive#%s  ", index, label)
        end
    end, list)

    return table.concat(items)
end

local nord = require("nord")
local theme = {
    normal = {
        a = { fg = nord.c01_gray, bg = nord.c09_glacier, gui = "bold" },
        b = { fg = nord.c04_white, bg = nord.c02_gray },
        c = { fg = nord.c04d_white, bg = nord.c00b_black },
    },
    insert = {
        a = { fg = nord.c01_gray, bg = nord.c04_white, gui = "bold" },
        b = { fg = nord.c04_white, bg = nord.c02_gray },
        c = { fg = nord.c04d_white, bg = nord.c00b_black },
    },
    visual = {
        a = { fg = nord.c01_gray, bg = nord.c15_purple, gui = "bold" },
        b = { fg = nord.c04_white, bg = nord.c02_gray },
        c = { fg = nord.c04d_white, bg = nord.c00b_black },
    },
    replace = {
        a = { fg = nord.c01_gray, bg = nord.c13_yellow, gui = "bold" },
        b = { fg = nord.c04_white, bg = nord.c02_gray },
        c = { fg = nord.c04d_white, bg = nord.c00b_black },
    },
    command = {
        a = { fg = nord.c01_gray, bg = nord.c12b_orange, gui = "bold" },
        b = { fg = nord.c04_white, bg = nord.c02_gray },
        c = { fg = nord.c04d_white, bg = nord.c00b_black },
    },
    inactive = {
        a = { fg = nord.c04_white, bg = nord.c00d_black, gui = "bold" },
        b = { fg = nord.c04_white, bg = nord.c00d_black },
        c = { fg = nord.c04d_white, bg = nord.c00b_black },
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
                    added = { fg = nord.c14_green },
                    modified = { fg = nord.c13_yellow },
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
        lualine_x = {
            {
                "tabs",
                tabs_color = {
                    active = "LualineTabsActive",
                    inactive = "LualineTabsInactive",
                },
                separator = { "" },
                symbols = {
                    modified = "+",
                },
            },
        },
    },
})
