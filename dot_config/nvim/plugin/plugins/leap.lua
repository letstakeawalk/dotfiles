vim.pack.add({
    "cb:andyg/leap.nvim",
    "gh:tpope/vim-repeat",
})

local leap = require("leap")
local remote = require("leap.remote")
leap.setup({
    safe_labels = "stnufkhlj/STNFUMGLZ?", -- skip auto-jump "sfnut/SFNLHMUGTZ?"
    labels = "stneioarulyfpwmg,h.cdxz/kvq;bjSTNEIOARULYFPWMG<H>CDXZ?KVQ:BJ",
})

-- keymaps
local function leap_win_end()
    leap.leap({ offset = 1, inclusive = true, windows = { vim.api.nvim_get_current_win() } })
end
local set = require("utils.keymap").set
set("n", "s", "<Plug>(leap-forward)", { desc = "Leap Forward" })
set("n", "S", "<Plug>(leap-backward)", { desc = "Leap Backward" })
set("xo", "s", leap_win_end, { desc = "Leap window" })
set("xo", "<C-s>", leap_win_end, { desc = "Leap window" })
-- set("o", "s", "<Plug>(leap)", { desc = "Leap window" })
-- set("o", "<C-s>", function() leap.leap({ offset = 1, inclusive = true }) end, { desc = "Leap" })

-- jump to lines
set("nxo", "|", function()
    local line = vim.fn.line(".")
    local top, bot = unpack({ math.max(1, line - 3), line + 3 })
    leap.leap({
        pattern = "\\v(%<" .. top .. "l|%>" .. bot .. "l)$",
        windows = { vim.fn.win_getid() },
        opts = { safe_labels = "" },
    })
end)

-- remote actions: `gs<leap>yiw`
set("nxo", "gs", function()
    remote.action({
        -- input = vim.fn.mode(true):match("o") and "" or "v" -- start visual mode by default
    })
end, { desc = "Leap Remote" })

-- Create remote versions of all a/i text objects by prepending `r` (`iw` becomes `riw`, etc.).
-- * yriw<leap> to yank word remotely,
-- * drip<leap> to delete paragraph remotely
-- * ysriw<leap><surround> to surround word remotely
for _, ai in ipairs({ "a", "i" }) do
    set("xo", "r" .. ai, function()
        -- A trick to avoid having to create separate mappings for each text
        -- object: when entering `ra`/`ri`, consume the next character, and
        -- create the input from that character concatenated to `a`/`i`.
        local ok, ch = pcall(vim.fn.getcharstr) -- pcall for handling <C-c>
        if not ok or (ch == vim.keycode("<esc>")) then return end
        -- example ch: `w`, `p` text-objs
        remote.action({ input = ai .. ch })
    end)
end

-- linewise operations:
-- `yrr<leap>` to yank line,
-- `drr<leap>` to delete line
set("o", "rr", function() remote.action({ input = vim.v.operator }) end)

-- Highly recommended: define a preview filter to reduce visual noise
-- and the blinking effect after the first keypress
-- (see `:h leap.opts.preview`).
-- For example, skip preview if the first character of the match is
-- whitespace or is in the middle of an alphabetic word:
leap.opts.preview = function(ch0, ch1, ch2)
    return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
end

-- Define equivalence classes for brackets and quotes,
-- in addition to -- the default whitespace group:
leap.opts.equivalence_classes = { " \t\r\n", [['"`]] } --  "([{", ")]}"

-- Use the traversal keys to repeat the previous motion without
-- explicitly invoking Leap:
-- require("leap.user").set_repeat_keys("<enter>", "<backspace>")

local function ft(key_specific_args)
    require("leap").leap(vim.tbl_deep_extend("keep", key_specific_args, {
        inputlen = 1,
        inclusive = true,
        opts = {
            -- Force autojump.
            labels = "",
            -- Match the modes where you don't need labels (`:h mode()`).
            safe_labels = vim.fn.mode(1):match("o") and "" or nil,
        },
    }))
end

-- A helper function making it easier to set "clever-f" behavior
-- (using f/F or t/T instead of ;/, - see the plugin clever-f.vim).
local clever = require("leap.user").with_traversal_keys
local clever_f, clever_t = clever("f", "F"), clever("t", "T")

set("nxo", "f", function() ft({ opts = clever_f }) end)
set("nxo", "F", function() ft({ backward = true, opts = clever_f }) end)
set("nxo", "t", function() ft({ offset = -1, opts = clever_t }) end)
set("nxo", "T", function() ft({ backward = true, offset = 1, opts = clever_t }) end)
