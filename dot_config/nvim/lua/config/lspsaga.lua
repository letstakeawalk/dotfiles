local saga = require 'lspsaga'

saga.init_lsp_saga {
  -- same as nvim-lightbulb but async
  code_action_lightbulb = {
    enable = false,
    sign = false,
    sign_priority = 20,
    virtual_text = true,
  },
  finder_action_keys = {
    open = 'o', vsplit = 'v', split = 'x', tabe = 't',
    quit = 'q', scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
  },
  code_action_keys = {
    quit = { 'q', '<Esc>' }, exec = '<CR>' -- quit can be a table
  },
  symbol_in_winbar = {
    in_custom = false,
    enable = false,
    separator = ' ',
    show_file = true,
    click_support = false,
  },
  rename_action_quit = '<Esc>',
  rename_in_select = true,
}

-- custom highlights
local highlights = {
  LspSagaCodeActionTitle     = { link = "Bold" },
  LspSagaCodeActionBorder    = { fg = "#B48EAD" },
  LspSagaCodeActionContent   = { link = "Normal" },
  LspSagaLspFinderBorder     = { link = "LspSagaCodeActionBorder" },
  LspSagaDefPreviewBorder    = { link = "LspSagaCodeActionBorder" },
  LspSagaHoverBorder         = { link = "LspSagaCodeActionBorder" },
  LspSagaRenameBorder        = { link = "LspSagaCodeActionBorder" },
  LspSagaSignatureHelpBorder = { link = "LspSagaCodeActionBorder" },
}

for group, conf in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, conf)
end


-- -- default highlights
-- local highlights = {
--   -- code action
--   LspSagaCodeActionTitle        = { fg = '#da8548', bold = true },
--   LspSagaCodeActionBorder       = { fg = '#CBA6F7' },
--   LspSagaCodeActionTrunCateLine = { link = 'LspSagaCodeActionBorder' },
--   LspSagaCodeActionContent      = { fg = '#98be65' },
--   -- finder
--   LspSagaLspFinderBorder        = { fg = '#51afef' },
--   LspSagaAutoPreview            = { fg = '#ecbe7b' },
--   LspSagaFinderSelection        = { fg = '#89d957', bold = true },
--   ReferencesIcon                = { link = 'Special' },
--   DefinitionIcon                = { link = 'Special' },
--   TargetFileName                = { link = 'Comment' },
--   DefinitionCount               = { link = 'Title' },
--   ReferencesCount               = { link = 'Title' },
--   TargetWord                    = { link = 'Error' },
--   -- definition
--   LspSagaDefPreviewBorder       = { fg = '#b3deef' },
--   DefinitionPreviewTitle        = { link = 'Title' },
--   -- hover
--   LspSagaHoverBorder            = { fg = '#f7bb3b' },
--   LspSagaHoverTrunCateLine      = { link = 'LspSagaHoverBorder' },
--   -- rename
--   LspSagaRenameBorder           = { fg = '#3bb6c4' },
--   LspSagaRenamePromptPrefix     = { fg = '#98be65' },
--   LspSagaRenameMatch            = { link = 'Search' },
--   -- diagnostic
--   LspSagaDiagnosticError        = { link = 'DiagnosticError' },
--   LspSagaDiagnosticWarn         = { link = 'DiagnosticWarn' },
--   LspSagaDiagnosticInfo         = { link = 'DiagnosticInfo' },
--   LspSagaDiagnosticHint         = { link = 'DiagnosticHint' },
--   LspSagaErrorTrunCateLine      = { link = 'DiagnosticError' },
--   LspSagaWarnTrunCateLine       = { link = 'DiagnosticWarn' },
--   LspSagaInfoTrunCateLine       = { link = 'DiagnosticInfo' },
--   LspSagaHintTrunCateLine       = { link = 'DiagnosticHint' },
--   -- signture help
--   LspSagaSignatureHelpBorder    = { fg = "#98be65" },
--   LspSagaShTrunCateLine         = { link = 'LspSagaSignatureHelpBorder' },
--   -- lightbulb
--   LspSagaLightBulb              = { link = 'DiagnosticSignHint' },
--   -- shadow
--   SagaShadow                    = { fg = 'black' },
--   -- float
--   LspSagaBorderTitle            = { link = 'String' }
-- }
