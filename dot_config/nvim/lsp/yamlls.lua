return {
    settings = {
        -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
        redhat = { telemetry = { enabled = false } },
        -- formatting disabled by default in yaml-language-server; enable it
        yaml = { format = { enable = true } },
    },
}
