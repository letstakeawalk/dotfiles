return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
            codelens = { enable = true },
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
