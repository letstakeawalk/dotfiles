local M = {}

-- stylua: ignore start
local date_format    = "%Y-%m-%d"
local date_pattern   = "%d%d%d%d%-%d%d%-%d%d"
local checked        = "- [x]"
local unchecked      = "- [ ]"
local canceled_tag   = "[canceled::%s]"
local completion_tag = "[completion::%s]"
local due_tag        = "[due::%s]"
local scheduled_tag  = "[scheduled::%s]"
local started_tag    = "[started::%s]"
local priority_tag   = "[priority::%s]"
local project_tag    = "[project::%s]"
local list_pattern       = "- [^%[%]]"
local task_pattern       = "- %[.%]"
local checked_pattern    = "- %[x%]"
local unchecked_pattern  = "- %[ %]"
local canceled_pattern   = "%s*%[canceled::" .. date_pattern .. "%]"
local completion_pattern = "%s*%[completion::" .. date_pattern .. "%]"
local due_pattern        = "%s*%[due::" .. date_pattern .. "%]"
local scheduled_pattern  = "%s*%[scheduled::" .. date_pattern .. "%]"
local started_pattern    = "%s*%[started::" .. date_pattern .. "%]"
local priority_pattern   = "%s*%[priority::%d%]"
local project_pattern    = "%s*%[project::[%w%-_%s]+%]"
-- stylua: ignore end

M.toggle_task = function()
    local line = vim.api.nvim_get_current_line()
    if line:match(task_pattern) then
        if line:match(checked_pattern) then
            line = line:gsub(checked_pattern, unchecked, 1)
        else
            line = line:gsub(unchecked_pattern, checked, 1)
        end
    elseif line:match(list_pattern) then
        line = line:gsub(list_pattern, unchecked, 1)
    else
        line = string.format("%s %s", unchecked, line)
    end
    vim.api.nvim_set_current_line(line)
end

M.toggle_started = function()
    local line = vim.api.nvim_get_current_line()
    if line:match(task_pattern) then
        if line:match(started_pattern) then
            line = line:gsub(started_pattern, "", 1)
        else
            local tag = started_tag:format(os.date(date_format))
            line = string.format("%s %s", line, tag)
        end
        vim.api.nvim_set_current_line(line)
    end
end

M.toggle_completion = function()
    local line = vim.api.nvim_get_current_line()
    if line:match(task_pattern) then
        if line:match(completion_pattern) then
            line = line:gsub(checked_pattern, unchecked, 1)
            line = line:gsub(completion_pattern, "", 1)
        else
            local tag = completion_tag:format(os.date(date_format))
            line = line:gsub(unchecked_pattern, checked)
            line = string.format("%s %s", line, tag)
        end
    else
        line = string.format("%s %s", unchecked, line)
    end
    vim.api.nvim_set_current_line(line)
end

M.toggle_canceled = function()
    local line = vim.api.nvim_get_current_line()
    if line:match(task_pattern) then
        if line:match(canceled_pattern) then
            line = line:gsub("~~", "")
            line = line:gsub(checked_pattern, unchecked)
            line = line:gsub(canceled_pattern, "", 1)
        else
            local tag = canceled_tag:format(os.date(date_format))
            line = line:gsub(unchecked_pattern, checked, 1)
            line = string.format("%s %s", line, tag)
        end
        vim.api.nvim_set_current_line(line)
    end
end

---@param schedule string|nil
local toggle_scheduled_handler = function(schedule)
    if not schedule then
        return
    end
    local line = vim.api.nvim_get_current_line()
    if #schedule == 0 then -- remove tag
        line = line:gsub(scheduled_pattern, "", 1)
        vim.api.nvim_set_current_line(line)
    elseif schedule:match(date_pattern) then
        local tag = scheduled_tag:format(schedule)
        line = line:gsub(scheduled_pattern, "", 1)
        line = string.format("%s %s", line, tag)
        vim.api.nvim_set_current_line(line)
    else
        vim.notify("Wrong date format (YYYY-mm-dd)", vim.log.levels.WARN)
    end
end
M.toggle_scheduled = function()
    vim.ui.input({
        prompt = "Enter Scheduled Date (empty string to remove): ",
        default = os.date(date_format),
    }, toggle_scheduled_handler)
end

---@param due string|nil
local toggle_due_handler = function(due)
    print(due)
    if not due then
        return
    end
    local line = vim.api.nvim_get_current_line()
    if #due == 0 then -- remove tag
        line = line:gsub(due_pattern, "", 1)
        vim.api.nvim_set_current_line(line)
    elseif due:match(date_pattern) then
        local tag = due_tag:format(due)
        line = line:gsub(due_pattern, "", 1)
        line = string.format("%s %s", line, tag)
        vim.api.nvim_set_current_line(line)
    else
        vim.notify("Wrong date format (YYYY-mm-dd)", vim.log.levels.WARN)
    end
end
M.toggle_due = function()
    vim.ui.input({
        prompt = "Enter Due Date (empty string to remove): ",
        default = os.date(date_format),
    }, toggle_due_handler)
end

---@param priority string|nil
local toggle_priority_handler = function(priority)
    if not priority then
        return
    end
    local line = vim.api.nvim_get_current_line()
    if #priority == 0 then -- remove tag
        print("should remove")
        line = line:gsub(priority_pattern, "", 1)
        vim.api.nvim_set_current_line(line)
    elseif #priority == 1 and priority:match("[1234]") then
        local tag = priority_tag:format(priority)
        line = line:gsub(priority_pattern, "", 1)
        line = string.format("%s %s", line, tag)
        vim.api.nvim_set_current_line(line)
    else
        vim.notify("Wrong input (1-4)", vim.log.levels.WARN)
    end
end
M.toggle_priority = function()
    vim.ui.input({
        prompt = "Enter priority (1-4): ",
        default = "1",
    }, toggle_priority_handler)
end

---@param project string|nil
local toggle_project_handler = function(project)
    print(project)
    if not project then
        return
    end
    local line = vim.api.nvim_get_current_line()
    if #project == 0 then -- remove tag
        print("should remove")
        line = line:gsub(project_pattern, "", 1)
    else
        local tag = project_tag:format(project)
        line = line:gsub(project_pattern, "", 1)
        line = string.format("%s %s", line, tag)
    end
    vim.api.nvim_set_current_line(line)
end
M.toggle_project = function()
    vim.ui.input({
        prompt = "Enter project name: ",
        default = "",
    }, toggle_project_handler)
end

-- TODO: sort tags
-- TODO: task & list continuation
-- TODO: support + - * for task types

return M
