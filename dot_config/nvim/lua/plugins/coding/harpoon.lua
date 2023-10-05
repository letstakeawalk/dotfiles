return {
    "ThePrimeagen/harpoon",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
        local harpoon = require("harpoon")
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        vim.keymap.set("n", "+", mark.add_file, { desc = "Next Harpoon" })
        vim.keymap.set("n", "<C-p>", ui.toggle_quick_menu, { desc = "Next Harpoon" })
        -- vim.keymap.set("n", "}", ui.nav_next, { desc = "Next Harpoon" })
        -- vim.keymap.set("n", "{", ui.nav_prev, { desc = "Prev Harpoon" })
        -- stylua: ignore start 
        vim.keymap.set("n", "_", function() ui.nav_file(1) end, { desc = "Harpoon 1" })
        vim.keymap.set("n", "(", function() ui.nav_file(2) end, { desc = "Harpoon 2" })
        vim.keymap.set("n", ")", function() ui.nav_file(3) end, { desc = "Harpoon 3" })
        vim.keymap.set("n", "=", function() ui.nav_file(4) end, { desc = "Harpoon 4" })
        vim.keymap.set("n", "-", function() ui.nav_file(5) end, { desc = "Harpoon 5" })
        vim.keymap.set("n", '"', function() ui.nav_file(6) end, { desc = "Harpoon 6" })
        vim.keymap.set("n", "<PageDown>", ui.nav_prev, { desc = "Prev Harpoon" })
        vim.keymap.set("n", "<PageUp>",   ui.nav_next, { desc = "Next Harpoon" })
        -- stylua: ignore end

        harpoon.setup({
            -- enable tabline with harpoon marks
            tabline = true,
            tabline_prefix = "    ",
            tabline_suffix = "    ",

            -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
            -- save_on_toggle = false,
            -- saves the harpoon file upon every change. disabling is unrecommended.
            -- save_on_change = true,
            -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
            -- enter_on_sendcmd = false,
            -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
            -- tmux_autoclose_windows = false,
            -- filetypes that you want to prevent from adding to the harpoon list menu.
            -- excluded_filetypes = { "harpoon" },
            -- set marks specific to each git branch inside git repository
            -- mark_branch = false,
        })

        local nord = require("utils.nord")
        vim.api.nvim_set_hl(0, "HarpoonActive", { fg = nord.c05_wht, bold = true })
        vim.api.nvim_set_hl(0, "HarpoonInactive", { fg = "#63698c" })
        vim.api.nvim_set_hl(0, "HarpoonNumberActive", { fg = "#7aa2f7" })
        vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { fg = "#7aa2f7" })
    end,
}
