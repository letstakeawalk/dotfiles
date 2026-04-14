local function escape()
    return require("utils").escape()
end
return {
    "max397574/better-escape.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
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
    },
}
