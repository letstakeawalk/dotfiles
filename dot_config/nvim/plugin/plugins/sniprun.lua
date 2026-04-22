vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "sniprun" and kind ~= "delete" then
            vim.system({ "sh", "install.sh" }, { cwd = ev.data.path })
        end
    end,
})

vim.pack.add({ "gh:michaelb/sniprun" })
require("sniprun").setup({})
