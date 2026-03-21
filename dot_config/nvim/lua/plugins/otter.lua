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

return {
    "jmbuhr/otter.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>do", toggle_otter, desc = "Otter Toggle" },
    },
    opts = {},
}
