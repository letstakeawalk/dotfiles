vim.pack.add({ "gh:RRethy/vim-illuminate" })

local illu = require("illuminate")
illu.configure({
    providers = { "lsp", "treesitter" },
    delay = 500,
    min_count_to_highlight = 2,
})

local utils = require("utils")
local set = utils.keymap.set
local next_ref, prev_ref = utils.repeatable(illu.goto_next_reference, illu.goto_prev_reference)
set("n", "<C-p>", prev_ref, { desc = "Goto previous Reference" })
set("n", "<C-n>", next_ref, { desc = "Goto next Reference" })
set("n", "[r", prev_ref, { desc = "Goto previous Reference" })
set("n", "]r", next_ref, { desc = "Goto next Reference" })
