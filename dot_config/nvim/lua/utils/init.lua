utils = vim.defaulttable()

--- Wrapper around `vim.ui.input()` to abort if the input is empty string or nil.
---@param opts { prompt: string|nil, default: string|nil, completion: string|nil, highlight: fun() }
---@param on_confirm function(input: string|nil): nil
function utils.ui.input(opts, on_confirm)
    vim.ui.input(opts, function(input)
        if input == nil or #utils.strings.strip(input) == 0 then
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
function utils.strings.strip(str)
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
