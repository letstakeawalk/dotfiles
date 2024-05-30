local utils = {}

---@param name string PascalCase name of the augroup
---@param opts vim.api.keyset.create_augroup
---@return integer augroup_id
function utils.augroup(name, opts)
    return vim.api.nvim_create_augroup("Custom" .. name, opts)
end

return utils
