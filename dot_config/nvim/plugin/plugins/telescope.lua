vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "telescope-fzf-native.nvim" and kind ~= "delete" then
            vim.system({ "make" }, { cwd = ev.data.path })
        end
    end,
})

vim.pack.add({
    {
        src = "gh:nvim-telescope/telescope.nvim",
        version = vim.version.range("0.2"),
    },
    "gh:nvim-lua/plenary.nvim",
    "gh:nvim-telescope/telescope-fzf-native.nvim",
    "gh:nvim-telescope/telescope-ui-select.nvim",
    -- "gh:nvim-telescope/telescope-symbols.nvim",
    -- "gh:archie-judd/telescope-words.nvim",
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        layout_config = { width = { padding = 6 }, height = { padding = 5 } },
        prompt_prefix = "   ",
        selection_caret = " >> ",
        multi_icon = "   ",
        entry_prefix = "    ",
        file_ignore_patterns = {
            "%.lock",
            "%lock.json",
            "%__pycache__/",
            "^target/",
            "node_modules/",
        },
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
    },
    extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
    },
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local set = require("utils.keymap").set
set("n", "<leader>b", builtin.buffers, { desc = "Buffers (Telescope)" })
set("n", "<leader>f", builtin.find_files, { desc = "Files (Telescope)" })
set(
    "n",
    "<leader>F",
    function() builtin.find_files({ hidden = true }) end,
    { desc = "All Files (Telescope)" }
)
set("n", "<leader>p", builtin.live_grep, { desc = "Live Grep (Telescope)" })
set("n", "<leader>tA", builtin.autocommands, { desc = "Autocmd" })
set("n", "<leader>tb", builtin.builtin, { desc = "Builtin Pickers" })
set("n", "<leader>tc", builtin.commands, { desc = "Commands" })
set("n", "<leader>th", builtin.help_tags, { desc = "Help" })
set("n", "<leader>tH", builtin.highlights, { desc = "Highlight" })
set("n", "<leader>tk", builtin.keymaps, { desc = "Keymaps" })
set("n", "<leader>tl", builtin.loclist, { desc = "Location List" })
set("n", "<leader>tm", builtin.marks, { desc = "Marks" })
set("n", "<leader>to", builtin.oldfiles, { desc = "Old Files" })
set("n", "<leader>tq", builtin.quickfix, { desc = "Quickfix List" })
set("n", "<leader>tr", builtin.resume, { desc = "Resume" })
set("n", "<leader>ts", builtin.spell_suggest, { desc = "Spell Suggest" })
set("n", "<leader>tt", builtin.treesitter, { desc = "Treesitter" })
set(
    "n",
    "<leader>tw",
    function() builtin.diagnostics({ severity_limit = "warn" }) end,
    { desc = "Diagnostics (warn+)" }
)
set(
    "n",
    "<leader>te",
    function() builtin.diagnostics({ severity = "error" }) end,
    { desc = "Diagnostics (error)" }
)
set("n", "<leader>td", builtin.diagnostics, { desc = "Diagnostics (all)" })
set("n", "<leader>tgr", builtin.lsp_references, { desc = "References" })
set("n", "<leader>tgd", builtin.lsp_definitions, { desc = "Definition" })
set("n", "<leader>tgi", builtin.lsp_implementations, { desc = "Implementation" })
set("n", "<leader>tgt", builtin.lsp_type_definitions, { desc = "Type Definition" })
set("n", "<leader>gtf", builtin.git_files, { desc = "Git Files" })
set("n", "<leader>gtz", builtin.git_stash, { desc = "Git Stash" })
set("n", "<leader>gts", builtin.git_status, { desc = "Git Status" })
set("n", "<leader>gtc", builtin.git_commits, { desc = "Git Commits" })
set("n", "<leader>gtC", builtin.git_bcommits, { desc = "Git BufCommits" })
set("n", "<leader>gtb", builtin.git_branches, { desc = "Git Branches" })
-- extensions
-- set("n", "<leader>ta", "<cmd>Telescope aerial<cr>", { desc = "Aerial" } )
-- set("n", "<leader>tz", "<cmd>Telescope lazy<cr>",   { desc = "Lazy" } )
