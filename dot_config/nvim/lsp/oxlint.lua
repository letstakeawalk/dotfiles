--- @brief
---
--- https://github.com/oxc-project/oxc
---
--- `oxc` is a linter / formatter for JavaScript / Typescript supporting over 500 rules from ESLint and its popular plugins
--- It can be installed via `npm`:
---
--- ```sh
--- npm i -g oxlint
--- ```

local util = require("utils.lspconfig")

---@type vim.lsp.Config
return {
    cmd = { "oxlint", "--lsp" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "svelte",
    },
    workspace_required = true,
    root_dir = function(bufnr, on_dir)
        local root_markers = {
            "package-lock.json",
            "yarn.lock",
            "pnpm-lock.yaml",
            "bun.lockb",
            "bun.lock",
            "deno.lock",
        }
        root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
            or vim.list_extend(root_markers, { ".git" })

        local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

        local filename = vim.api.nvim_buf_get_name(bufnr)
        local config_files = { ".oxlintrc.json", ".oxlintrc.jsonc" }
        config_files = util.insert_package_json(config_files, "oxlint", filename)
        local has_config = vim.fs.find(config_files, {
            path = filename,
            type = "file",
            limit = 1,
            upward = true,
            stop = vim.fs.dirname(project_root),
        })[1]
        if not has_config then
            return
        end

        on_dir(project_root)
    end,
}
