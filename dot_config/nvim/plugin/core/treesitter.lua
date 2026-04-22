-- Disable entire built-in ftplugin mappings to avoid conflicts with textobjs.
-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
vim.g.no_plugin_maps = true
local config = require("config")
-- stylua: ignore
config.ts_parsers = {
    "bash",
    "c", "cpp",
    "clojure",
    "cmake",
    "css", "scss",
    "csv",
    "diff",
    "dockerfile",
    "editorconfig",
    "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
    "go", "templ",
    "html",
    "java", "javadoc", "properties",
    "javascript", "jsdoc", "jsx",
    "jinja", "jinja_inline",
    "jq",
    "json", "json5",
    "just",
    "latex",
    "lua", "luadoc", "luap",
    "make",
    "markdown", "markdown_inline",
    "mermaid",
    "nginx",
    "proto",
    "python", "requirements",
    "query",
    "regex",
    "ruby",
    "rust", "ron",
    "sql",
    "ssh_config",
    "svelte",
    "swift",
    "terraform", "hcl",
    "tmux",
    "toml",
    "typescript", "tsx",
    "typst",
    "vim", "vimdoc",
    "xml", "dtd",
    "yaml",
    "zig",
    "zsh",
    -- "c_sharp",
    -- "kotlin",
    -- "ocaml",
}

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" then
            if kind == "install" then
                require("nvim-treesitter").install(config.ts_parsers)
            elseif kind == "update" then
                if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
                vim.cmd("TSUpdate")
            end
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = config.ts_parsers,
    callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

vim.pack.add({
    "gh:nvim-treesitter/nvim-treesitter",
    "gh:nvim-treesitter/nvim-treesitter-textobjects",
    "gh:nvim-treesitter/nvim-treesitter-context", -- code context winbar
    -- "gh:windwp/nvim-ts-autotag", -- auto closes tags for html, react, etc
})

require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
        selection_modes = {},
        include_surrounding_whitespace = false,
    },
    move = { set_jumps = true },
})

-- keymaps
local set = require("utils.keymap").set
local swap = require("nvim-treesitter-textobjects.swap")
local select = require("nvim-treesitter-textobjects.select").select_textobject
local next_start = require("nvim-treesitter-textobjects.move").goto_next_start
local next_end = require("nvim-treesitter-textobjects.move").goto_next_end
local prev_start = require("nvim-treesitter-textobjects.move").goto_previous_start
local prev_end = require("nvim-treesitter-textobjects.move").goto_previous_end
set(
    "n",
    "<leader>rh",
    function() swap.swap_previous("@parameter.inner") end,
    { desc = "Swap prev parameter" }
)
set(
    "n",
    "<leader>rk",
    function() swap.swap_next("@parameter.inner") end,
    { desc = "Swap next parameter" }
)

-- textobjects
set("xo", "am", function() select("@function.outer", "textobjects") end)
set("xo", "im", function() select("@function.inner", "textobjects") end)
set("xo", "af", function() select("@call.outer", "textobjects") end)
set("xo", "if", function() select("@call.inner", "textobjects") end)
set("xo", "ac", function() select("@class.outer", "textobjects") end)
set("xo", "ic", function() select("@class.inner", "textobjects") end)
set("xo", "aa", function() select("@parameter.outer", "textobjects") end)
set("xo", "ia", function() select("@parameter.inner", "textobjects") end)
set("xo", "ai", function() select("@conditional.outer", "textobjects") end)
set("xo", "ii", function() select("@conditional.inner", "textobjects") end)
set("xo", "ao", function() select("@loop.outer", "textobjects") end)
set("xo", "io", function() select("@loop.inner", "textobjects") end)
set("xo", "ak", function() select("@block.outer", "textobjects") end)
set("xo", "ik", function() select("@block.inner", "textobjects") end)
set("xo", "a/", function() select("@comment.outer", "textobjects") end)
set("xo", "i/", function() select("@comment.outer", "textobjects") end)
set("xo", "a=", function() select("@assignment.lhs", "textobjects") end)
set("xo", "i=", function() select("@assignment.rhs", "textobjects") end)
set("xo", "a:", function() select("@field.name", "textobjects") end)
set("xo", "i:", function() select("@field.value", "textobjects") end)
set("xo", "aC", function() select("@block.outer", "textobjects") end)
set("xo", "iC", function() select("@block.inner", "textobjects") end)

-- move
set(
    "nxo",
    "][",
    function() next_start("@function.outer", "textobjects") end,
    { desc = "Goto next @function.outer" }
)
set(
    "nxo",
    "](",
    function() next_start("@class.outer", "textobjects") end,
    { desc = "Goto next @class.outer" }
)
set(
    "nxo",
    "]f",
    function() next_start("@call.outer", "textobjects") end,
    { desc = "Goto next @call.outer" }
)
set(
    "nxo",
    "]a",
    function() next_start("@parameter.inner", "textobjects") end,
    { desc = "Goto next @parameter.inner" }
)
set(
    "nxo",
    "]i",
    function() next_start("@conditional.inner", "textobjects") end,
    { desc = "Goto next @conditional.inner" }
)
set(
    "nxo",
    "]o",
    function() next_start("@loop.inner", "textobjects") end,
    { desc = "Goto next @loop.inner" }
)
set(
    "nxo",
    "]/",
    function() next_start("@comment.outer", "textobjects") end,
    { desc = "Goto next @comment.outer" }
)
-- set("nxo", "]z",function() next_start( { query = "@fold", group = "@folds", desc = "Goto next @fold" }, "textobjects") end)
set(
    "nxo",
    "]]",
    function() next_end("@function.outer", "textobjects") end,
    { desc = "Goto next @function.outer" }
)
set(
    "nxo",
    "])",
    function() next_end("@class.outer", "textobjects") end,
    { desc = "Goto next @class.outer" }
)
set(
    "nxo",
    "[[",
    function() prev_start("@function.outer", "textobjects") end,
    { desc = "Goto previous @function.outer" }
)
set(
    "nxo",
    "[(",
    function() prev_start("@class.outer", "textobjects") end,
    { desc = "Goto previous @class.outer" }
)
set(
    "nxo",
    "[f",
    function() prev_start("@call.outer", "textobjects") end,
    { desc = "Goto previous @call.outer" }
)
set(
    "nxo",
    "[a",
    function() prev_start("@parameter.inner", "textobjects") end,
    { desc = "Goto previous @parameter.inner" }
)
set(
    "nxo",
    "[i",
    function() prev_start("@conditional.inner", "textobjects") end,
    { desc = "Goto previous @conditional.inner" }
)
set(
    "nxo",
    "[o",
    function() prev_start("@loop.inner", "textobjects") end,
    { desc = "Goto previous @loop.inner" }
)
set(
    "nxo",
    "[/",
    function() prev_start("@comment.outer", "textobjects") end,
    { desc = "Goto previous @comment.outer" }
)
-- set("nxo", "[z",function() prev_start( { query = "@fold", group = "@folds", desc = "Goto previous @fold" }, "textobjects") end)
set(
    "nxo",
    "[]",
    function() prev_end("@function.outer", "textobjects") end,
    { desc = "Goto previous @function.outer" }
)
set(
    "nxo",
    "[)",
    function() prev_end("@class.outer", "textobjects") end,
    { desc = "Goto previous @class.outer" }
)

local repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
set("nxo", ";", repeat_move.repeat_last_move_next)
set("nxo", ",", repeat_move.repeat_last_move_previous)

require("treesitter-context").setup()
set("n", "<leader>dc", "<cmd>TSContext toggle<cr>", { desc = "TS Context Toggle" })

-- vim.g.skip_ts_context_commentstring_module = true
-- require("ts_context_commentstring").setup({
--     enable_autocmd = false, -- for Comment.nvim
-- })

-- require("nvim-ts-autotag").setup({
--     opts = {
--         enable_close = true, -- Auto close tags
--         enable_rename = true, -- Auto rename pairs of tags
--         enable_close_on_slash = false, -- Auto close on trailing </
--     },
-- })

-- Inspect
set("n", "<leader>di", "<cmd>Inspect<cr>", { desc = "Inspect TS node" })
set("n", "<leader>ii", "<cmd>Inspect<cr>", { desc = "Inspect TS node" })
set("n", "<leader>it", "<cmd>InspectTree<cr>", { desc = "Inspect TS tree" })
