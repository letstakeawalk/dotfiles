-- NOTE: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
---@diagnostic disable: unused-local, unused-function
local ls = require("luasnip")
local types = require("luasnip.util.types")
local s = ls.snippet -- s(<trigger>, <nodes>)
local sn = ls.snippet_node
local c = ls.choice_node
local i = ls.insert_node -- i(<position>, [default_text])
local t = ls.text_node
local f = ls.function_node -- f(fn, argnode_ref, [args]) fn(argnode_txt, parent, user_args)
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt -- fmt(<fmt_string>, {...nodes})
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep -- rep(<position>)
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local fname = function()
    local path = vim.api.nvim_buf_get_name(0)
    local cwd = vim.uv.cwd()
    return string.gsub(path, cwd .. "/", "")
end

local load_type = function()
    local filename = vim.fn.expand("%:t") --[[@as string]]
    local page_layout = string.find(filename, "page") and "Page" or "Layout"
    local server = string.find(filename, "server") and "Server" or ""
    return page_layout .. server .. "Load"
end

local all = {
    s(
        "clog",
        fmt([[console.log("{}: {}");]], {
            p(fname),
            i(1, "variable"),
        })
    ),
    s(
        "clogg",
        fmt([[console.log("{}: {}", {});]], {
            p(fname),
            f(function(args) return args[1] end, 1),
            i(1, "variable"),
        })
    ),
    s(
        "cerror",
        fmt([[console.error("{}: {}", {});]], {
            p(fname),
            f(function(args) return args[1] end, 1),
            i(1, "variable"),
        })
    ),
    s(
        "cwarn",
        fmt([[console.warn("{}: {}", {});]], {
            p(fname),
            f(function(args) return args[1] end, 1),
            i(1, "variable"),
        })
    ),
}
local javascript = {}
local typescript = {
    s(
        "skload",
        fmt(
            [[
            import type { [type] } from "./$types";

            export const load: [type] = async (event) => {
                [input]
            };
            ]],
            { type = p(load_type), input = i(1) },
            { repeat_duplicates = true, delimiters = "[]" }
        )
    ),
    s(
        "skaction",
        fmt(
            [[
            import type { Actions } from "./$types";

            export const actions: Actions = {
                [action]: async (event) => {
                    [input]
                },
            } satisfies Actions;
            ]],
            { action = i(1, "default"), input = i(2) },
            { delimiters = "[]" }
        )
    ),
}
local svelte = {
    s(
        "script",
        fmt(
            [[
            <script lang="ts">
                {}
            </script>
            ]],
            { i(1) }
        )
    ),
}

vim.list_extend(javascript, all)
vim.list_extend(typescript, all)
vim.list_extend(svelte, all)

return {
    javascript = javascript,
    typescript = typescript,
    svelte = svelte,
}
--- typescript
-- interface
-- class
-- pub method
-- private method
-- getter
-- setter
-- function
-- switch
-- set timeout

-- TODO: https://github.com/ults-io/vscode-react-javascript-snippets/blob/master/src/snippets/generated.json
-- REACT:
-- rfc := react component
-- rfce := react component export
-- ust = use state
-- uef = use effect
