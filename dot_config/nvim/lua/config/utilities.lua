local util = {}

function util.opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

function util.map(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- return util

local config_func = {}

function config_func.map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function config_func.nmap(shortcut, command)
  config_func.map('n', shortcut, command)
end

function config_func.imap(shortcut, command)
  config_func.map('i', shortcut, command)
end

function config_func.buf_map(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

return config_func

