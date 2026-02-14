local util = require("utils.lspconfig")

---@type vim.lsp.Config
return {
    cmd = { "oxfmt", "--lsp" },
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
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root_markers = util.insert_package_json({ ".oxfmtrc.json", ".oxfmtrc.jsonc" }, "oxfmt", fname)
        on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
    end,
}
