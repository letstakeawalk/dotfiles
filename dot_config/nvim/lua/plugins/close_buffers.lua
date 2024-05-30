return {
    "kazhala/close-buffers.nvim", -- preserve window layout with bdelete/bwipeout
    cmd = { "BDelete", "BWipeout" },
    keys = {
        { "<leader>qa", "<cmd>BWipeout all<cr>", desc = "Close all buffers" },
        { "<leader>qo", "<cmd>BWipeout other<cr>", desc = "Close other buffers" },
        { "<leader>qt", "<cmd>BWipeout this<cr>", desc = "Close this buffer" },
    },
    opts = {
        -- Custom function to retrieve the next buffer when preserving window layout
        -- retrieve the last used buffer
        next_buffer_cmd = function()
            local bufs = vim.fn.getbufinfo({ buflisted = 1 })
            table.sort(bufs, function(a, b)
                return a.lastused > b.lastused
            end)
            if #bufs > 1 then
                vim.api.nvim_win_set_buf(0, bufs[2].bufnr)
            end
        end,
    },
}
