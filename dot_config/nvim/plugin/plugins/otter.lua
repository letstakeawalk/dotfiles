vim.g.otter_is_active = false

local function toggle_otter()
    if vim.g.otter_is_active then
        require("otter").activate()
        vim.notify("Otter activated")
    else
        require("otter").deactivate()
        vim.notify("Otter deactivated")
    end
end

vim.pack.add({
    "gh:jmbuhr/otter.nvim",
    "gh:nvim-treesitter/nvim-treesitter",
})
require("utils.keymap").set("n", "<leader>do", toggle_otter, { desc = "Otter Toggle" })
