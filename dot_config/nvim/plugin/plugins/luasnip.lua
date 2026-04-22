vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "LuaSnip" and kind ~= "delete" then
            vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path })
        end
    end,
})

vim.pack.add({ { src = "gh:L3MON4D3/LuaSnip", version = vim.version.range("2.x") } })
local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config({
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = false,
    -- This is cool cause if you have dynamic snippets, it updates as you type!
    update_events = { "TextChanged", "TextChangedI" }, -- default "InsertLeave"
    enable_autosnippets = false, -- default false
    ext_opts = {
        [types.choiceNode] = {
            active = { virt_text = { { "⟳ ", "Type" } } },
        },
    },
})

local set = require("utils.keymap").set
-- refer to ghostty -- `^/ -> ^_`
set("is", "<C-_>", function()
    if ls.choice_active() then ls.change_choice(1) end
end, { desc = "LuaSnip next choice" })

require("luasnip.loaders.from_lua").load({
    paths = { vim.fn.stdpath("config") .. "/snippets" },
})
