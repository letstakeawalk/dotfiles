return {
    settings = {
        svelte = {
            plugin = {
                svelte = {
                    defaultScriptLanguage = "ts",
                    compilerWarnings = {
                        ["unused-export-let"] = "ignore",
                        ["a11y-invalid-attribute"] = "ignore",
                    },
                },
            },
        },
    },
}
