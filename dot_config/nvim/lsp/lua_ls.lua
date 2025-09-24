return {
    settings = {
        Lua = {
            completion = { callSnippet = "Replace" },
            format = { enable = false }, -- use stylua instead
            hint = {
                enable = true,
                arrayIndex = "Disable",
            },
            -- TODO: check options: format, inlay hint, codelens
        },
    },
}
-- TODO: maybe disable some diagnostics for selene?
