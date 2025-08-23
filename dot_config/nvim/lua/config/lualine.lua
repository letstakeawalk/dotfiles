---@alias label string label to be displayed on tabline
---@alias parent string parents of label (path)
---@alias fullpath string fullpath of the harpoon item
---@alias index integer index of the harpoon item
---@alias value {[1]: parent, [2]: fullpath, [3]: index}[] -- {parent, fullpath, index}
---@alias hmap {[label]: value}

local lualine = require("lualine")

local function location()
    return ":%l/%L :%-2v"
end

local function mode()
    return " " .. require("lualine.utils.mode").get_mode()
end

---@param hmap hmap
---@return hmap
local function resolve_duplicate_labels(hmap)
    for label, items in pairs(hmap) do
        if #items > 1 then
            for _, item in ipairs(items) do
                local new_label = label
                local parent, fpath, index = unpack(item)
                if parent ~= "." then
                    new_label = vim.fn.fnamemodify(parent, ":t") .. "/" .. label
                    parent = vim.fn.fnamemodify(parent, ":h")
                end
                hmap[new_label] = hmap[new_label] or {}
                table.insert(hmap[new_label], { parent, fpath, index })
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

    -- stylua: ignore
    local filters = {
        "mod.rs", "Cargo.toml",
        "init.lua",
        "__init__.py",
        "index.js", "index.jsx", "index.ts", "index.tsx",
        "+page.svelte", "+page.server.js", "+page.server.ts", "+layout.svelte", "+layout.server.js", "+layout.server.ts", "+error.svelte",
        "index.html",
    }

    local hmap = {} ---@type hmap
    for index = 1, harpoon:list():length() do
        local fpath = harpoon:list():get(index).value
        if #fpath == 0 then
            goto continue
        end
        local label = vim.fn.fnamemodify(fpath, ":t")
        if vim.tbl_contains(filters, label, {}) then
            label = string.format("%s/%s", vim.fn.fnamemodify(fpath, ":h:t"), label)
        end
        local parent = vim.fn.fnamemodify(fpath, ":h")
        hmap[label] = hmap[label] or {}
        table.insert(hmap[label], { parent, fpath, index })
        ::continue::
    end

    local temp = {} ---@type {[integer]: string}
    hmap = resolve_duplicate_labels(hmap)
    -- vim.notify_once("after resolve:" .. vim.inspect(hmap))
    for label, items in pairs(hmap) do
        -- assert(#items == 1, "unexpected duplicate harpoon labels found")
        ---@diagnostic disable-next-line: unused-local
        local _parent, fpath, index = unpack(items[1])
        -- stylua: ignore
        if #items > 1 then vim.notify("harpoon duplicate resolve unexpectedly failed", vim.log.levels.WARN) end
        if current_fpath == fpath then
            table.insert(temp, index, string.format("%%#HarpoonNumberActive#  %d. %%#HarpoonActive#%s  ", index, label))
        else
            table.insert(
                temp,
                index,
                string.format("%%#HarpoonNumberInactive#  %d. %%#HarpoonInactive#%s  ", index, label)
            )
        end
    end
    -- vim.notify_once("temp" .. vim.inspect(temp))
    -- transform array into list
    local harpoons = {} ---@type string[]
    for index = 1, #temp do
        table.insert(harpoons, temp[index])
    end
    -- vim.notify_once("harpoons" .. vim.inspect(harpoons))

    return table.concat(harpoons)
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
