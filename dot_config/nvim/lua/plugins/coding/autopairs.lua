return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dev = false,
    config = function()
        local ap = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local conds = require("nvim-autopairs.conds")
        local utils = require("nvim-autopairs.utils")
        -- local ts_conds = require("nvim-autopairs.ts-conds")

        -- TODO: flymode same line jump if bracket balanced around
        -- (this| is a test line) --> press ) at | --> (this is a test line)|
        -- (this| is a test line --> press ) at | --> (this)| is a test line

        ap.setup({
            check_ts = true,
            ts_config = {},
            fast_wrap = {
                map = "<C-f>",
                before_key = "k",
                after_key = "h",
                cursor_pos_before = false,
            },
            -- ignored_prev_char = "[\\]",
            ignored_prev_char = "",
            enable_check_bracket_line = false,
            enable_abbr = true,
        })

        -- Add spaces between parentheses and brackets
        ap.add_rules({
            Rule(" ", " ")
                :with_pair(conds.done())
                :replace_endpair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    if vim.tbl_contains({ "()", "{}", "[]" }, pair) then
                        return " " -- it return space here
                    end
                    return "" -- return empty
                end)
                :with_move(conds.none())
                :with_cr(conds.none())
                :with_del(function(opts)
                    local col = vim.api.nvim_win_get_cursor(0)[2]
                    local context = opts.line:sub(col - 1, col + 2)
                    return vim.tbl_contains({ "(  )", "{  }", "[  ]" }, context)
                end),
        })

        -- `( | )` press ) at | --> `(  )|`
        local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
        for _, bracket in pairs(brackets) do
            ap.add_rules({
                Rule("", " " .. bracket[2])
                    :with_pair(conds.none())
                    :with_move(function(opts)
                        return opts.char == bracket[2]
                        -- for backslash escape
                        -- local prev = opts.line:sub(opts.col - 1, opts.col - 1)
                        -- return not prev:match(ap.config.ignored_prev_char) and opts.char == bracket[2]
                    end)
                    :with_del(conds.none())
                    :use_key(bracket[2]),
            })
        end

        -- Ignore auto pair when prev char is \
        ap.get_rule("("):with_pair(conds.not_before_regex("\\"))
        ap.get_rule("["):with_pair(conds.not_before_regex("\\"))
        ap.get_rule("{"):with_pair(conds.not_before_regex("\\"))
        ap.get_rule("'")[1]:with_pair(conds.not_before_regex("\\"))
        ap.get_rule('"')[1]:with_pair(conds.not_before_regex("\\"))
        ap.get_rule("'")[2]:with_pair(conds.not_before_regex("\\"))
        ap.get_rule('"')[2]:with_pair(conds.not_before_regex("\\"))

        -- Move past commas, semicolons, and colons
        for _, punct in pairs({ ",", ";", ":" }) do
            ap.add_rules({
                Rule("", punct)
                    :with_move(function(opts) return opts.char == punct end)
                    :with_pair(conds.none())
                    :with_del(conds.none())
                    :with_cr(conds.none())
                    :use_key(punct),
            })
        end

        -- Rust: autopair '<' angle bracket after a word for generic and lifetime
        -- Checks if bracket chars are balanced around specific postion.
        local function is_brackets_balanced_around_position(line, open_char, close_char, col)
            local balance = 0
            for i = 1, #line, 1 do
                local c = line:sub(i, i)
                if c == open_char then
                    balance = balance + 1
                elseif balance > 0 and c == close_char then
                    balance = balance - 1
                    if col <= i and balance == 0 then
                        break
                    end
                end
            end
            return balance == 0
        end
        ap.add_rules({
            Rule("<", ">", { "rust" }):with_pair(conds.before_regex("[%w:]+")):with_move(function(opts)
                if opts.char == opts.rule.end_pair then
                    local is_balanced = is_brackets_balanced_around_position(opts.line, opts.rule.start_pair, opts.char, opts.col)
                    return is_balanced
                end
                return false
            end),
        })

        -- Rust: raw string
        ap.add_rules({
            Rule('r#"', '"#', { "rust" })
                :with_move(function(opts) return opts.char == '"' end)
                :with_del(conds.none())
                :with_cr(conds.none())
                :use_key('"'),
        })

        -- Fly Mode: multiline jump close bracket
        -- https://github.com/windwp/nvim-autopairs/issues/167#issuecomment-1502559849
        local function multiline_close_jump(open, close)
            return Rule(close, "")
                :with_pair(function()
                    local row, col = utils.get_cursor(0)
                    local line = utils.text_get_current_line(0)

                    if #line ~= col then --not at EOL
                        return false
                    end

                    local unclosed_count = 0
                    for c in line:gmatch("[\\" .. open .. "\\" .. close .. "]") do
                        if c == open then
                            unclosed_count = unclosed_count + 1
                        end
                        if unclosed_count > 0 and c == close then
                            unclosed_count = unclosed_count - 1
                        end
                    end
                    if unclosed_count > 0 then
                        return false
                    end

                    local nextrow = row + 1

                    if nextrow < vim.api.nvim_buf_line_count(0) and vim.regex("^\\s*" .. close):match_line(0, nextrow) then
                        return true
                    end
                    return false
                end)
                :with_move(conds.none())
                :with_cr(conds.none())
                :with_del(conds.none())
                :set_end_pair_length(0)
                :replace_endpair(function(opts)
                    -- local cleanup = "" == opts.line:match("^%s*(.-)%s*$") and "dd" or "xj" -- delete current line if emptly else delete closing pair
                    local cleanup = "xj"
                    local row, _ = utils.get_cursor(0)
                    local action = vim.regex("^" .. close):match_line(0, row + 1) and "0a" or ("0f%sa"):format(opts.char)
                    return ("<esc>%s%s"):format(cleanup, action)
                end)
        end
        ap.add_rules({
            multiline_close_jump("(", ")"),
            multiline_close_jump("[", "]"),
            multiline_close_jump("{", "}"),
        })
    end,
}

--[[
--========================================================
-- OK
--========================================================
{
    |
}*
pressing } at | flies to *

{
    |
}*;
pressing } at | flies to *

{(
    |
)*}
pressing ) at | flies to *

{{
    |
}*}
pressing } at | flies to *

    {{
        |
    }*}
pressing } at | flies to *

local t = {
    y = {
        |
    }*,
}
pressing } at | flies to *

--========================================================
-- NOT OK
--========================================================

{(
    |
)*}
pressing } at | doesn't fly

{
    |

}
pressing } at | doesn't fly

{
    hello();|
    world();
}
pressing } at | doesn't fly

NOTE: Currenly only checks the next row. Needs to check more rows.
]]
