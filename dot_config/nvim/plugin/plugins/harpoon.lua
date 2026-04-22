vim.pack.add({
    { src = "gh:ThePrimeagen/harpoon", version = "harpoon2" },
    "gh:nvim-lua/plenary.nvim",
})
local harpoon = require("harpoon")
harpoon:setup()

-- TODO: Telescope

local set = require("utils.keymap").set
-- stylua: ignore start
set("n", "g1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
set("n", "g2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
set("n", "g3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
set("n", "g4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
set("n", "g5", function() harpoon:list():select(5) end, { desc = "Harpoon 5" })
set("n", "g6", function() harpoon:list():select(6) end, { desc = "Harpoon 6" })
set("n", "g7", function() harpoon:list():select(7) end, { desc = "Harpoon 7" })
set("n", "g8", function() harpoon:list():select(8) end, { desc = "Harpoon 8" })
set("n", "+",  function() harpoon:list():add() end,     { desc = "Add Harpoon" })
-- vim.keymap.set("n", "]h", function() harpoon:list():next() end, { desc = "Next Harpoon" })
-- vim.keymap.set("n", "[h", function() harpoon:list():prev() end, { desc = "Prev Harpoon" })
local menu_opts = { ui_fallback_width = 60, ui_width_ratio = 0.40, title_pos = "center" }
set("n", "<C-f>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), menu_opts) end, { desc = "Harpoon Menu" })

harpoon:extend({
    UI_CREATE = function(cx)
        set("n", "<C-v>", function() harpoon.ui:select_menu_item({ vsplit = true }) end,  { buf = cx.bufnr })
        set("n", "<C-x>", function() harpoon.ui:select_menu_item({ split = true }) end,   { buf = cx.bufnr })
        set("n", "<C-t>", function() harpoon.ui:select_menu_item({ tabedit = true }) end, { buf = cx.bufnr })
  end,
})
-- stylua: ignore end
