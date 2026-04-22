vim.pack.add({ "gh:max397574/better-escape.nvim" })

local function escape() return require("utils").escape() end

require("better_escape").setup({
    timeout = 150,
    default_mappings = false,
    mappings = {
        i = {
            k = { h = escape },
        },
        c = {
            k = { h = escape },
        },
    },
})
