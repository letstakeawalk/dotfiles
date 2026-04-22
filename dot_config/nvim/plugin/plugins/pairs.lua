vim.pack.add({
    { src = "gh:saghen/blink.pairs", version = vim.version.range("*") },
    "gh:saghen/blink.download",
})

--- @module 'blink.pairs'
--- @type blink.pairs.Config
require("blink.pairs").setup({
    mappings = {
        -- you can call require("blink.pairs.mappings").enable()
        -- and require("blink.pairs.mappings").disable()
        -- to enable/disable mappings at runtime
        enabled = true,
        cmdline = true,
        -- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
        -- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
        disabled_filetypes = {},
        wrap = {
            -- move closing pair via motion
            ["<C-f>"] = "motion",
            -- move opening pair via motion
            ["<C-S-f>"] = "motion_reverse",
            -- set to 'treesitter' or 'treesitter_reverse' to use treesitter instead of motions
            -- set to nil, '' or false to disable the mapping
            -- normal_mode = {} <- for normal mode mappings, only supports 'motion' and 'motion_reverse'
        },
        pairs = {}, -- defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L52
    },
    highlights = {
        enabled = true,
        cmdline = true, -- requires require('vim._extui').enable({}), otherwise has no effect
        groups = { "BlinkPairs" }, -- { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" },
        unmatched_group = "BlinkPairsUnmatched",

        -- highlights matching pairs under the cursor
        matchparen = {
            enabled = true,
            -- known issue where typing won't update matchparen highlight, disabled by default
            cmdline = false,
            -- also include pairs not on top of the cursor, but surrounding the cursor
            include_surrounding = false,
            group = "BlinkPairsMatchParen",
            priority = 250,
        },
    },
    debug = false,
})
