vim.pack.add({ "gh:barklan/capslock.nvim" })

require("capslock").setup()
require("utils.keymap").set("ic", "<C-l>", "<Plug>CapsLockToggle")
