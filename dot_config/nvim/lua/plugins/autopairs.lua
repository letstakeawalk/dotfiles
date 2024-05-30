return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local ap = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local conds = require("nvim-autopairs.conds")
        ---@diagnostic disable-next-line: unused-local
        local utils = require("nvim-autopairs.utils")
        ---@diagnostic disable-next-line: unused-local
        local ts_conds = require("nvim-autopairs.ts-conds")

        ap.setup({
            check_ts = true,
            ts_config = {},
            fast_wrap = {
                map = "<C-f>",
                chars = { "{", "[", "(", "<", '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,%?;]]=],
                before_key = "k",
                after_key = "h",
                cursor_pos_before = false,
            },
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
        ap.get_rule(" ").not_filetypes = { "markdown" }

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
        ap.get_rule("("):with_pair(conds.not_before_regex("\\")):with_move(conds.not_before_regex("\\"))
        ap.get_rule("["):with_pair(conds.not_before_regex("\\")):with_move(conds.not_before_regex("\\"))
        ap.get_rule("{"):with_pair(conds.not_before_regex("\\")):with_move(conds.not_before_regex("\\"))
        ap.get_rule("'")[1]:with_pair(conds.not_before_regex("\\")):with_move(conds.not_before_regex("\\"))
        ap.get_rule("'")[2]:with_pair(conds.not_before_regex("\\")):with_move(conds.not_before_regex("\\"))
        ap.get_rule('"')[1]:with_pair(conds.not_before_regex("\\")):with_move(conds.not_before_regex("\\"))
        ap.get_rule('"')[2]:with_pair(conds.not_before_regex("\\")):with_move(conds.not_before_regex("\\"))

        -- Move past commas, semicolons, and colons
        for _, punct in pairs({ ",", ";", ":" }) do
            ap.add_rules({
                Rule("", punct)
                    :with_move(function(opts)
                        return opts.char == punct
                    end)
                    :with_pair(conds.none())
                    :with_del(conds.none())
                    :with_cr(conds.none())
                    :use_key(punct),
            })
        end

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
        -- Autopair '<' angle bracket after a word for generic and lifetime (Rust).
        ap.add_rules({
            Rule("<", ">", { "rust", "typescript", "typescriptreact" })
                :with_pair(conds.before_regex("[%w:<]+"))
                :with_cr(conds.none())
                :with_move(function(opts)
                    return opts.char == opts.rule.end_pair
                        and is_brackets_balanced_around_position(opts.line, opts.rule.start_pair, opts.char, opts.col)
                end),
        })

        -- Rust: raw string
        ap.add_rules({
            Rule('r#"', '"#', { "rust" })
                :with_move(function(opts)
                    return opts.char == '"'
                end)
                :with_del(conds.none())
                :with_cr(conds.none())
                :use_key('"'),
            Rule('b"', '"', { "rust" })
                :with_move(function(opts)
                    return opts.char == '"'
                end)
                :with_del(conds.none())
                :with_cr(conds.none())
                :use_key('"'),
            Rule("b'", "'", { "rust" })
                :with_move(function(opts)
                    return opts.char == "'"
                end)
                :with_del(conds.none())
                :with_cr(conds.none())
                :use_key("'"),
        })

        -- Rust: closure pipe
        ap.add_rules({
            Rule("|", "|", { "rust" })
                :with_pair(conds.before_regex("%w+%(") and conds.after_text(")"))
                :with_move(conds.done())
                :with_cr(conds.none()),
        })
    end,
}
