local ap = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local conds = require("nvim-autopairs.conds")
---@diagnostic disable-next-line: unused-local
local utils = require("nvim-autopairs.utils")
---@diagnostic disable-next-line: unused-local
local ts_conds = require("nvim-autopairs.ts-conds")

local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } } ---@type string[][] `{ { "(", ")" }, { "[", "]" }, { "{", "}" } }`

---@diagnostic disable-next-line: unused-local, unused-function
local function is_balanced_before_cursor(line, open, close, cursor)
    if cursor == nil or cursor < 1 then
        return true
    end

    local balance = 0
    for i = 1, cursor - 1, 1 do
        local char = line:sub(i, i)
        if char == open then
            balance = balance + 1
        elseif balance > 0 and char == close then
            balance = balance - 1
        end
    end
    return balance == 0
end

--- Fly Mode:
--- When closing pair, if the next character(s) is the same closing pair
--- character with optional leading whitespaces (including newlines),
--- move the cursor to the right of the existing closing pair.
---@param open string opening pair character
---@param close string closing pair character
---@return function(table): string -- keycodes mimicking user input in insert mode to be fed to nvim_feedkeys
---@diagnostic disable-next-line: unused-local
local function fly_mode(open, close)
    return function(opts)
        -- inline-fly: the current line has closing pair with optional leading spaces from cursor
        local padded_close = opts.line:sub(opts.col, #opts.line):match("^%s*%" .. close) ---@type string?
        if padded_close then
            -- vim.print("inline_fly: replacing_with: `" .. tostring(padded_close) .. "`")
            local keys = "<bs>" -- delete inserted closing char
            if #padded_close > 1 then -- has leading spaces
                keys = keys .. string.rep("<right>", #padded_close - 1)
            end
            keys = keys .. "<right>"
            -- vim.print("inline_fly: replacing_with: `" .. tostring(keys) .. "`")
            return keys
        end

        -- if cursor is not at EOL, don't fly
        local cursor_at_eol = opts.col > #opts.line
        if not cursor_at_eol then
            return ""
        end

        -- nextline-fly: the next line has closing pair with optional leading spaces
        local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
        local nextline_first_nonblank = vim.fn.getline(row + 1):match("^%s*%S") or ""
        -- vim.print("nextline_first_nonblank: `" .. tostring(nextline_first_nonblank) .. "`")
        if vim.trim(nextline_first_nonblank) == close then
            -- vim.print("nextline_fly: matched padded close on next line")
            local keys = "<bs>" -- delete inserted closing char
            if vim.trim(opts.line) == "" then
                keys = keys .. "<bs>" -- delete current line if empty
            end
            keys = keys .. "<down><home>" -- go to next line
            if #nextline_first_nonblank > 1 then -- has leading spaces
                keys = keys .. string.rep("<right>", #nextline_first_nonblank - 1)
            end
            keys = keys .. "<right>"
            -- vim.print("nextline_fly: replacing_with: `" .. tostring(keys) .. "`")
            return keys
        end

        -- nextnextline-fly:
        -- the next line is empty and the following line has closing pair with optional leading spaces
        local nextnextline_first_nonblank = vim.fn.getline(row + 2):match("^%s*%S") or ""
        if vim.trim(nextline_first_nonblank) == "" and vim.trim(nextnextline_first_nonblank) == close then
            -- vim.print("nextnextline_fly: matched padded close on next next line")
            local keys = "<bs>" -- delete inserted closing char
            if vim.trim(opts.line) == "" then
                keys = keys .. "<bs>" -- delete current line if empty
            end
            keys = keys .. "<down><home><bs><down><home>" -- delete blank line and go to next line
            if #nextnextline_first_nonblank > 1 then -- has leading spaces
                keys = keys .. string.rep("<right>", #nextnextline_first_nonblank - 1)
            end
            keys = keys .. "<right>"
            -- vim.print("nextnextline_fly: replacing_with: `" .. tostring(keys) .. "`")
            return keys
        end

        return "" -- no replacement
    end
end

--- Fly Mode
--- ( | )     press ) -> (  )|
--- ( |  )    press ) -> (    )|
--- [ |     ] press ) -> [       ]|
--- { |       press ) -> {
--- }                    }|
for _, bracket in pairs(brackets) do
    ---@diagnostic disable-next-line: unused-local
    local open, close = unpack(bracket)
    ap.add_rules({
        Rule(close, "")
            :set_end_pair_length(0) -- important
            :replace_endpair(fly_mode(open, close))
            :with_move(conds.none()),
    })
end

-- Add spaces between parentheses and brackets
-- (|) press space -> ( | )
ap.add_rules({
    Rule(" ", " ")
        :replace_endpair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col) -- `x|x`
            if -- don't add space if in markdown task list
                vim.bo[opts.bufnr].filetype == "markdown"
                and pair == "[]"
                and opts.line:sub(opts.col - 3, opts.col) == "- []"
            then
                return ""
            end
            -- only add space if cursor is within a pair
            local pairs = vim.tbl_map(table.concat, brackets)
            local cursor_within_pair = vim.tbl_contains(pairs, pair)
            return cursor_within_pair and " " or ""
        end)
        :with_del(function(opts)
            local context = opts.line:sub(opts.col - 2, opts.col + 2) -- `xx|xx`
            local pairs = vim.tbl_map(function(pair) --  "(  )", "{  }", "[  ]"
                return pair[1] .. "  " .. pair[2]
            end, brackets)
            return vim.tbl_contains(pairs, context)
        end)
        :with_pair(conds.done())
        :with_move(conds.none())
        :with_cr(conds.done()),
})

-- Move past period, commas, semicolons, and colons.
-- inserting these will expand abbreviations if applicable, and set the undo break
for _, punct in pairs({ ".", ",", ";", ":" }) do
    ap.add_rules({
        Rule(punct, punct)
            :with_move(function(opts)
                return opts.char == punct
            end)
            :replace_endpair(function(opts)
                local next_char = opts.line:sub(opts.col, opts.col)
                return next_char == punct and punct or ""
            end)
            :with_pair(conds.done())
            :with_del(conds.none())
            :with_cr(conds.none())
            :use_undo(true),
    })
end

-- Closure pipe
ap.add_rules({
    Rule("|", "|", { "rust" })
        :with_pair(conds.before_regex("%w+%(") and conds.after_text(")"))
        :with_move(conds.done())
        :with_cr(conds.none()),
})

-- Autopair angle bracket `<>` for generics and lifetimes
-- `Struct<|>`, `impl<|>`, `Vec<|>`, `collect::<|>`, `fn foo<|>()`
ap.add_rules({
    Rule("<", ">", { "rust", "typescript", "typescriptreact" })
        :with_pair(conds.before_regex("[%w:]+") and conds.not_before_char("<"))
        :with_cr(conds.none())
        :with_move(function(opts)
            return opts.char == opts.next_char
        end)
        :with_del(function(opts)
            return opts.line:sub(opts.col - 1, opts.col) ~= "<<"
        end),
})

-- Rust: special strings (raw, byte)
local rust_special_strings_prefixes = { "r", "b", "br" } ---@type string[]
local rust_special_strings = { { "b'", "'" } } ---@type string[][]
for _, prefix in pairs(rust_special_strings_prefixes) do
    for i = 0, 6 do
        local hashes = string.rep("#", i)
        table.insert(rust_special_strings, { prefix .. hashes .. '"', '"' .. hashes })
    end
end
ap.add_rules(vim.tbl_map(function(pair)
    local open, close = unpack(pair)
    return Rule(open, close, { "rust" })
        :with_move(function(opts)
            return opts.char == close:sub(1, 1)
        end)
        :with_del(function(opts)
            return opts.line:sub(opts.col - #close, opts.col - 1) ~= close
        end)
        :with_cr(conds.none())
end, rust_special_strings))

-- Templating: askama, django, jinja2, etc
ap.add_rules({
    Rule("%", "%", { "html", "htmldjango" })
        :with_pair(conds.before_text("{"))
        :with_move(conds.none())
        :with_del(conds.none())
        :with_cr(conds.none()),
})
