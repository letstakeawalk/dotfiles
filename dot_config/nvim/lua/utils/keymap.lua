local keymap = {
    ---@param mode string
    ---@param lhs string
    ---@param rhs string|function
    ---@param opts? table
    set = function(mode, lhs, rhs, opts) vim.keymap.set(vim.split(mode, ""), lhs, rhs, opts) end,
    ---@param mode string
    ---@param lhs string
    del = function(mode, lhs)
        pcall(function() vim.keymap.del(mode, lhs) end)
    end,
}

return keymap
