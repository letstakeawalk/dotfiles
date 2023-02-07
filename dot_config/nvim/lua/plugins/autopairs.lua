return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		-- enable = false,
		config = function()
			local ap = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local conds = require("nvim-autopairs.conds")
			local utils = require("nvim-autopairs.utils")

			ap.setup({
				check_ts = true,
				ts_config = {},
				fast_wrap = {
					map = "<C-p>",
				},
				-- ignored_prev_char = "[\\]",
				ignored_prev_char = "",
				enable_check_bracket_line = false,
			})

			-- local ts_conds = require("nvim-autopairs.ts-conds")

			-- Add spaces between parentheses and brackets
			local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
			ap.add_rules({
				Rule(" ", " "):with_pair(function(opts)
					local pair = opts.line:sub(opts.col - 1, opts.col)
					return vim.tbl_contains({
						brackets[1][1] .. brackets[1][2],
						brackets[2][1] .. brackets[2][2],
						brackets[3][1] .. brackets[3][2],
					}, pair)
				end):with_del(function(opts)
					local col = vim.api.nvim_win_get_cursor(0)[2]
					local context = opts.line:sub(col - 1, col + 2)
					return vim.tbl_contains({
						brackets[1][1] .. "  " .. brackets[1][2],
						brackets[2][1] .. "  " .. brackets[2][2],
						brackets[3][1] .. "  " .. brackets[3][2],
					}, context)
				end),
			})
			-- `( | )` press ) at | --> `(  )`
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
						:with_move(function(opts)
							return opts.char == punct
						end)
						:with_pair(function()
							return false
						end)
						:with_del(function()
							return false
						end)
						:with_cr(function()
							return false
						end)
						:use_key(punct),
				})
			end

			-- Rust: autopair '<' angle bracket after a word for generic and lifetime
			-- Checks if bracket chars are balanced around specific postion.
			---@param line string
			---@param open_char string
			---@param close_char string
			---@param col integer position
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
				Rule("<", ">", { "rust" }):with_pair(conds.before_regex("%w")):with_move(function(opts)
					if opts.char == opts.rule.end_pair then
						local is_balanced =
							is_brackets_balanced_around_position(opts.line, opts.rule.start_pair, opts.char, opts.col)
						return is_balanced
					end
					return false
				end),
			})

			-- multiline jump close bracket
			-- NOTE(#1234): revisit if fly mode needed
			local function multiline_close_jump(open, close)
				return Rule(close, "")
					:with_pair(function()
						local row, col = utils.get_cursor()
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
						if
							nextrow < vim.api.nvim_buf_line_count(0)
							and vim.regex("^\\s*" .. close):match_line(0, nextrow)
						then
							return true
						end
						return false
					end)
					:with_move(conds.none())
					:with_cr(conds.none())
					:with_del(conds.none())
					:set_end_pair_length(0)
					:replace_endpair(function()
						return "<esc>xEa"
					end)
			end

			ap.add_rules({
				multiline_close_jump("(", ")"),
				multiline_close_jump("[", "]"),
				multiline_close_jump("{", "}"),
			})
		end,
	},
	{
		"jiangmiao/auto-pairs",
		-- lazy = false,
		-- event = "InsertEnter",
		enabled = false,
		config = function()
			vim.g.AutoPairsFlyMode = 1 -- default 0
			vim.g.AutoPairsShortcutFastWrap = "<C-p>" -- default <A-e>
			vim.g.AutoPairsShortcutJump = "<C-n>" -- default <A-n>
			vim.g.AutoPairsShortcutBackInsert = "<C-f>" -- default <A-b>

			-- vim.cmd([[au FileType rust let b:AutoPairs = AutoPairsDefine({"\w\zs<'": ''})]])

			-- FastWrap examble
			-- input:
			-- a[(3|)]  input ]
			-- a[(3)]|
			--
			-- (|)[foo, bar()]  input <C-p>
			-- ([foo, bar()])
			--
			-- input:
			-- {
			--   hello();|   input <C-p>
			--   world();
			-- }
			-- output:
			-- {
			--   hello();    input <C-p>
			--   world();
			-- }|
		end,
	},
}
