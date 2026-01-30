vim.opt.bg = "dark"
vim.cmd.highlight("clear")
vim.hl.priorities.semantic_tokens = 125

-- stylua: ignore start
-- local nord = require("utils.nord")
local nord = require("nord")

local set = vim.api.nvim_set_hl

-- Basic
set(0, "Bold",      { bold = true })
set(0, "Italic",    { italic = true })
set(0, "Strike",    { strikethrough = true })
set(0, "Underline", { underline = true })
set(0, "Undercurl", { undercurl = true })

-- Editor
set(0, "Normal",        { fg = nord.c04_white })
set(0, "NormalFloat",   { fg = nord.c04_white })
set(0, "NormalNC",      { fg = nord.c04d_white })
set(0, "FloatBorder",   { fg = nord.c03b_gray })
set(0, "FloatTitle",    { fg = nord.c09_glacier })
set(0, "FloatFooter",   { fg = nord.c09_glacier })
set(0, "Pmenu",         { fg = nord.c04_white })
set(0, "PmenuSel",      { bg = nord.visual })
set(0, "PmenuKind",     { link = "Pmenu" })
set(0, "PmenuKindSel",  { link = "PmenuSel" })
set(0, "PmenuExtra",    { fg = nord.c04d_white })
set(0, "PmenuExtraSel", { link = "PmenuSel" })
set(0, "PmenuSbar",     { bg = nord.c02_gray })
set(0, "PmenuThumb",    { bg = nord.c03b_gray })
set(0, "PmenuMatch",    { fg = "#74C0FC", bold = true })
set(0, "PmenuMatchSel", { fg = nord.c09_glacier, bold = true })

set(0, "ColorColumn",  { bg = nord.c01_gray }) -- used for the columns set with 'colorcolumn'
set(0, "Conceal",      { fg = nord.c03b_gray }) -- placeholder characters substituted for concealed text (see 'conceallevel')
set(0, "Cursor",       { fg = nord.bg, bg = nord.fg }) -- the character under the cursor
set(0, "CursorIM",     { fg = nord.bg, bg = nord.fg }) -- like Cursor, but used when in IME mode
set(0, "CursorLine",   { bg = nord.cursorline })
set(0, "CursorColumn", { bg = nord.cursorline })
set(0, "Folded",       { fg = nord.c03_gray, bg = nord.c00b_black })
set(0, "MatchParen",   { fg = nord.c13_yellow, bg = nord.c03_gray, bold = true })
set(0, "NonText",      { fg = nord.c03_gray })
set(0, "SpecialKey",   { fg = nord.c09_glacier })
set(0, "Title",        { fg = nord.fg, bold = true })
set(0, "Visual",       { bg = nord.visual })
set(0, "WinSeparator", { fg = nord.c02_gray })
set(0, "SpellBad",     { fg = nord.error, undercurl = true })

set(0, "QuickFixLine",            { bg = nord.c02_gray })
set(0, "QuickFixText",            { link = "Normal" })
set(0, "QuickFixTextInvalid",     { link = "QuickFixText" })
set(0, "QuickFixHeaderHard",      { link = "Delimiter" })
set(0, "QuickFixHeaderSoft",      { link = "Comment" })
set(0, "QuickFixLineNr",          { link = "Comment" })
set(0, "QuickFixFilename",        { link = "Directory" })
set(0, "QuickFixFilenameInvalid", { link = "Comment" })
-- DiagnosticSign* 

-- Spell
set(0, "SpellLocal", { undercurl = true })
set(0, "SpellCap",   { undercurl = true })
set(0, "SpellRare",  { undercurl = true })

-- File Navigation
set(0, "Directory", { fg = nord.c08_cyan }) -- directory names (and other special names in listings)

-- Search
set(0, "CurSearch",  { fg = nord.c06_white, bg = nord.c10_blue, bold = true })
set(0, "IncSearch",  { fg = nord.c06_white, bg = nord.c10d_blue })
set(0, "Search",     { fg = nord.c06_white, bg = nord.c10d_blue })
set(0, "Substitute", { fg = nord.c06_white, bg = nord.c10d_blue })

-- Prompt
set(0, "ModeMsg",     { fg = nord.c04_white,  bold = true })
set(0, "MoreMsg",     { fg = nord.c08_cyan, bold = true })
set(0, "ErrorMsg",    { fg = nord.error })
set(0, "WarningMsg",  { fg = nord.warn })
set(0, "Question",    { fg = nord.c07_teal, bold = true })
set(0, "WildMenu",    { fg = nord.c08_cyan })

-- StatusLine, Tabline & WinBar
set(0, "StatusLine",   { fg = nord.fg, bg = nord.c00b_black })
set(0, "StatusLineNC", { fg = nord.fg, bg = nord.c00b_black })
set(0, "Tabline",      { fg = nord.fg })
set(0, "TablineSel",   { fg = nord.c08_cyan })
set(0, "TabLineFill",  { bg = nord.c00b_black })
set(0, "WinBar",       { fg = nord.fg })
set(0, "WinBarNC",     { fg = nord.fg })

-- Gutter
set(0, "LineNr",       { fg = nord.c03_gray })
set(0, "CursorLineNr", { fg = nord.fg })
set(0, "FoldColumn",   { fg = nord.c03_gray })
set(0, "SignColumn",   { fg = nord.c01_gray })

-- Diff
set(0, "DiffAdd",    { fg = nord.c00_black, bg = nord.c14_green })
set(0, "DiffChange", { fg = nord.c00_black, bg = nord.c13_yellow })
set(0, "DiffDelete", { fg = nord.c00_black, bg = nord.c11_red })
set(0, "DiffText",   { fg = nord.c00_black, bg = nord.c09_glacier })
set(0, "Added",      { fg = nord.c14_green })
set(0, "Changed",    { fg = nord.c13_yellow })
set(0, "Removed",    { fg = nord.c11_red })

-- Etc
set(0, "healthError",   { fg = nord.error })
set(0, "healthSuccess", { fg = nord.ok })
set(0, "healthWarning", { fg = nord.warn })

-- Syntax
set(0, "Boolean",        { fg = nord.c09_glacier }) -- a boolean constant: true, false
set(0, "Character",      { fg = nord.c14_green }) -- any character constant: 'c', '\n'
set(0, "Comment",        { fg = nord.c03b_gray, italic = true })
set(0, "Conditional",    { fg = nord.c09_glacier }) -- if, then, else, endif, switch, etc.
set(0, "Constant",       { fg = nord.fg }) -- any constant
set(0, "Decorator",      { fg = nord.c12_orange }) -- ??
set(0, "Debug",          { fg = nord.error }) -- debugging statements
set(0, "Define",         { fg = nord.c09_glacier }) -- preprocessor #define
set(0, "Delimiter",      { fg = nord.c04d_white }) -- character that needs attention like `,` and `.`
set(0, "Error",          { fg = nord.error }) -- any erroneous construct
set(0, "Exception",      { fg = nord.c09_glacier }) -- try, catch, throw
set(0, "Float",          { fg = nord.c15_purple }) -- a floating point constant: 2.3e10
set(0, "Function",       { fg = nord.c08_cyan }) -- funtion names
set(0, "Identifier",     { fg = nord.fg }) -- any variable name
set(0, "Ignore",         { fg = nord.c01_gray }) -- left blank, hidden
set(0, "Include",        { fg = nord.c09_glacier }) -- preprocessor #include
set(0, "Keyword",        { fg = nord.c09_glacier }) -- for, do, while, etc.
set(0, "Label",          { fg = nord.c09_glacier }) -- case, default, etc.
set(0, "Macro",          { fg = nord.c09_glacier }) -- same as Define
set(0, "Number",         { fg = nord.c15_purple }) -- a number constant: 5
set(0, "Operator",       { fg = nord.c09_glacier }) -- sizeof", "+", "*", etc.
set(0, "PreCondit",      { fg = nord.c13_yellow }) -- preprocessor #if, #else, #endif, etc.
set(0, "PreProc",        { fg = nord.c09_glacier }) -- generic Preprocessor
set(0, "Repeat",         { fg = nord.c09_glacier }) -- any other keyword
set(0, "Special",        { fg = nord.c09_glacier }) -- any special symbol
set(0, "SpecialChar",    { fg = nord.c13_yellow }) -- special character in a constant
set(0, "SpecialComment", { fg = nord.c08_cyan }) -- special things inside a comment
set(0, "Statement",      { fg = nord.c09_glacier }) -- any statement
set(0, "StorageClass",   { fg = nord.c09_glacier }) -- static, register, volatile, etc.
set(0, "String",         { fg = nord.c14_green }) -- any string
set(0, "Structure",      { fg = nord.c09_glacier }) -- struct, union, enum, etc.
set(0, "Tag",            { fg = nord.fg }) -- you can use CTRL-] on this
set(0, "Todo",           { fg = nord.c13_yellow }) -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
set(0, "Type",           { fg = nord.c09_glacier }) -- int, long, char, etc.
set(0, "Typedef",        { fg = nord.c09_glacier }) -- A typedef
set(0, "Annotation",     { fg = nord.c12_orange }) -- same as Decorator
set(0, "Variable",       { fg = nord.fg }) -- same as Identifier

-- LSP
set(0, "DiagnosticError",             { fg = nord.error })
set(0, "DiagnosticWarn",              { fg = nord.warn })
set(0, "DiagnosticInfo",              { fg = nord.info })
set(0, "DiagnosticHint",              { fg = nord.hint })
set(0, "DiagnosticOk",                { fg = nord.ok })
set(0, "DiagnosticUnderlineWarn",     { fg = nord.warn,  undercurl = true })
set(0, "DiagnosticUnderlineError",    { fg = nord.error, undercurl = true })
set(0, "DiagnosticUnderlineInfo",     { fg = nord.info,  undercurl = true })
set(0, "DiagnosticUnderlineHint",     { fg = nord.hint,  undercurl = true })
set(0, "DiagnosticUnderlineOk",       { fg = nord.ok,    undercurl = true })
set(0, "DiagnosticDeprecated",        { strikethrough = true })
set(0, "LspSignatureActiveParameter", { link = "Visual" })
set(0, "LspInlayHint",                { fg = nord.c04d_white })
set(0, "LspReferenceText",            { link = "Visual" })
set(0, "LspReferenceRead",            { link = "LspReferenceText" })
set(0, "LspReferenceWrite",           { link = "LspReferenceText" })
set(0, "LspReferenceTarget",          { link = "LspReferenceText" })
set(0, "LspCodeLens",                 { link = "NonText" })
set(0, "LspCodeLensSeparator",        { link = "LspCodeLens" })

--------------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------------

set(0, "@markup.heading.1.markdown", { fg = nord.c08_cyan, bold = true })
set(0, "@markup.heading.2.markdown", { fg = nord.c08_cyan, bold = true })
set(0, "@markup.heading.3.markdown", { fg = nord.c08b_aqua, bold = true })
set(0, "@markup.heading.4.markdown", { bold = true })
set(0, "@markup.heading.5.markdown", { bold = true })
set(0, "@markup.heading.6.markdown", { bold = true })
set(0, "@markup.strikethrough.markdown_inline", { strikethrough = true })

set(0, "@variable",      { link = "Variable" })
set(0, "tag",            { fg = nord.c09_glacier })
set(0, "@tag.delimiter", { fg = nord.c09_glacier })
set(0, "@tag.attribute", { fg = nord.c08_cyan })

-- json
set(0, "@property.json", { fg = nord.c09_glacier })

-- gitcommit
set(0, "@string.special.url.gitcommit", { fg = nord.c04d_white })
set(0, "@keyword.gitcommit",            { fg = nord.c09_glacier, bold = true })

--------------------------------------------------------------------------------
-- Extensions
--------------------------------------------------------------------------------
-- lsp
set(0, "NullLsInfoBorder",        { link = "FloatBorder" })

-- rust
set(0, "@lsp.type.string.rust",                       {}) -- needed for treesitter injected queries (sql)
set(0, "@lsp.type.macro.rust",                        { link = "Function" })
set(0, "@lsp.type.typeAlias.rust",                    { link = "Type" })
set(0, "@lsp.typemod.enumMember.library.rust",        { link = "Constant" })
-- set(0, "@lsp.typemod.enumMember.defaultLibrary.rust", { link = "Type" })
set(0, "@lsp.typemod.macro.library.rust",             { link = "Function"})
set(0, "@lsp.typemod.namespace.library.rust",         { link = "Type"})
set(0, "@lsp.typemod.string.macro.rust",              { link = "String" })
set(0, "@lsp.typemod.keyword.controlFlow.rust",       { link = "Keyword" })
-- set(0, "@unit.rust",                                { fg = nord.c04d_white, italic = true })

set(0, "@string.special.symbol.clojure", { link = "Keyword" })

-- telescope.nvim
set(0, "TelescopeTitle",          { link = "FloatTitle" })
set(0, "TelescopeBorder",         { link = "FloatBorder" })
set(0, "TelescopePromptBorder",   { link = "FloatBorder" })
set(0, "TelescopeResultsBorder",  { link = "FloatBorder" })
set(0, "TelescopePreviewBorder",  { link = "FloatBorder" })
set(0, "TelescopePromptPrefix",   { link = "TelescopeTitle" })
set(0, "TelescopeMatching",       { fg = nord.fg, bold = true })
set(0, "TelescopeResultsNormal",  { fg = nord.c04d_white })
set(0, "TelescopeSelection",      { link = "Visual" })
set(0, "TelescopeSelectionCaret", { link = "TelescopeSelection" })

-- harpoon & lualine
set(0, "HarpoonActive",         { fg = nord.c04_white,    bold = true })
set(0, "HarpoonInactive",       { fg = nord.c03b_gray, bg = nord.c00b_black })
set(0, "HarpoonNumberActive",   { fg = "#7aa2f7",       bold = true })
set(0, "HarpoonNumberInactive", { fg = "#496194",       bg = nord.c00b_black })
set(0, "LualineTabsActive",     { fg = "#7aa2f7", bold = true })
set(0, "LualineTabsInactive",   { fg = "#496194" })

-- treesitter
set(0, "TreesitterContext", { link = "CursorLine" })

-- Blink.cmp
set(0, "BlinkCmpMenu",                         { link = "Pmenu" })
set(0, "BlinkCmpMenuBorder",                   { link = "FloatBorder" })
set(0, "BlinkCmpMenuSelection",                { link = "PmenuSel" })
set(0, "BlinkCmpScrollBarThumb",               { link = "PmenuThumb" })
set(0, "BlinkCmpScrollBarGutter",              { link = "PmenuSbar" })
set(0, "BlinkCmpLabel",                        { link = "Pmenu" })
set(0, "BlinkCmpLabelDetail",                  { fg = nord.c03b_gray })
set(0, "BlinkCmpLabelDescription",             { fg = nord.c03_gray })
set(0, "BlinkCmpLabelMatch",                   { link = "PmenuMatch" })
set(0, "BlinkCmpLabelDeprecated",              { fg = "#808080", strikethrough = true })
set(0, "BlinkCmpKind",                         { link = "PmenuKind" })
set(0, "BlinkCmpKindModule",                   { fg = nord.c09_glacier })
set(0, "BlinkCmpKindClass",                    { fg = nord.c08_cyan })
set(0, "BlinkCmpKindFunction",                 { fg = "#C586C0" })
set(0, "BlinkCmpKindMethod",                   { link = 'BlinkCmpKindFunction' })
set(0, "BlinkCmpKindKeyword",                  { fg = "#D4D4D4" })
set(0, "BlinkCmpKindConstant",                 { link = "Constant" })
set(0, "BlinkCmpKindVariable",                 { link = "Variable" })
set(0, "BlinkCmpKindValue",                    { link = "Variable" })
set(0, "BlinkCmpKindProperty",                 { link = "PmenuKind" })
set(0, "BlinkCmpKindField",                    { link = "PmenuKind" })
set(0, "BlinkCmpKindEnum",                     { link = "PmenuKind" })
set(0, "BlinkCmpKindEnumMember",               { link = "BlinkCmpKindEnumMember" })
set(0, "BlinkCmpKindStruct",                   { fg = nord.c09_glacier })
set(0, "BlinkCmpKindInterface",                { link = "PmenuKind" })
set(0, "BlinkCmpKindReference",                { link = "PmenuKind" })
set(0, "BlinkCmpKindTypeParameter",            { link = "PmenuKind" })
set(0, "BlinkCmpKindText",                     { link = "PmenuExtra" })
set(0, "BlinkCmpKindSnippet",                  { fg = "#D0BFFF" })
set(0, "BlinkCmpKindCopilot",                  { fg = "#20C997" })
set(0, "BlinkCmpSource",                       { link = "PmenuExtra" })
set(0, "BlinkCmpGhostText",                    { link = "NonText" })
set(0, "BlinkCmpDoc",                          { link = "NormalFloat" })
set(0, "BlinkCmpDocBorder",                    { link = "FloatBorder" })
set(0, "BlinkCmpDocSeparator",                 { link = "FloatBorder" })
set(0, "BlinkCmpDocCursorLine",                { link = "CursorLine" })
set(0, "BlinkCmpSignatureHelp",                { link = "NormalFloat" })
set(0, "BlinkCmpSignatureHelpBorder",          { link = "FloatBorder" })
set(0, "BlinkCmpSignatureHelpActiveParameter", { link = "LspSignatureActiveParameter" })

-- indent-blankline.nvim
set(0, "IblIndent", { fg = nord.c01_gray })
set(0, "IblScope",  { fg = nord.c09_glacier })

-- leap
set(0, "LeapLabel",        { fg = "black", bg = "#ccff88", bold = true, underline = true })
set(0, "LeapMatch",        { fg = "black", bg = "#ccff88", bold = true, underline = true })
set(0, "LeapLabelPrimary", { fg = "black", bg = "#ccff88", bold = true })
set(0, "LeapLabelDimmed",  { fg = "black", bg = "#88aa33" })

-- mini
set(0, "MiniClueFloatTitle", { fg = nord.c09_glacier, bold = true })
set(0, "MiniClueNextKey",    { fg = nord.c08_cyan, bold = true })
set(0, "MiniClueSeparator",  { link = "MiniClueBorder" })

-- illuminate
set(0, "IlluminatedWordText",  { bg = nord.c02_gray })
set(0, "IlluminatedWordRead",  { bg = nord.c02_gray })
set(0, "IlluminatedWordWrite", { bg = nord.c10dd_blue })

-- zen
set(0, "ZenBg", { bg = nord.c00d_black })

-- fugitive
set(0, "FugitiveExtSection", { fg = nord.c09_glacier, bold = true })
set(0, "FugitiveExtKey",     { fg = nord.c08_cyan, bold = true })
set(0, "FugitiveExtDesc",    { fg = nord.c04d_white })

-- git-conflict
set(0, "GitConflictCurrentLabel",  { fg = nord.c00_black, bg = nord.c14d_green, bold = true, italic = true })
set(0, "GitConflictIncomingLabel", { fg = nord.c00_black, bg = nord.c13d_yellow, bold = true, italic = true})
set(0, "GitConflictMiddleLabel",   { fg = nord.c00_black, bg = nord.c15_purple, bold = true, italic = true})
set(0, "GitConflictAncestorLabel", { fg = nord.c00_black, bg = nord.c15_purple, bold = true, italic = true, nocombine = true })
set(0, "GitConflictCurrent",       { nocombine = true })
set(0, "GitConflictIncoming",      { nocombine = true })
set(0, "GitConflictAncestor",      { nocombine = true })
