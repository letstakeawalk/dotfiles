return {
    "kazhala/close-buffers.nvim", -- preserve window layout with bdelete/bwipeout
    cmd = { "BDelete", "BWipeout" },
    keys = {
        { "<leader>qq", "<cmd>q<cr>", desc = "Quit" },
        -- { "<leader>qa", "<cmd>bufdo bd<cr>", desc = "Close all buffers" },
        { "<leader>qa", "<cmd>BWipeout all<cr>", desc = "Close all buffers" },
        { "<leader>qo", "<cmd>BWipeout other<cr>", desc = "Close other buffers" },
        { "<leader>qt", "<cmd>BWipeout this<cr>", desc = "Close this buffer" },
        -- { "<leader>qt", "<cmd>BDelete this<cr>", desc = "Close this buffer" },
    },
    opts = {

        filetype_ignore = {}, -- Filetype to ignore when running deletions
        file_glob_ignore = {}, -- File name glob pattern to ignore when running deletions (e.g. '*.md')
        file_regex_ignore = {}, -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
        preserve_window_layout = { "this", "nameless" }, -- Types of deletion that should preserve the window layout
        -- Custom function to retrieve the next buffer when preserving window layout
        -- retrieve the last used buffer
        next_buffer_cmd = function()
            -- local num_wins = #vim.api.nvim_list_wins()
            local bufs = vim.tbl_filter(function(b) return b.listed == 1 end, vim.fn.getbufinfo() or {})
            table.sort(bufs, function(a, b) return a.lastused > b.lastused end)
            if #bufs > 1 then
                local most_recent = bufs[2].bufnr -- when num of wins > 2, unexpected result
                vim.api.nvim_win_set_buf(0, most_recent)
            end
        end,
    },
}
