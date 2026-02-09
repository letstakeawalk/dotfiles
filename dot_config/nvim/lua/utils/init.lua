local M = {}

---@param name string PascalCase name of the augroup
---@param opts vim.api.keyset.create_augroup
---@return integer augroup_id
function M.augroup(name, opts)
    return vim.api.nvim_create_augroup("Custom" .. name, opts)
end

function M.centerscreen()
    vim.cmd("normal! zz")
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

return M
