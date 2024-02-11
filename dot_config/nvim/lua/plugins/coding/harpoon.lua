return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "_", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
        vim.keymap.set("n", "(", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
        vim.keymap.set("n", ")", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
        vim.keymap.set("n", "=", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
        vim.keymap.set("n", "-", function() harpoon:list():select(5) end, { desc = "Harpoon 5" })
        vim.keymap.set("n", '"', function() harpoon:list():select(6) end, { desc = "Harpoon 6" })
        vim.keymap.set("n", "+", function() harpoon:list():append() end, { desc = "Add Harpoon" })
        vim.keymap.set("n", "]h", function() harpoon:list():next() end, { desc = "Next Harpoon" })
        vim.keymap.set("n", "[h", function() harpoon:list():prev() end, { desc = "Prev Harpoon" })
        local menu_opts = { ui_fallback_width = 50, ui_width_ratio = 0.35, title_pos = "center" }
        vim.keymap.set("n", "<C-p>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), menu_opts) end, { desc = "Harpoon Menu" })

        local nord = require("utils.nord")
        vim.api.nvim_set_hl(0, "HarpoonActive", { fg = nord.c04_wht, bold = true })
        vim.api.nvim_set_hl(0, "HarpoonInactive", { fg = nord.c03_gry_br, bg = nord.c00_blk_br })
        vim.api.nvim_set_hl(0, "HarpoonNumberActive", { fg = "#7aa2f7", bold = true })
        vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { fg = "#496194", bg = nord.c00_blk_br })
    end,
}
