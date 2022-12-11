--  Brand new config method (77866a)
-- require("tabby").setup({
--   tabline = require("tabby.presets").active_wins_at_end,
-- })

-- 
--  custom separator
--  dynamic tab label
--    - for current buffer
--    - for buffer write state
--    - for error status

local nord = require('HRB.nord')
local filename = require('tabby.module.filename')
--[[ local text = require('tabby.text') ]]
--[[ local tab = require('tabby.tab') ]]

--[[ local hl_head = 'TabLine' ]]
--[[ local hl_tabline = 'TabLine' ]]
--[[ local hl_normal = 'Normal' ]]
--[[ local hl_tabline_sel = 'TabLineSel' ]]
--[[ local hl_tabline_fill = 'TabLineFill' ]]

-- local function tab_label(tabid, active)
--   local icon = active and '' or ''
--   local number = vim.api.nvim_tabpage_get_number(tabid)
--   local name = tab.get_name(tabid)
--   return string.format(' %s %d: %s ', icon, number, name)
-- end
local tab_label = function(tabid)
  return vim.api.nvim_tabpage_get_number(tabid)
end

--  https://github.com/nanozuki/tabby.nvim/issues/35
local buffer_label = function(winid, active)
  local label = {}
  local icon = active and '' or ''
  local fname = filename.unique(winid)
  local ftext = string.format(" %s %s ", icon, fname)
  table.insert(label, ftext)
  local bufid = vim.api.nvim_win_get_buf(winid)
  if vim.bo[bufid].modified then
    label.hl = { fg = nord.c05, bg = nord.c15, style = 'bold' }
    -- label.hl = { fg = nord.c05, bg = nord.c03, style = 'bold' },
  else
    label.hl = { fg = nord.c05, bg = nord.c02 }
  end
  return label
end


local cwd = function()
  return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
end

local sep = {
  component = { left = '', right = '' },
  section = { left = '', right = '' },
  left = ' ',
  right = ' ',
  -- component = { left = '', right = '' },
  -- section = { left = '', right = '' },
}

local line = {
  hl = { fg = nord.c05, bg = nord.c01 },
  -- active_wins_at_tail, active_wins_at_end, tab_with_top_win, active_tab_with_wins
  layout = 'active_wins_at_tail',
  head = {
    { cwd, hl = { fg = nord.c01, bg = nord.c08 } },
    { ' ', hl = { fg = nord.c08, bg = nord.c01 } },
  },
  active_tab = {
    label = function(tabid)
      return {
        '  ' .. tab_label(tabid) .. ' ',
        hl = { fg = nord.c01, bg = nord.c09, style = 'bold' },
      }
    end,
    left_sep = { '', hl = { fg = nord.c09, bg = nord.c01 } },
    right_sep = { ' ', hl = { fg = nord.c03, bg = nord.c01 } },
  },
  inactive_tab = {
    label = function(tabid)
      return {
        '  ' .. tab_label(tabid) .. ' ',
        hl = { fg = nord.c05, bg = nord.c03, style = 'bold' },
      }
    end,
    left_sep = { '', hl = { fg = nord.c03, bg = nord.c01 } },
    right_sep = { ' ', hl = { fg = nord.c03, bg = nord.c01 } },
  },
  top_win = {
    label = function(winid) return buffer_label(winid, true) end,
    left_sep = { ' ', hl = { fg = nord.c03, bg = nord.c01 } },
    right_sep = { '', hl = { fg = nord.c03, bg = nord.c01 } },
  },
  win = {
    label = function(winid) return buffer_label(winid, false) end,
    left_sep = { ' ', hl = { fg = nord.c03, bg = nord.c01 } },
    right_sep = { '', hl = { fg = nord.c03, bg = nord.c01 } },
  },
  tail = {
    { '', hl = { fg = nord.c09, bg = nord.c01 } },
    { '  ', hl = { fg = nord.c01, bg = nord.c09 } },
  },
}

require('tabby').setup({ tabline = line })
