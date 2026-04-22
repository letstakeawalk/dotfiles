local utils = require("utils")
local set = utils.keymap.set

-- refer to: nvim/runtime/ftplugin/nvim-pack.lua:58
local function jump_plugin(search_flags)
    return function()
        for _ = 1, vim.v.count1 do
            vim.fn.search("^## ", search_flags)
        end
        vim.cmd("normal! zt")
    end
end

local next, prev = utils.repeatable(jump_plugin("sW"), jump_plugin("bsW"))

set("n", "[[", prev, { desc = "Goto previous plugin", buf = 0 })
set("n", "]]", next, { desc = "Goto next plugin", buf = 0 })
