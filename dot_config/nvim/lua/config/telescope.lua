local telescope = require("telescope")
local actions = require("telescope.actions")

local function open_vertical_if_wide_enough(prompt_bufnr)
    local action_set = require("telescope.actions.set")

    local winbufs = vim.tbl_map(function(win)
        return { win, vim.api.nvim_win_get_buf(win) }
    end, vim.api.nvim_tabpage_list_wins(0))

    local listed_winbufs = vim.tbl_filter(function(winbuf)
        return vim.api.nvim_get_option_value("buflisted", { buf = winbuf[2] })
    end, winbufs)

    if #listed_winbufs == 1 and vim.api.nvim_win_get_width(listed_winbufs[1][1]) > 160 then
        return action_set.select(prompt_bufnr, "vertical")
    end
    return action_set.select(prompt_bufnr, "horizontal")
end

telescope.setup({
    defaults = {
        -- layout_strategy = "center",
        -- layout_config = { width = 80, height = 0.30 },
        -- sorting_strategy = "ascending",
        -- borderchars = {
        --     prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
        --     results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
        --     preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- },
        layout_config = { width = 166, height = { padding = 5 } },
        prompt_prefix = "   ",
        selection_caret = " >> ",
        multi_icon = "   ",
        entry_prefix = "    ",
        file_ignore_patterns = { "%.lock", "%lock.json" },
        mappings = {
            n = {
                ["k"] = actions.move_selection_next,
                ["h"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
            },
            i = { ["<Esc>"] = actions.close },
        },
    },
    pickers = {
        find_files = {
            find_command = { "fd", "--type", "f", "--follow" },
        },
        help_tags = {
            mappings = {
                i = { ["<CR>"] = open_vertical_if_wide_enough },
                n = { ["<CR>"] = open_vertical_if_wide_enough },
            },
        },
    },
    extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
        lazy = { mappings = { change_cwd_to_plugin = "" } },
        -- TODO: git worktree window resize
    },
})

-- extensions
-- TODO
pcall(telescope.load_extension("fzf")) -- telescope-fzf-native
pcall(telescope.load_extension("aerial")) -- aerial.nvim
-- pcall(telescope.load_extension("git_worktree")) -- git-worktree.nvim
-- pcall(telescope.load_extension("harpoon")) -- harpoon.nvim
pcall(telescope.load_extension("lazy")) -- lazy.nvim
-- pcall(telescope.load_extension("persisted")) -- persisted.nvim
pcall(telescope.load_extension("ui-select")) -- ui-select
