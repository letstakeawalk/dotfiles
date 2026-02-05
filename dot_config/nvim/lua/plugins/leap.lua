return {
    url = "https://codeberg.org/andyg/leap.nvim",
    lazy = false, -- pluging lazyloads itself
    config = function()
        local leap = require("leap")
        leap.setup({
            safe_labels = "stfnu/SNTGMFLHUZ?",
            labels = "stfneiokhldwmbuyvrgaqpcxzj/STFNEIOKHLDWMBUYVRGAQPCXZJ?",
        })
        -- stylua: ignore start
        vim.keymap.set( {"n", "x"}, "s", "<Plug>(leap-forward)",  { desc = "Leap Forward" })
        vim.keymap.set( {"n", "x"}, "S", "<Plug>(leap-backward)", { desc = "Leap window" })
        vim.keymap.set( {"o"},      "s", "<Plug>(leap)",          { desc = "Leap window" })
        -- stylua: ignore end

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
        leap.opts.equivalence_classes = { " \t\r\n", "'\"`" } --  "([{", ")]}"

        -- Use the traversal keys to repeat the previous motion without
        -- explicitly invoking Leap:
        require("leap.user").set_repeat_keys("<enter>", "<backspace>")

        -- Return an argument table for `leap()`, tailored for f/t-motions.
        local function as_ft(key_specific_args)
            local common_args = {
                inputlen = 1,
                inclusive = true,
                -- To limit search scope to the current line:
                -- pattern = function (pat) return '\\%.l'..pat end,
                opts = {
                    labels = "", -- force autojump
                    safe_labels = vim.fn.mode(1):match("[no]") and "" or nil, -- [1]
                },
            }
            return vim.tbl_deep_extend("keep", common_args, key_specific_args)
        end

        local clever = require("leap.user").with_traversal_keys -- [2]
        local clever_f = clever("f", "F")
        local clever_t = clever("t", "T")

        for key, key_specific_args in pairs({
            f = { opts = clever_f },
            F = { backward = true, opts = clever_f },
            t = { offset = -1, opts = clever_t },
            T = { backward = true, offset = 1, opts = clever_t },
        }) do
            vim.keymap.set({ "n", "x", "o" }, key, function()
                require("leap").leap(as_ft(key_specific_args))
            end)
        end

        -- jump to lines
        vim.keymap.set({ "n", "x", "o" }, "|", function()
            local line = vim.fn.line(".")
            -- Skip 3-3 lines around the cursor.
            local top, bot = unpack({ math.max(1, line - 3), line + 3 })
            require("leap").leap({
                pattern = "\\v(%<" .. top .. "l|%>" .. bot .. "l)$",
                windows = { vim.fn.win_getid() },
                opts = { safe_labels = "" },
            })
        end)

        -- remote actions: `gs<leap>yiw`
        vim.keymap.set({ "n", "x", "o" }, "gs", function()
            require("leap.remote").action({
                -- start visual mode by default
                -- input = vim.fn.mode(true):match("o") and "" or "v",
            })
        end)

        -- Create remote versions of all a/i text objects by prepending `r` (`iw` becomes `riw`, etc.).
        --  yriw<leap> to yank word remotely,
        --  drip<leap> to delete paragraph remotely
        --  ysriw<leap><surround> to surround word remotely
        for _, ai in ipairs({ "a", "i" }) do
            vim.keymap.set({ "x", "o" }, "r" .. ai, function()
                -- A trick to avoid having to create separate mappings for each text
                -- object: when entering `ra`/`ri`, consume the next character, and
                -- create the input from that character concatenated to `a`/`i`.
                local ok, ch = pcall(vim.fn.getcharstr) -- pcall for handling <C-c>
                if not ok or (ch == vim.keycode("<esc>")) then
                    return
                end
                -- example ch: `w`, `p` text-objs
                require("leap.remote").action({ input = ai .. ch })
            end)
        end
        -- linewise operations:
        -- `yrr<leap>` to yank line,
        -- `drr<leap>` to delete line
        vim.keymap.set("o", "rr", function()
            require("leap.remote").action({ input = vim.v.operator })
        end)
    end,
}
