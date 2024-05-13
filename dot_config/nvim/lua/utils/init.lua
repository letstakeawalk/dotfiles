local utils = vim.defaulttable()

---@param name string
---@param opts vim.api.keyset.create_augroup
---@return integer
function utils.create_augroup(name, opts)
    return vim.api.nvim_create_augroup("HRB_" .. name, opts)
end

--- Wrapper around `vim.ui.input()` to abort if the input is empty string or nil.
---@param opts { prompt: string|nil, default: string|nil, completion: string|nil, highlight: fun() }
---@param on_confirm function(input: string|nil): nil
function utils.ui.input(opts, on_confirm)
    vim.ui.input(opts, function(input)
        if input == nil or #vim.trim(input) == 0 then
            return
        end
        on_confirm(input)
    end)
end

--- Edit the `config` param to center the floating window in the current window.
---@param config { row: number, col: number, width: number, height: number, relative: string|nil }
---@return { row: number, col: number, width: number, height: number, relative: string|nil }
function utils.ui.config_win_center(config)
    local win_width = vim.api.nvim_win_get_width(0)
    local win_height = vim.api.nvim_win_get_height(0)
    config.row = math.floor((win_height - config.height) / 2)
    config.col = math.floor((win_width - config.width) / 2)
    config.relative = "win"
    return config
end

--- Edit the `config` param to center the floating window in the editor.
---@param config { row: number, col: number, width: number, height: number, relative: string|nil }
---@return { row: number, col: number, width: number, height: number, relative: string|nil }
function utils.ui.config_editor_center(config)
    local status_height = 1
    local cmd_height = vim.api.nvim_get_option("cmdheight")
    local editor_height = vim.api.nvim_get_option("lines") - status_height - cmd_height
    local editor_width = vim.api.nvim_get_option("columns")
    config.row = math.floor((editor_height - config.height) / 2)
    config.col = math.floor((editor_width - config.width) / 2)
    config.relative = "editor"
    return config
end

---@return number: height of tabline (0 or 1)
function utils.ui.tabline_height()
    local showtabline = vim.api.nvim_get_option("showtabline")
    if showtabline == 0 then
        return 0
    elseif showtabline == 1 then
        local tabline = vim.api.nvim_get_option("tabline")
        if tabline == nil or #tabline == 0 then
            return 0
        end
    end
    return 1
end

---@return number: height of statusline (0 or 1)
function utils.ui.statusline_height()
    local laststatus = vim.api.nvim_get_option("laststatus")
    if laststatus == 0 then
        return 0
    elseif laststatus == 1 and #vim.api.nvim_tabpage_list_wins(0) < 2 then
        return 0
    end
    return 1
end

--- Execute a <Plug> command
---@param command string: the command to execute without the "<Plug>" prefix
function utils.exec.plug(command)
    local keys = "<Plug>" .. command
    local escaped = vim.api.nvim_replace_termcodes(keys, true, true, true)
    vim.api.nvim_feedkeys(escaped, "n", false)
end

--- Strip leading and trailing whitespaces from a string.
---@param str string
---@return string
function utils.strings.trim(str)
    return string.match(str, "^%s*(.-)%s*$")
end

--- Print all buffers
function utils.print_all_buffers()
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        local name = vim.api.nvim_buf_get_name(buf)
        local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
        local listed = vim.api.nvim_buf_get_option(buf, "buflisted")
        local hidden = vim.api.nvim_buf_get_option(buf, "buftype") == "nofile"
        vim.print(string.format("%d: %s, ft: %s, listed: %s, hidden: %s", buf, name, filetype, listed, hidden))
    end
end

return utils

-- TODO: add current line to quickfix list
-- :h setqflist()

-- To send the current line to the quickfix list in Neovim, you need to first capture the details of the current line,
-- such as the filename, line number, and optionally, the column and text of the line.
-- Then, you can create an entry and add it to the quickfix list using `vim.fn.setqflist()`.
-- Here's how you can do it with Lua:
--
-- ```lua
-- -- Get the current buffer number and line number
-- local bufnr = vim.api.nvim_get_current_buf()
-- local lnum = vim.api.nvim_win_get_cursor(0)[1]  -- Index 1 is the line number
-- local col = vim.api.nvim_win_get_cursor(0)[2]  -- Index 2 is the column number
-- local filename = vim.api.nvim_buf_get_name(bufnr)
-- local line_text = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1]  -- 0-based index for lines
--
-- -- Create a quickfix list entry
-- local qf_entry = {{
--     bufnr = bufnr,
--     lnum = lnum,
--     col = col + 1,  -- Convert from 0-based to 1-based index
--     text = line_text,
--     filename = filename
-- }}
--
-- -- Add entry to the quickfix list and open it
-- vim.fn.setqflist(qf_entry, "r")  -- 'r' to replace the current list
-- vim.cmd('copen')  -- Open the quickfix window
-- ```
--
-- This Lua snippet will grab the current buffer number and line number, build a quickfix entry,
-- and then add this entry to the quickfix list, replacing any existing entries. Finally, it opens the quickfix window to show the list containing the current line.
