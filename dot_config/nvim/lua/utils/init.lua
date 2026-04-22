local M = {}

M.keymap = require("utils.keymap")

--- Better escape: preserve cursor position
function M.escape() return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<right><esc>" or "<esc>" end

--- normal! zz
function M.centerscreen() vim.cmd("normal! zz") end

--- Better alternate buf
--- `<C-^>`, `<C-6>`, `:e #` work great, but two issues: (* means active buffer)
---    - open A, B, C* -> `:bwipe` (B*) -> trigger -> error
---    - open A, B, C* -> `:bdele` (B*) -> trigger -> re-opens C
---  Improved <C-^>:  (* means active buffer)
---    - open A, B, C* -> `:bwip` (B*) -> trigger (A*) -> trigger (B*)
---    - open A, B, C* -> `:bdel` (B*) -> trigger (C*) -> trigger (B*)
function M.alt_buf()
    if vim.bo[0].buftype ~= "" then return end
    local success, _ = pcall(vim.cmd.e, "#")
    if success then
        -- vim.notify("edit #")
        return
    end
    local bufs = vim.tbl_filter(function(info)
        return vim.bo[info.bufnr].buftype == "" -- normal buffers only. :h buftype
    end, vim.fn.getbufinfo({ buflisted = 1 }))

    table.sort(bufs, function(a, b) return a.lastused > b.lastused end)
    if #bufs == 1 then
        vim.notify("No alternate buffer", vim.log.levels.WARN)
    else
        vim.notify("alt buf")
        vim.api.nvim_win_set_buf(0, bufs[2].bufnr)
    end
end

--- Cmdline-mode: smart cursor nav to next word
function M.cmode_next_word()
    local cmd, pos = vim.fn.getcmdline(), vim.fn.getcmdpos()
    if pos > #cmd then return "" end
    local after = cmd:sub(pos)
    local offset = 1
    if after:match("^[%w_]") then -- word
        offset = after:match("^[%w_]+()")
    elseif after:match("^[^%w_%s]") then -- special chars
        offset = after:match("^[^%w_%s]+()")
    end
    local ws_offset = after:sub(offset):match("^%s+()") or 1 -- skip whitespace
    return string.rep("<Right>", offset + ws_offset - 2)
end
--- Cmdline-mode: smart cursor nav to prev word
function M.cmode_prev_word()
    local cmd, pos = vim.fn.getcmdline(), vim.fn.getcmdpos()
    if pos == 1 then return "" end
    local before = cmd:sub(1, pos - 1)
    local trimmed = before:gsub("%s+$", "") -- Skip trailing whitespace
    if trimmed:match("[%w_]$") then -- word
        trimmed = trimmed:gsub("[%w_]+$", "")
    elseif #trimmed > 0 then -- special chars
        trimmed = trimmed:gsub("[^%w_%s]+$", "")
    end
    return string.rep("<Left>", #before - #trimmed)
end

function M.toggle_gutter()
    local enabled = vim.wo.number
    vim.wo.number = not enabled
    vim.wo.relativenumber = not enabled
    vim.wo.signcolumn = enabled and "no" or "yes"
    vim.wo.foldcolumn = "0"
    vim.wo.scrolloff = 10
    vim.wo.sidescrolloff = 10
end
function M.toggle_conceal()
    vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0
    vim.notify(
        "Conceal " .. (vim.wo.conceallevel == 2 and "Enabled" or "Disabled"),
        vim.log.levels.INFO
    )
end
function M.toggle_wrap()
    vim.wo.wrap = not vim.wo.wrap
    vim.notify("Wrap " .. (vim.wo.wrap and "Enabled" or "Disabled"), vim.log.levels.INFO)
end
function M.toggle_spell()
    vim.wo.spell = not vim.wo.spell
    vim.notify("Spelling " .. (vim.wo.spell and "Enabled" or "Disabled"))
end

local function remove_trailing_whitespace()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, cursor)
end
local function remove_eof_blanklines()
    local n_lines = vim.api.nvim_buf_line_count(0)
    local last_nonblank = vim.fn.prevnonblank(n_lines)
    if last_nonblank < n_lines then
        vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, {})
    end
end
function M.trim_buf()
    remove_trailing_whitespace()
    remove_eof_blanklines()
end

function M.yank_location()
    local path = string.sub(vim.fn.expand("%:p"), #vim.fn.getcwd() + 2)
    local linenr = vim.api.nvim_win_get_cursor(0)[1]
    local location = string.format("%s:%d", path, linenr)
    vim.fn.setreg("+", location)
end
---@diagnostic disable-next-line: unused-local, unused-function
function M.yank_location_and_line()
    local path = string.sub(vim.fn.expand("%:p"), #vim.fn.getcwd() + 2)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local cursor = string.format("%d:%d", row, col)
    local line = vim.trim(vim.api.nvim_get_current_line())
    vim.fn.setreg("+", path .. ":" .. cursor .. "\n" .. line)
end

function M.repeatable(next_action, prev_action)
    vim.pack.add({
        "gh:kiyoon/repeatable-move.nvim",
        "gh:nvim-treesitter/nvim-treesitter-textobjects",
    })
    return require("repeatable_move").make_repeatable_move_pair(next_action, prev_action)
end

local function with_warning(next, prev)
    local function f(action)
        return function()
            local ok, _ = pcall(action)
            if ok then
                M.centerscreen()
            else
                vim.notify("No more items", vim.log.levels.INFO)
            end
        end
    end
    return f(next), f(prev)
end

local cnext, cprev = M.repeatable(with_warning(vim.cmd.cnext, vim.cmd.cprev))
local lnext, lprev = M.repeatable(with_warning(vim.cmd.lnext, vim.cmd.lprev))

--- Quickfix/locationlist & diagnostic utils
M.qf = {
    cprev = cprev,
    cnext = cnext,
    lprev = lprev,
    lnext = lnext,
    xprev = function()
        local quicker = require("quicker")
        if quicker.is_open() then -- qflist
            ---@diagnostic disable-next-line: missing-parameter
            M.qf.cprev()
        elseif quicker.is_open(0) then -- loclist
            ---@diagnostic disable-next-line: missing-parameter
            M.qf.lprev()
        end
    end,
    xnext = function()
        local quicker = require("quicker")
        if quicker.is_open() then -- qflist
            ---@diagnostic disable-next-line: missing-parameter
            M.qf.cnext()
        elseif quicker.is_open(0) then -- loclist
            ---@diagnostic disable-next-line: missing-parameter
            M.qf.lnext()
        end
    end,
    cclose = function()
        local quicker = require("quicker")
        quicker.close()
        quicker.close({ loclist = true })
    end,
    toggle_buf_diagnostic = function()
        M.cclose()
        vim.diagnostic.setloclist({
            severity = { min = vim.diagnostic.severity.WARN },
            title = "Buffer Diagnostics",
            open = false,
        })
        require("quicker").open({ loclist = true })
        vim.cmd.cfirst()
    end,
    toggle_workspace_diagnostic = function()
        M.cclose()
        vim.diagnostic.setqflist({
            severity = { min = vim.diagnostic.severity.WARN },
            title = "Workspace Diagnostics",
            open = false,
        })
        require("quicker").open()
        vim.cmd.cfirst()
    end,
    toggle_info_diagnostic = function()
        M.cclose()
        vim.diagnostic.setqflist({
            severity = { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT },
            title = "Hint & Info Diagnostics",
            open = false,
        })
        require("quicker").open()
        vim.cmd.cfirst()
    end,
}

return M
