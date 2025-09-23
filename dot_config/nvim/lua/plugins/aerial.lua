return {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = "Telescope aerial",
    keys = {
        { "<leader>da", "<cmd>AerialToggle!<cr>", desc = "Aerial" },
        { "]s", desc = "Goto next aerial symbol" },
        { "[s", desc = "Goto previous aerial symbol" },
        { "]S", desc = "Goto next aerial symbol (up)" },
        { "[S", desc = "Goto previous aerial symbol (up)" },
    },
    opts = {
        backends = { "lsp", "treesitter", "markdown", "man" },
        layout = {
            default_direction = "prefer_left",
            placement = "edge", -- edge | window
            max_width = { 30, 0.2 },
            min_width = 20,
        },
        on_attach = function(bufnr)
            local aerial = require("aerial")
            local repeat_move = require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair
            local next_sym, prev_sym = repeat_move(aerial.next, aerial.prev)
            local next_sym_up, prev_sym_up = repeat_move(aerial.next_up, aerial.prev_up)
            vim.keymap.set("n", "]s", next_sym, { desc = "Goto next aerial symbol", buffer = bufnr })
            vim.keymap.set("n", "[s", prev_sym, { desc = "Goto previous aerial symbol", buffer = bufnr })
            vim.keymap.set("n", "]S", next_sym_up, { desc = "Goto next aerial symbol (up)", buffer = bufnr })
            vim.keymap.set("n", "[S", prev_sym_up, { desc = "Goto previous aerial symbol (up)", buffer = bufnr })
            -- vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { desc = "AerialPrev" })
            -- vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { desc = "AerialNext" })
        end,
        highlight_on_jump = false,
        keymaps = {
            ["?"] = "actions.show_help",
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.jump",
            ["<2-LeftMouse>"] = "actions.jump",
            ["<C-v>"] = "actions.jump_vsplit",
            ["<C-s>"] = "actions.jump_split",
            ["p"] = "actions.scroll",
            ["<C-j>"] = false,
            ["<C-l>"] = false,
            ["<C-k>"] = "actions.down_and_scroll",
            ["<C-h>"] = "actions.up_and_scroll",
            ["<Up>"] = "actions.prev",
            ["<Down>"] = "actions.next",
            ["h"] = "actions.prev",
            ["k"] = "actions.next",
            ["{"] = "actions.prev",
            ["}"] = "actions.next",
            ["[["] = "actions.prev_up",
            ["]]"] = "actions.next_up",
            ["q"] = "actions.close",
            ["o"] = "actions.tree_toggle",
            ["za"] = "actions.tree_toggle",
            ["O"] = "actions.tree_toggle_recursive",
            ["zA"] = "actions.tree_toggle_recursive",
            ["l"] = "actions.tree_open",
            ["zo"] = "actions.tree_open",
            ["L"] = "actions.tree_open_recursive",
            ["zO"] = "actions.tree_open_recursive",
            ["j"] = "actions.tree_close",
            ["zc"] = "actions.tree_close",
            ["J"] = "actions.tree_close_recursive",
            ["zC"] = "actions.tree_close_recursive",
            ["zr"] = "actions.tree_increase_fold_level",
            ["zR"] = "actions.tree_open_all",
            ["zm"] = "actions.tree_decrease_fold_level",
            ["zM"] = "actions.tree_close_all",
            ["zx"] = "actions.tree_sync_folds",
            ["zX"] = "actions.tree_sync_folds",
        },
        nav = {
            border = "rounded",
            max_height = 0.9,
            min_height = { 10, 0.1 },
            max_width = 0.5,
            min_width = { 0.2, 20 },
            win_opts = { cursorline = true, winblend = 0 },
            -- Jump to symbol in source window when the cursor moves
            autojump = false,
            -- Show a preview of the code in the right column, when there are no child symbols
            preview = false,
            -- Keymaps in the nav window
            keymaps = {
                ["<CR>"] = "actions.jump",
                ["<2-LeftMouse>"] = "actions.jump",
                ["<C-v>"] = "actions.jump_vsplit",
                ["<C-s>"] = "actions.jump_split",
                ["h"] = "actions.prev",
                ["k"] = "actions.next",
                ["j"] = "actions.left",
                ["l"] = "actions.right",
                ["<C-c>"] = "actions.close",
                ["q"] = "actions.close",
            },
        },
        post_jump_cmd = "normal! zz",
    },
}
