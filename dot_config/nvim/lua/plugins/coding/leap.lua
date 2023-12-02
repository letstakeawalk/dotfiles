return {
    "ggandor/leap.nvim",
    dependencies = { "ggandor/leap-spooky.nvim", "ggandor/flit.nvim" },
    keys = { "s", "S", "f", "F", "t", "T", "<leader>k", "<leader>h" },
    event = "BufRead",
    config = function()
        local leap = require("leap")
        leap.setup({})
        leap.set_default_keymaps()
        leap.opts.special_keys.prev_target = { "<s-cr>", "," }

        local flit = require("flit")
        flit.setup({})

        local spooky = require("leap-spooky")
        spooky.setup({
            affixes = {
                -- These will generate mappings for all native text objects, like:
                -- (ir|ar|iR|aR|im|am|iM|aM){obj}.
                -- Special line objects will also be added, by repeating the affixes.
                -- E.g.
                --   `yrr<leap>` and `ymm<leap>` will yank a line in the current window.
                --   `drr<leap>` and `dmm<leap>` will delete a line in the current window.
                -- You can also use 'rest' & 'move' as mnemonics.
                remote = { window = "r", cross_window = "R" },
                magnetic = { window = "m", cross_window = "M" },
            },
            -- Defines text objects like `riw`, `raw`, etc., instead of targets.vim-style `irw`, `arw`.
            prefix = true,
            -- If this option is set to true, the yanked text will automatically be pasted
            -- at the cursor position if the unnamed register is in use.
            paste_on_remote_yank = false,
        })

        ---linewise leap motion in one direction
        ---@param winid integer
        ---@param upward boolean
        ---@return table|nil
        local function get_line_starts(winid, upward)
            local wininfo = vim.fn.getwininfo(winid)[1]
            local cur_line = vim.fn.line(".") ---@cast cur_line integer

            -- Get targets.
            local targets = {}
            local lnum = upward and wininfo.topline or cur_line ---@cast lnum integer

            local end_line = upward and cur_line or wininfo.botline
            while lnum <= end_line do
                local fold_end = vim.fn.foldclosedend(lnum)
                -- Skip folded ranges.
                if fold_end ~= -1 then
                    lnum = fold_end + 1
                else
                    if lnum ~= cur_line then
                        table.insert(targets, { pos = { lnum, 1 } })
                    end
                    lnum = lnum + 1
                end
            end
            -- Sort them by vertical screen distance from cursor.
            local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
            local function screen_rows_from_cur(t)
                local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
                return math.abs(cur_screen_row - t_screen_row)
            end
            table.sort(targets, function(t1, t2) return screen_rows_from_cur(t1) < screen_rows_from_cur(t2) end)

            if #targets >= 1 then
                return targets
            end
        end

        ---@param upward boolean
        local function leap_to_line(upward)
            local winid = vim.api.nvim_get_current_win()
            leap.leap({
                target_windows = { winid },
                targets = get_line_starts(winid, upward),
            })
        end

        vim.keymap.set("n", "<leader>k", function() leap_to_line(false) end, { desc = "Leap downward" })
        vim.keymap.set("n", "<leader>h", function() leap_to_line(true) end, { desc = "Leap upward" })

        local nord = require("utils.nord")
        vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = nord.c00_blk, bg = nord.c13_ylw, bold = true })
    end,
}
