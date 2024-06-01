return {
    "max397574/better-escape.nvim",
    event = { "InsertEnter", --[["CmdlineEnter"]] },
    config = function()
        require("better_escape").setup({
            mapping = { "kh" }, -- a table with mappings to use
            timeout = 150, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
            clear_empty_lines = false, -- clear line after escaping if there is only whitespace
            -- keys used for escaping, if it is a function will use the result everytime
            keys = function()
                return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
            end,
        })
    end,
}
