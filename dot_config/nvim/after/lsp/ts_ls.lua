-- TODO: review
local settings = {
    format = { enable = false },
    inlayHints = {
        includeInlayParameterNameHints = "none", -- "none" | "literal" | "all"
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = false,
    },
}

return {
    settings = {
        typescript = settings,
        javascript = settings,
    },
}
