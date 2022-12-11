local utils = {}
local map = vim.keymap.set

utils.len = function(t)
  local length = 0
  for _, _ in pairs(t) do
    length = length + 1
  end
  return length
end

-- key mappings
utils.map = function(mode, lhs, rhs, desc)
  map(mode, lhs, rhs, { desc = desc })
end
utils.remap = function(mode, lhs, rhs, desc)
  map(mode, lhs, rhs, { remap = true, desc = desc })
end

return utils
