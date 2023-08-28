return {
    "L3MON4D3/LuaSnip",
    config = function()
        local ls = require("luasnip")
        local types = require("luasnip.util.types")

        ls.config.set_config({
            -- This tells LuaSnip to remember to keep around the last snippet.
            -- You can jump back into it even if you move outside of the selectiond
            history = false,
            -- This is cool cause if you have dynamic snippets, it updates as you type!
            update_events = { "TextChanged", "TextChangedI" }, -- default "InsertLeave"
            enable_autosnippets = true,
            ext_opts = {
                [types.choiceNode] = {
                    active = { virt_text = { { "⚫", "DiagnosticHint" } } },
                },
            },
        })

        -- stylua: ignore start
        vim.keymap.set({ "i", "s" }, "<C-t>", function() if ls.expand_or_locally_jumpable() then ls.jump(1) end end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-s>", function() if ls.locally_jumpable(-1) then ls.jump(-1) end end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-r>", function() if ls.choice_active() then ls.change_choice(1) end end)
        vim.keymap.set("n", "<leader>dS", "<cmd>LuaSnipUnlinkCurrent<cr>", { desc = "LuaSnip Unlink" })
        -- stylua: ignore end

        -- TODO: edit-snippet keymap
        -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#edit_snippets

        local load_snippets = function()
            print("snippets re-loaded")
            vim.cmd.source(vim.fn.expand("$XDG_CONFIG_HOME/nvim/lua/snippets/init.lua"))
        end
        require("snippets")
        vim.keymap.set("n", "<leader>Sp", load_snippets, { desc = "Reload snippets" })
    end,
}
