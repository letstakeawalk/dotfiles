vim.pack.add({
    "gh:stevearc/aerial.nvim",
    "gh:nvim-telescope/telescope.nvim",
})

local utils = require("utils")
local set = utils.keymap.set

set("n", "<leader>da", "<cmd>AerialToggle!<cr>", { desc = "Aerial" })

local aerial = require("aerial")
aerial.setup({
    backends = { "lsp", "treesitter", "markdown", "man" },
    layout = {
        default_direction = "prefer_left",
        placement = "edge", -- edge | window
        max_width = { 30, 0.2 },
        min_width = 20,
    },
    on_attach = function(bufnr)
        local next_sym, prev_sym = utils.repeatable(aerial.next, aerial.prev)
        local next_sym_up, prev_sym_up = utils.repeatable(aerial.next_up, aerial.prev_up)
        set("n", "]s", next_sym, { desc = "Goto next aerial symbol", buf = bufnr })
        set("n", "[s", prev_sym, { desc = "Goto previous aerial symbol", buf = bufnr })
        set("n", "]S", next_sym_up, { desc = "Goto next aerial symbol (up)", buf = bufnr })
        set("n", "[S", prev_sym_up, { desc = "Goto previous aerial symbol (up)", buf = bufnr })
        -- set("n", "{", "<cmd>AerialPrev<cr>", { desc = "AerialPrev" })
        -- set("n", "}", "<cmd>AerialNext<cr>", { desc = "AerialNext" })
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
        ["]]{ { "] = " } } }actions.next_up",
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
})
