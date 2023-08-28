local M = {}
local nord = require("utils.nord")

-- stylua: ignore 
local function editor()
    -- Basic
    vim.api.nvim_set_hl(0, "Bold",      { bold = true })
    vim.api.nvim_set_hl(0, "Italic",    { italic = true })
    vim.api.nvim_set_hl(0, "Strike",    { strikethrough = true })
    vim.api.nvim_set_hl(0, "Underline", { underline = true })
    vim.api.nvim_set_hl(0, "Undercurl", { undercurl = true })
    -- Editor
    vim.api.nvim_set_hl(0, "Normal",       { fg = nord.fg })
    vim.api.nvim_set_hl(0, "NormalFloat",  { fg = nord.fg })
    vim.api.nvim_set_hl(0, "FloatTitle",   { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "FloatBorder",  { fg = nord.c03_gry_br })
    vim.api.nvim_set_hl(0, "Pmenu",        { fg = nord.fg, bg = nord.c01_gry })
    vim.api.nvim_set_hl(0, "PmenuSel",     { bg = nord.visual })
    vim.api.nvim_set_hl(0, "PmenuSbar",    { bg = nord.c03_gry_br })
    vim.api.nvim_set_hl(0, "PmenuThumb",   { bg = nord.c03_gry_br })
    vim.api.nvim_set_hl(0, "ColorColumn",  { bg = nord.c01_gry }) -- used for the columns set with 'colorcolumn'
    vim.api.nvim_set_hl(0, "Conceal",      { fg = nord.c03_gry_br }) -- placeholder characters substituted for concealed text (see 'conceallevel')
    vim.api.nvim_set_hl(0, "Cursor",       { fg = nord.bg, bg = nord.fg }) -- the character under the cursor
    vim.api.nvim_set_hl(0, "CursorIM",     { fg = nord.bg, bg = nord.fg }) -- like Cursor, but used when in IME mode
    vim.api.nvim_set_hl(0, "CursorLine",   { bg = nord.cursorline })
    vim.api.nvim_set_hl(0, "CursorColumn", { bg = nord.cursorline })
    vim.api.nvim_set_hl(0, "Folded",       { fg = nord.c03_gry, bg = nord.c00_blk_br })
    vim.api.nvim_set_hl(0, "MatchParen",   { fg = nord.c13_ylw, bg = nord.c03_gry, bold = true })
    vim.api.nvim_set_hl(0, "NonText",      { fg = nord.c02_gry })
    vim.api.nvim_set_hl(0, "SpecialKey",   { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "Visual",       { bg = nord.visual })
    vim.api.nvim_set_hl(0, "VisualNOS",    { bg = nord.visual })
    vim.api.nvim_set_hl(0, "QuickFixLine", { bg = nord.cursorline })
    -- Spell
    vim.api.nvim_set_hl(0, "SpellBad",    { fg = nord.error, undercurl = true })
    vim.api.nvim_set_hl(0, "SpellCap",    { fg = nord.nord7_gui, undercurl = true })
    vim.api.nvim_set_hl(0, "SpellLocal",  { fg = nord.nord8_gui, undercurl = true })
    vim.api.nvim_set_hl(0, "SpellRare",   { fg = nord.nord9_gui, undercurl = true })
    -- File Navigation
    vim.api.nvim_set_hl(0, "Directory",   { fg = nord.c08_teal }) -- directory names (and other special names in listings)
    -- Search
    vim.api.nvim_set_hl(0, "IncSearch",   { fg = nord.c06_wht, bg = nord.c10_blue })
    vim.api.nvim_set_hl(0, "Search",      { fg = nord.c06_wht, bg = nord.c10_blue })
    vim.api.nvim_set_hl(0, "Substitute",  { fg = nord.c06_wht, bg = nord.c10_blue })
    -- Prompt
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = nord.c01_gry })
    vim.api.nvim_set_hl(0, "ModeMsg",     { fg = nord.fg, bold=true })
    vim.api.nvim_set_hl(0, "MoreMsg",     { fg = nord.c08_teal, bold=true })
    vim.api.nvim_set_hl(0, "ErrorMsg",    { fg = nord.fg, bg = nord.error })
    vim.api.nvim_set_hl(0, "WarningMsg",  { fg = nord.bg, bg = nord.warn })
    vim.api.nvim_set_hl(0, "Question",    { fg = nord.c07_jade, bold=true })
    vim.api.nvim_set_hl(0, "WildMenu",    { fg = nord.c08_teal })
    -- StatusLine
    vim.api.nvim_set_hl(0, "StatusLine",       { fg = nord.fg, bg = nord.c02_gry })
    vim.api.nvim_set_hl(0, "StatusLineNC",     { fg = nord.fg, bg = nord.c01_gry })
    vim.api.nvim_set_hl(0, "StatusLineTerm",   { fg = nord.fg, bg = nord.c02_gry })
    vim.api.nvim_set_hl(0, "StatusLineTermNC", { fg = nord.fg, bg = nord.c01_gry })
    -- TabLine
    vim.api.nvim_set_hl(0, "Tabline",       { fg = nord.fg, bg = nord.c01_gry })
    vim.api.nvim_set_hl(0, "TabLineFill",   { fg = nord.fg, bg = nord.c00_blk_dk })
    vim.api.nvim_set_hl(0, "TablineSel",    { fg = nord.c08_teal, bg = nord.c03_gry })
    -- Window
    vim.api.nvim_set_hl(0, "Title",         { fg = nord.fg, bold = true })
    vim.api.nvim_set_hl(0, "VertSplit",     { fg = nord.c02_gry })
    -- Gutter
    vim.api.nvim_set_hl(0, "LineNr",        { fg = nord.c03_gry })
    vim.api.nvim_set_hl(0, "CursorLineNr",  { fg = nord.fg })
    vim.api.nvim_set_hl(0, "FoldColumn",    { fg = nord.c03_gry })
    vim.api.nvim_set_hl(0, "SignColumn",    { fg = nord.c01_gry })
    -- Diff
    vim.api.nvim_set_hl(0, "DiffAdd",     { fg = nord.c00_blk, bg = nord.c14_grn })
    vim.api.nvim_set_hl(0, "DiffChange",  { fg = nord.c00_blk, bg = nord.c13_ylw })
    vim.api.nvim_set_hl(0, "DiffDelete",  { fg = nord.c00_blk, bg = nord.c11_red })
    vim.api.nvim_set_hl(0, "DiffText",    { fg = nord.c00_blk, bg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "DiffAdded",   { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "DiffChanged", { link = "DiffChange" })
    vim.api.nvim_set_hl(0, "DiffRemoved", { link = "DiffDelete" })
    -- Etc
    vim.api.nvim_set_hl(0, "healthError",   { fg = nord.error })
    vim.api.nvim_set_hl(0, "healthSuccess", { fg = nord.ok })
    vim.api.nvim_set_hl(0, "healthWarning", { fg = nord.warn })
end

-- stylua: ignore
local function syntax()
    vim.api.nvim_set_hl(0, "Boolean",        { fg = nord.c09_glcr })    -- a boolean constant: true, false
    vim.api.nvim_set_hl(0, "Character",      { fg = nord.c14_grn })     -- any character constant: 'c', '\n'
    vim.api.nvim_set_hl(0, "Comment",        { fg = nord.c03_gry_br, --[[italic = true]] })
    vim.api.nvim_set_hl(0, "Conditional",    { fg = nord.c09_glcr })    -- if, then, else, endif, switch, etc.
    vim.api.nvim_set_hl(0, "Constant",       { fg = nord.fg })          -- any constant
    vim.api.nvim_set_hl(0, "Decorator",      { fg = nord.c12_orng })    -- ??
    vim.api.nvim_set_hl(0, "Debug",          { fg = nord.error })       -- debugging statements
    vim.api.nvim_set_hl(0, "Define",         { fg = nord.c09_glcr })    -- preprocessor #define
    vim.api.nvim_set_hl(0, "Delimiter",      { fg = nord.c06_wht })     -- character that needs attention like, or .
    vim.api.nvim_set_hl(0, "Error",          { fg = nord.error })       -- any erroneous construct
    vim.api.nvim_set_hl(0, "Exception",      { fg = nord.c09_glcr })    -- try, catch, throw
    vim.api.nvim_set_hl(0, "Float",          { fg = nord.c15_prpl })    -- a floating point constant: 2.3e10
    vim.api.nvim_set_hl(0, "Function",       { fg = nord.c08_teal })    -- funtion names
    vim.api.nvim_set_hl(0, "Identifier",     { fg = nord.fg })          -- any variable name
    vim.api.nvim_set_hl(0, "Ignore",         { fg = nord.c01_gry })     -- left blank, hidden
    vim.api.nvim_set_hl(0, "Include",        { fg = nord.c09_glcr })    -- preprocessor #include
    vim.api.nvim_set_hl(0, "Keyword",        { fg = nord.c09_glcr })    -- for, do, while, etc.
    vim.api.nvim_set_hl(0, "Label",          { fg = nord.c09_glcr })    -- case, default, etc.
    vim.api.nvim_set_hl(0, "Macro",          { fg = nord.c09_glcr })    -- same as Define
    vim.api.nvim_set_hl(0, "Number",         { fg = nord.c15_prpl })    -- a number constant: 5
    vim.api.nvim_set_hl(0, "Operator",       { fg = nord.c09_glcr })    -- sizeof", "+", "*", etc.
    vim.api.nvim_set_hl(0, "PreCondit",      { fg = nord.c13_ylw })     -- preprocessor #if, #else, #endif, etc.
    vim.api.nvim_set_hl(0, "PreProc",        { fg = nord.c09_glcr })    -- generic Preprocessor
    vim.api.nvim_set_hl(0, "Repeat",         { fg = nord.c09_glcr })    -- any other keyword
    vim.api.nvim_set_hl(0, "Special",        { fg = nord.fg })          -- any special symbol
    vim.api.nvim_set_hl(0, "SpecialChar",    { fg = nord.c13_ylw })     -- special character in a constant
    vim.api.nvim_set_hl(0, "SpecialComment", { fg = nord.c08_teal })    -- special things inside a comment
    vim.api.nvim_set_hl(0, "Statement",      { fg = nord.c09_glcr })    -- any statement
    vim.api.nvim_set_hl(0, "StorageClass",   { fg = nord.c09_glcr })    -- static, register, volatile, etc.
    vim.api.nvim_set_hl(0, "String",         { fg = nord.c14_grn })     -- any string
    vim.api.nvim_set_hl(0, "Structure",      { fg = nord.c09_glcr })    -- struct, union, enum, etc.
    vim.api.nvim_set_hl(0, "Tag",            { fg = nord.fg })          -- you can use CTRL-] on this
    vim.api.nvim_set_hl(0, "Todo",           { fg = nord.c13_ylw })     -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    vim.api.nvim_set_hl(0, "Type",           { fg = nord.c09_glcr })    -- int, long, char, etc.
    vim.api.nvim_set_hl(0, "Typedef",        { fg = nord.c09_glcr })    -- A typedef
    vim.api.nvim_set_hl(0, "Annotation",     { fg = nord.c12_orng })    -- same as Decorator
    vim.api.nvim_set_hl(0, "Variable",       { fg = nord.fg })          -- same as Identifier
end

-- stylua: ignore
local function lsp()
    vim.api.nvim_set_hl(0,"DiagnosticError",            { fg = nord.error })
    vim.api.nvim_set_hl(0,"DiagnosticWarn",             { fg = nord.warn })
    vim.api.nvim_set_hl(0,"DiagnosticInfo",             { fg = nord.info })
    vim.api.nvim_set_hl(0,"DiagnosticHint",             { fg = nord.hint })
    vim.api.nvim_set_hl(0,"DiagnosticOk",               { fg = nord.ok })
    vim.api.nvim_set_hl(0,"DiagnosticUnderlineWarn",    { fg = nord.warn, undercurl=true })
    vim.api.nvim_set_hl(0,"DiagnosticVirtualTextWarn",  { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0,"DiagnosticFloatingWarn",     { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0,"DiagnosticSignWarn",         { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0,"DiagnosticUnderlineError",   { fg = nord.error, undercurl=true })
    vim.api.nvim_set_hl(0,"DiagnosticVirtualTextError", { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0,"DiagnosticFloatingError",    { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0,"DiagnosticSignError",        { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0,"DiagnosticUnderlineInfo",    { fg = nord.info, undercurl=true })
    vim.api.nvim_set_hl(0,"DiagnosticVirtualTextInfo",  { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0,"DiagnosticFloatingInfo",     { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0,"DiagnosticSignInfo",         { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0,"DiagnosticUnderlineHint",    { fg = nord.hint, undercurl=true })
    vim.api.nvim_set_hl(0,"DiagnosticVirtualTextHint",  { link = "DiagnosticHint" })
    vim.api.nvim_set_hl(0,"DiagnosticFloatingHint",     { link = "DiagnosticHint" })
    vim.api.nvim_set_hl(0,"DiagnosticSignHint",         { link = "DiagnosticHint" })
    vim.api.nvim_set_hl(0,"DiagnosticUnderlineOk",      { fg = nord.ok, undercurl=true })
    vim.api.nvim_set_hl(0,"DiagnosticVirtualTextOk",    { link = "DiagnosticOk" })
    vim.api.nvim_set_hl(0,"DiagnosticFloatingOk",       { link = "DiagnosticOk" })
    vim.api.nvim_set_hl(0,"DiagnosticSignOk",           { link = "DiagnosticOk" })

    vim.api.nvim_set_hl(0,"LspDiagnosticsError",                  { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsWarning",                { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsInformation",            { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsHint",                   { link = "DiagnosticHint" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsDefaultError",           { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsSignError",              { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsFloatingError",          { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsVirtualTextError",       { link = "DiagnosticError" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsUnderlineError",         { sp = nord.error, undercurl=true })
    vim.api.nvim_set_hl(0,"LspDiagnosticsDefaultWarning",         { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsSignWarning",            { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsFloatingWarning",        { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsVirtualTextWarning",     { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsUnderlineWarning",       { sp = nord.warn, undercurl=true })
    vim.api.nvim_set_hl(0,"LspDiagnosticsDefaultInformation",     { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsSignInformation",        { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsFloatingInformation",    { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsVirtualTextInformation", { link = "DiagnosticInfo" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsUnderlineInformation",   { sp = nord.info, undercurl=true})
    vim.api.nvim_set_hl(0,"LspDiagnosticsDefaultHint",            { link = "DiagnosticHint" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsSignHint",               { link = "DiagnosticHint" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsFloatingHint",           { link = "DiagnosticHint" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsVirtualTextHint",        { link = "DiagnosticHint" })
    vim.api.nvim_set_hl(0,"LspDiagnosticsUnderlineHint",          { sp = nord.hint, undercurl=true })
    vim.api.nvim_set_hl(0,"LspReferenceText",                     { bg = nord.c03_gry }) -- used for highlighting "text" references
    vim.api.nvim_set_hl(0,"LspReferenceRead",                     { bg = nord.c03_gry }) -- used for highlighting "read" references
    vim.api.nvim_set_hl(0,"LspReferenceWrite",                    { bg = nord.c03_gry }) -- used for highlighting "write" references
    vim.api.nvim_set_hl(0,"LspInlayHint",                         { link = "Comment" })
end

-- stylua: ignore
local function treesitter()
    vim.api.nvim_set_hl(0, "@text",                  { link = "Normal" })
    vim.api.nvim_set_hl(0, "@text.literal",          { fg = nord.c04_wht_dk })
    vim.api.nvim_set_hl(0, "@text.reference",        { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "@text.title",            { link = "Title" })
    vim.api.nvim_set_hl(0, "@text.uri",              { link = "Underline" })
    vim.api.nvim_set_hl(0, "@text.strong",           { link = "Bold" })
    vim.api.nvim_set_hl(0, "@text.emphasis",         { link = "Italic" })
    vim.api.nvim_set_hl(0, "@text.underline",        { link = "Underline" })
    vim.api.nvim_set_hl(0, "@text.strike",           { link = "Strike" })
    vim.api.nvim_set_hl(0, "@text.todo",             { link = "Todo" })
    vim.api.nvim_set_hl(0, "@text.todo.checked",     { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "@text.todo.unchecked",   { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "@text.quote",            { link = "Comment" })

    vim.api.nvim_set_hl(0, "@comment",               { link = "Comment" })
    vim.api.nvim_set_hl(0, "@punctuation",           { link = "Delimiter" })
    vim.api.nvim_set_hl(0, "@punctuation.bracket",   { fg = nord.fg })
    vim.api.nvim_set_hl(0, "@punctuation.special",   { link = "SpecialKey" })
    vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Delimiter" })
    vim.api.nvim_set_hl(0, "@punctuation.delimiter.markdown", { link = "Comment" })

    vim.api.nvim_set_hl(0, "@constant",              { link = "Constant" })
    vim.api.nvim_set_hl(0, "@constant.builtin",      { link = "Special" })
    vim.api.nvim_set_hl(0, "@constant.macro",        { link = "Define" })
    vim.api.nvim_set_hl(0, "@define",                { link = "Define" })
    vim.api.nvim_set_hl(0, "@macro",                 { link = "Macro" })
    vim.api.nvim_set_hl(0, "@string",                { link = "String" })
    vim.api.nvim_set_hl(0, "@string.escape",         { link = "SpecialChar" })
    vim.api.nvim_set_hl(0, "@string.special",        { link = "SpecialChar" })
    vim.api.nvim_set_hl(0, "@string.regex",          { fg = nord.c13_ylw })
    vim.api.nvim_set_hl(0, "@character",             { link = "Character" })
    vim.api.nvim_set_hl(0, "@character.special",     { link = "SpecialChar" })
    vim.api.nvim_set_hl(0, "@number",                { link = "Number" })
    vim.api.nvim_set_hl(0, "@boolean",               { link = "Boolean" })
    vim.api.nvim_set_hl(0, "@float",                 { link = "Float" })

    vim.api.nvim_set_hl(0, "@function",              { link = "Function" })
    vim.api.nvim_set_hl(0, "@function.builtin",      { link = "Special" })
    vim.api.nvim_set_hl(0, "@funtion.macro",         { link = "Macro" })
    vim.api.nvim_set_hl(0, "@parameter",             { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@method",                { link = "Function" })
    vim.api.nvim_set_hl(0, "@field",                 { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@property",              { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@constructor",           { link = "Special" })

    vim.api.nvim_set_hl(0, "@conditional",           { link = "Conditional" })
    vim.api.nvim_set_hl(0, "@repeat",                { link = "Repeat" })
    vim.api.nvim_set_hl(0, "@label",                 { link = "Label" })
    vim.api.nvim_set_hl(0, "@operator",              { link = "Operator" })
    vim.api.nvim_set_hl(0, "@keyword",               { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@keyword.function",      { link = "Function" })
    vim.api.nvim_set_hl(0, "@keyword.operator",      { link = "Operator" })
    vim.api.nvim_set_hl(0, "@keyword.return",        { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@exception",             { link = "Exception" })

    vim.api.nvim_set_hl(0, "@variable",              { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@variable.builtin",      { link = "@variable" })
    vim.api.nvim_set_hl(0, "@variable.global",       { link = "@variable" })
    vim.api.nvim_set_hl(0, "@type",                  { link = "Type" })
    vim.api.nvim_set_hl(0, "@type.definition",       { link = "Typedef" })
    vim.api.nvim_set_hl(0, "@type.builtin",          { link = "Type" })
    vim.api.nvim_set_hl(0, "@namespace",             { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@include",               { link = "Include" })
    vim.api.nvim_set_hl(0, "@preproc",               { link = "PreProc" })
    vim.api.nvim_set_hl(0, "@debug",                 { link = "Debug" })
    vim.api.nvim_set_hl(0, "@tag",                   { fg = nord.c08_teal })
    vim.api.nvim_set_hl(0, "@tag.delimiter",         { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "@tag.attribute",         { fg = nord.c08_teal })
    -- vim.api.nvim_set_hl(0, "@tag",                   { link = "Tag" })
    -- vim.api.nvim_set_hl(0, "@tag.delimiter",         { link = "Delimiter" })

    -- TODO: unknown
    vim.api.nvim_set_hl(0, "@attribute",             { fg = nord.nord15_gui })
    vim.api.nvim_set_hl(0, "@error",                 { fg = nord.error })
    vim.api.nvim_set_hl(0, "@symbol",                { fg = nord.nord15_gui })
    vim.api.nvim_set_hl(0, "@text.note",             { fg = nord.info })
    vim.api.nvim_set_hl(0, "@text.warning",          { fg = nord.warning })
    vim.api.nvim_set_hl(0, "@text.danger",           { fg = nord.error })
    vim.api.nvim_set_hl(0, "@conceal", { link = "Conceal" })
    -- vim.api.nvim_set_hl(0, "@spell", { link = "Delimiter" })
    -- @function.call
    -- @method.call
    -- @type.qualifier
    -- @text.math (e.g. for LaTeX math environments)
    -- @text.environment (e.g. for text environments of markup languages)
    -- @text.environment.name (e.g. for the name/the string indicating the type of text environment)
end

-- stylua: ignore
local function markdown()
    vim.api.nvim_set_hl(0, "htmlH1", { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "htmlH2", { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "htmlH3", { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "htmlH4", { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "htmlH5", { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "htmlH6", { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "htmlLink", { fg = nord.c10_blue, underline = true })
    vim.api.nvim_set_hl(0, "markdownH1",          { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "markdownH1Delimiter", { fg = nord.c08_teal })
    vim.api.nvim_set_hl(0, "markdownH2",          { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "markdownH2Delimiter", { fg = nord.c08_teal })
    vim.api.nvim_set_hl(0, "markdownH3",          { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "markdownH3Delimiter", { fg = nord.c08_teal })
    vim.api.nvim_set_hl(0, "markdownH4",          { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "markdownH4Delimiter", { fg = nord.c08_teal })
    vim.api.nvim_set_hl(0, "markdownH5",          { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "markdownH5Delimiter", { fg = nord.c08_teal })
    vim.api.nvim_set_hl(0, "markdownH6",          { fg = nord.c08_teal, bold = true })
    vim.api.nvim_set_hl(0, "markdownH6Delimiter", { fg = nord.c08_teal })
    vim.api.nvim_set_hl(0, "markdownUrl", { link = "Comment" })

    vim.api.nvim_set_hl(0, "@text.title.1.marker", { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "@text.title.2.marker", { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "@text.title.3.marker", { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "@text.title.4.marker", { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "@text.title.5.marker", { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "@text.title.6.marker", { fg = nord.c09_glcr })
    vim.api.nvim_set_hl(0, "@text.title.1", { fg = nord.c08_teal, bold = true})
    vim.api.nvim_set_hl(0, "@text.title.2", { fg = nord.c08_teal, bold = true})
    vim.api.nvim_set_hl(0, "@text.title.3", { fg = nord.c08_teal, bold = true})
    vim.api.nvim_set_hl(0, "@text.title.4", { fg = nord.c08_teal, bold = true})
    vim.api.nvim_set_hl(0, "@text.title.5", { fg = nord.c08_teal, bold = true})
    vim.api.nvim_set_hl(0, "@text.title.6", { fg = nord.c08_teal, bold = true})
end

---Applies custom highlights
function M.apply_highlights()
    editor()
    syntax()
    lsp()
    treesitter()
    markdown()

    -- Unknown
    -- vim.api.nvim_set_hl(0, "ToolbarButton", { fg = nord.nord4_gui, bg = nord.none, bold=true })
    -- vim.api.nvim_set_hl(0, "ToolbarLine", { fg = nord.nord4_gui, bg = nord.nord1_gui })
    -- vim.api.nvim_set_hl(0, "qfLineNr", { fg = nord.nord4_gui, bg = nord.none, reverse=true })

    -- Markdown

    -- nvim-dap
    -- vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = nord.nord14_gui })
    -- vim.api.nvim_set_hl(0, "DapStopped", { fg = nord.nord15_gui })

    -- nvim-dap-ui
    -- vim.api.nvim_set_hl(0, "DapUIVariable", { fg = nord.nord4_gui })
    -- vim.api.nvim_set_hl(0, "DapUIScope", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIType", { fg = nord.nord9_gui })
    -- vim.api.nvim_set_hl(0, "DapUIValue", { fg = nord.nord4_gui })
    -- vim.api.nvim_set_hl(0, "DapUIModifiedValue", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIDecoration", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIThread", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIStoppedThread", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIFrameName", { fg = nord.nord4_gui })
    -- vim.api.nvim_set_hl(0, "DapUISource", { fg = nord.nord9_gui })
    -- vim.api.nvim_set_hl(0, "DapUILineNumber", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIFloatBorder", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { fg = nord.nord11_gui })
    -- vim.api.nvim_set_hl(0, "DapUIWatchesValue", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIWatchesError", { fg = nord.nord11_gui })
    -- vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { fg = nord.nord8_gui })
    -- vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { fg = nord.nord8_gui })
end

return M
