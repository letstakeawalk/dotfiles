local function escape()
    return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<right><esc>" or "<esc>"
end

return {
    "max397574/better-escape.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
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
    end,
}
