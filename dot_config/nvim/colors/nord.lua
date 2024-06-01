vim.opt.bg = "dark"
vim.cmd([[highlight clear]])


-- stylua: ignore start
local nord = require("utils.nord")

local set = vim.api.nvim_set_hl

-- Basic
set(0, "Bold",      { bold = true })
set(0, "Italic",    { italic = true })
set(0, "Strike",    { strikethrough = true })
set(0, "Underline", { underline = true })
set(0, "Undercurl", { undercurl = true })

-- Editor
set(0, "Normal",       { fg = nord.c04_wht })
set(0, "NormalFloat",  { fg = nord.c04_wht })
set(0, "NormalNC",     { fg = nord.c04_wht_dk })
set(0, "FloatBorder",  { fg = nord.c03_gry_br })
set(0, "FloatTitle",   { fg = nord.c09_glcr })
set(0, "FloatFooter",  { fg = nord.c09_glcr })
set(0, "Pmenu",        { fg = nord.c04_wht, bg = nord.c01_gry })
set(0, "PmenuSel",     { bg = nord.visual })
set(0, "PmenuSbar",    { bg = nord.c03_gry_br })
set(0, "PmenuThumb",   { bg = nord.c03_gry_br })
set(0, "ColorColumn",  { bg = nord.c01_gry }) -- used for the columns set with 'colorcolumn'
set(0, "Conceal",      { fg = nord.c03_gry_br }) -- placeholder characters substituted for concealed text (see 'conceallevel')
set(0, "Cursor",       { fg = nord.bg, bg = nord.fg }) -- the character under the cursor
set(0, "CursorIM",     { fg = nord.bg, bg = nord.fg }) -- like Cursor, but used when in IME mode
set(0, "CursorLine",   { bg = nord.cursorline })
set(0, "CursorColumn", { bg = nord.cursorline })
set(0, "Folded",       { fg = nord.c03_gry, bg = nord.cursorline })
set(0, "MatchParen",   { fg = nord.c13_ylw, bg = nord.c03_gry, bold = true })
set(0, "NonText",      { fg = nord.c03_gry })
set(0, "SpecialKey",   { fg = nord.c09_glcr })
set(0, "Title",        { fg = nord.fg, bold = true })
set(0, "Visual",       { bg = nord.visual })
set(0, "QuickFixLine", { bg = nord.c02_gry })
set(0, "WinSeparator", { fg = nord.c02_gry })
set(0, "SpellBad",     { fg = nord.error, undercurl = true })

-- Spell
set(0, "SpellLocal", { undercurl = true })
set(0, "SpellCap",   { undercurl = true })
set(0, "SpellRare",  { undercurl = true })

-- File Navigation
set(0, "Directory", { fg = nord.c08_teal }) -- directory names (and other special names in listings)

-- Search
set(0, "CurSearch",  { fg = nord.c06_wht, bg = nord.c10_blue })
set(0, "IncSearch",  { fg = nord.c06_wht, bg = nord.c10_blue })
set(0, "Search",     { fg = nord.c06_wht, bg = nord.c10_blue })
set(0, "Substitute", { fg = nord.c06_wht, bg = nord.c10_blue })

-- Prompt
set(0, "ModeMsg",     { fg = nord.c04_wht,  bold = true })
set(0, "MoreMsg",     { fg = nord.c08_teal, bold = true })
set(0, "ErrorMsg",    { fg = nord.error })
set(0, "WarningMsg",  { fg = nord.warn })
set(0, "Question",    { fg = nord.c07_jade, bold = true })
set(0, "WildMenu",    { fg = nord.c08_teal })

-- StatusLine, Tabline & WinBar
set(0, "StatusLine",   { fg = nord.fg, bg = nord.c00_blk_br })
set(0, "StatusLineNC", { fg = nord.fg, bg = nord.c00_blk_br })
set(0, "Tabline",      { fg = nord.fg })
set(0, "TablineSel",   { fg = nord.c08_teal })
set(0, "TabLineFill",  { bg = nord.c00_blk_br })
set(0, "WinBar",       { fg = nord.fg })
set(0, "WinBarNC",     { fg = nord.fg })

-- Gutter
set(0, "LineNr",       { fg = nord.c03_gry })
set(0, "CursorLineNr", { fg = nord.fg })
set(0, "FoldColumn",   { fg = nord.c03_gry })
set(0, "SignColumn",   { fg = nord.c01_gry })

-- Diff
set(0, "DiffAdd",    { fg = nord.c00_blk, bg = nord.c14_grn })
set(0, "DiffChange", { fg = nord.c00_blk, bg = nord.c13_ylw })
set(0, "DiffDelete", { fg = nord.c00_blk, bg = nord.c11_red })
set(0, "DiffText",   { fg = nord.c00_blk, bg = nord.c09_glcr })
set(0, "Added",      { fg = nord.c14_grn })
set(0, "Changed",    { fg = nord.c13_ylw })
set(0, "Removed",    { fg = nord.c11_red })

-- Etc
set(0, "healthError",   { fg = nord.error })
set(0, "healthSuccess", { fg = nord.ok })
set(0, "healthWarning", { fg = nord.warn })

-- Syntax
set(0, "Boolean",        { fg = nord.c09_glcr }) -- a boolean constant: true, false
set(0, "Character",      { fg = nord.c14_grn }) -- any character constant: 'c', '\n'
set(0, "Comment",        { fg = nord.c03_gry_br, italic = true })
set(0, "Conditional",    { fg = nord.c09_glcr }) -- if, then, else, endif, switch, etc.
set(0, "Constant",       { fg = nord.fg }) -- any constant
set(0, "Decorator",      { fg = nord.c12_orng }) -- ??
set(0, "Debug",          { fg = nord.error }) -- debugging statements
set(0, "Define",         { fg = nord.c09_glcr }) -- preprocessor #define
set(0, "Delimiter",      { fg = nord.c06_wht }) -- character that needs attention like, or .
set(0, "Error",          { fg = nord.error }) -- any erroneous construct
set(0, "Exception",      { fg = nord.c09_glcr }) -- try, catch, throw
set(0, "Float",          { fg = nord.c15_prpl }) -- a floating point constant: 2.3e10
set(0, "Function",       { fg = nord.c08_teal }) -- funtion names
set(0, "Identifier",     { fg = nord.fg }) -- any variable name
set(0, "Ignore",         { fg = nord.c01_gry }) -- left blank, hidden
set(0, "Include",        { fg = nord.c09_glcr }) -- preprocessor #include
set(0, "Keyword",        { fg = nord.c09_glcr }) -- for, do, while, etc.
set(0, "Label",          { fg = nord.c09_glcr }) -- case, default, etc.
set(0, "Macro",          { fg = nord.c09_glcr }) -- same as Define
set(0, "Number",         { fg = nord.c15_prpl }) -- a number constant: 5
set(0, "Operator",       { fg = nord.c09_glcr }) -- sizeof", "+", "*", etc.
set(0, "PreCondit",      { fg = nord.c13_ylw }) -- preprocessor #if, #else, #endif, etc.
set(0, "PreProc",        { fg = nord.c09_glcr }) -- generic Preprocessor
set(0, "Repeat",         { fg = nord.c09_glcr }) -- any other keyword
set(0, "Special",        { fg = nord.c09_glcr }) -- any special symbol
set(0, "SpecialChar",    { fg = nord.c13_ylw }) -- special character in a constant
set(0, "SpecialComment", { fg = nord.c08_teal }) -- special things inside a comment
set(0, "Statement",      { fg = nord.c09_glcr }) -- any statement
set(0, "StorageClass",   { fg = nord.c09_glcr }) -- static, register, volatile, etc.
set(0, "String",         { fg = nord.c14_grn }) -- any string
set(0, "Structure",      { fg = nord.c09_glcr }) -- struct, union, enum, etc.
set(0, "Tag",            { fg = nord.fg }) -- you can use CTRL-] on this
set(0, "Todo",           { fg = nord.c13_ylw }) -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
set(0, "Type",           { fg = nord.c09_glcr }) -- int, long, char, etc.
set(0, "Typedef",        { fg = nord.c09_glcr }) -- A typedef
set(0, "Annotation",     { fg = nord.c12_orng }) -- same as Decorator
set(0, "Variable",       { fg = nord.fg }) -- same as Identifier

-- LSP
set(0, "DiagnosticError",          { fg = nord.error })
set(0, "DiagnosticWarn",           { fg = nord.warn })
set(0, "DiagnosticInfo",           { fg = nord.info })
set(0, "DiagnosticHint",           { fg = nord.hint })
set(0, "DiagnosticOk",             { fg = nord.ok })
set(0, "DiagnosticUnderlineWarn",  { fg = nord.warn,  undercurl = true })
set(0, "DiagnosticUnderlineError", { fg = nord.error, undercurl = true })
set(0, "DiagnosticUnderlineInfo",  { fg = nord.info,  undercurl = true })
set(0, "DiagnosticUnderlineHint",  { fg = nord.hint,  undercurl = true })
set(0, "DiagnosticUnderlineOk",    { fg = nord.ok,    undercurl = true })
set(0, "DiagnosticDeprecated",     { strikethrough = true })
set(0, "LspInlayHint",                         { link = "Comment" })

--------------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------------

set(0, "@markup.heading.1.markdown", { fg = nord.c08_teal, bold = true })
set(0, "@markup.heading.2.markdown", { fg = nord.c08_teal, bold = true })
set(0, "@markup.heading.3.markdown", { fg = nord.c08_teal_br, bold = true })
set(0, "@markup.heading.4.markdown", { bold = true })
set(0, "@markup.heading.5.markdown", { bold = true })
set(0, "@markup.heading.6.markdown", { bold = true })

set(0, "@variable",      { link = "Variable" })
set(0, "tag",            { fg = nord.c09_glcr })
set(0, "@tag.delimiter", { fg = nord.c09_glcr })
set(0, "@tag.attribute", { fg = nord.c08_teal })

-- gitcommit
set(0, "@string.special.url.gitcommit", { fg = nord.c04_wht_dk })
set(0, "@keyword.gitcommit",            { fg = nord.c09_glcr, bold = true })

--------------------------------------------------------------------------------
-- Extensions
--------------------------------------------------------------------------------
-- lsp
set(0, "LspInfoBorder",           { link = "FloatBorder" })
set(0, "NullLsInfoBorder",        { link = "FloatBorder" })

-- telescope.nvim
set(0, "TelescopeTitle",          { link = "FloatTitle" })
set(0, "TelescopeBorder",         { link = "FloatBorder" })
set(0, "TelescopePromptBorder",   { link = "FloatBorder" })
set(0, "TelescopeResultsBorder",  { link = "FloatBorder" })
set(0, "TelescopePreviewBorder",  { link = "FloatBorder" })
set(0, "TelescopePromptPrefix",   { link = "TelescopeTitle" })
set(0, "TelescopeMatching",       { fg = nord.fg, bold = true })
set(0, "TelescopeResultsNormal",  { fg = nord.c04_wht_dk })
set(0, "TelescopeSelection",      { link = "Visual" })
set(0, "TelescopeSelectionCaret", { link = "TelescopeSelection" })

-- harpoon
set(0, "HarpoonActive",         { fg = nord.c04_wht,    bold = true })
set(0, "HarpoonInactive",       { fg = nord.c03_gry_br, bg = nord.c00_blk_br })
set(0, "HarpoonNumberActive",   { fg = "#7aa2f7",       bold = true })
set(0, "HarpoonNumberInactive", { fg = "#496194",       bg = nord.c00_blk_br })

-- treesitter
set(0, "TreesitterContext", { link = "CursorLine" })

-- Cmp
set(0, "CmpItemAbbr",           { fg = nord.c04_wht }) -- unmatched chars of completion field
set(0, "CmpItemAbbrDeprecated", { fg = "#808080", strikethrough = true }) -- unmatched chars of depr field
set(0, "CmpItemAbbrMatch",      { fg = "#74C0FC", bold = true }) --"#569CD6" }) -- matched chars of completion field
set(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" }) -- fuzzy-matched chars
set(0, "CmpItemKind",           { fg = nord.c04_wht_dk }) -- kind of fields
set(0, "CmpItemKindVariable",   { fg = "#9CDCFE" })
set(0, "CmpItemKindInterface",  { link = "CmpItemKindVariable" })
set(0, "CmpItemKindText",       { link = "CmpItemKindVariable" })
set(0, "CmpItemKindFunction",   { fg = "#C586C0" })
set(0, "CmpItemKindMethod",     { link = "CmpItemKindFunction" })
set(0, "CmpItemKindClass",      { fg = "#C586C0" })
set(0, "CmpItemKindModule",     { link = "CmpItemKindClass" })
set(0, "CmpItemKindStruct",     { link = "CmpItemKindClass" })
set(0, "CmpItemKindEnum",       { link = "CmpItemKindClass" })
set(0, "CmpItemKindKeyword",    { fg = "#D4D4D4" })
set(0, "CmpItemKindProperty",   { link = "CmpItemKindKeyword" })
set(0, "CmpItemKindUnit",       { link = "CmpItemKindKeyword" })
set(0, "CmpItemKindSnippet",    { fg = "#D0BFFF" })
set(0, "CmpItemMenu",           { link = "Comment" })
set(0, "CmpItemKindCopilot",    { fg = "#20C997" })

-- indent-blankline.nvim
set(0, "IblIndent", { fg = nord.c01_gry })
set(0, "IblScope",  { fg = nord.c09_glcr })

-- leap
set(0, "LeapMatch",        { fg = "#ccff88", bold = true,    underline = true })
set(0, "LeapLabelPrimary", { fg = "black",   bg = "#ccff88", bold = true })

-- mini
set(0, "MiniClueFloatTitle", { fg = nord.c09_glcr, bold = true })
set(0, "MiniClueNextKey",    { fg = nord.c08_teal, bold = true })
set(0, "MiniClueSeparator",  { link = "MiniClueBorder" })

-- illuminate
set(0, "IlluminatedWordText",  { bg = nord.c02_gry })
set(0, "IlluminatedWordRead",  { bg = nord.c02_gry })
set(0, "IlluminatedWordWrite", { bg = nord.c02_gry })

-- trouble
set(0, "TroublePreview", { link = "Search" })

-- zen
set(0, "ZenBg", { bg = nord.c00_blk_dk })
