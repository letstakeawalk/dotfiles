vim.pack.add({ "gh:mbbill/undotree" })

require("utils.keymap").set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "UndoTree" })
