vim.pack.add({ "gh:danymat/neogen" })

local neogen = require("neogen")
neogen.setup({ snippet_engine = "luasnip" })

require("utils.keymap").set("n", "<leader>rd", neogen.generate, { desc = "Generate annotation" })
