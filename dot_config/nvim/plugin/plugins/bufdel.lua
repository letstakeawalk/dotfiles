vim.pack.add({ "gh:wsdjeg/bufdel.nvim" })

local bufdel = require("bufdel")
local set = require("utils.keymap").set

local function del_others()
    bufdel.delete(
        function(buf)
            return buf ~= vim.api.nvim_get_current_buf()
                and vim.bo[buf].buflisted
                and not vim.bo[buf].modified
        end,
        { wipe = true }
    )
end
local function del_all()
    ---@diagnostic disable-next-line: unused-local
    bufdel.delete(function(buf) return true end, { wipe = true })
end

set("n", "<leader>qt", "<cmd>Bwipeout<cr>", { desc = "Close this buffer" })
set("n", "<leader>qo", del_others, { desc = "Close other buffers" })
set("n", "<leader>qa", del_all, { desc = "Close all buffers" })
