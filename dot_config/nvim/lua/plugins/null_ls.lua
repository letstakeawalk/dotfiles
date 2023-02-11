return {
  "jose-elias-alvarez/null-ls.nvim", -- injectable language server
  dependencies = { "neovim/nvim-lspconfig" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    local null_ls = require("null-ls")

    null_ls.setup({
      debug = false,
      sources = {
        -- ts / ts
        null_ls.builtins.formatting.prettierd, -- js,ts,css,html,json,yaml,md,etc
        null_ls.builtins.formatting.rustywind, -- tailwindcss

        -- python
        null_ls.builtins.diagnostics.mypy, -- type checker
        null_ls.builtins.diagnostics.pylint, -- linter
        null_ls.builtins.diagnostics.ruff, --
        null_ls.builtins.formatting.ruff, --
        null_ls.builtins.formatting.isort, -- formatter: imports
        null_ls.builtins.formatting.black.with({ command = "blackd-client", args = {} }), -- formatter: style
        -- null_ls.builtins.diagnostics.pydocstyle, -- linter: doc
        -- null_ls.builtins.diagnostics.bandit,  -- check back later for PR

        -- lua
        null_ls.builtins.diagnostics.selene.with({
          condition= function(utils)
            return utils.root_has_file({ "selene.toml" })
          end
        }),
        null_ls.builtins.formatting.stylua,

        -- etc
        null_ls.builtins.diagnostics.gitlint, -- gitcommit
        null_ls.builtins.diagnostics.hadolint, -- docker
        null_ls.builtins.diagnostics.sqlfluff, -- sql
        null_ls.builtins.formatting.jq, -- json
        null_ls.builtins.code_actions.gitsigns, -- gitsign.nvim
        null_ls.builtins.diagnostics.shellcheck, -- bash
        null_ls.builtins.formatting.shfmt, -- bash
        -- null_ls.builtins.code_actions.refactoring -- thePrimeagen
        -- null_ls.builtins.diagnostics.write_good, -- english
        -- null_ls.builtins.diagnostics.markdownlint, -- markdown
        -- null_ls.builtins.diagnostics.commitlint, -- gitcommit
        -- null_ls.builtins.code_actions.cspell,
        -- null_ls.builtins.diagnostics.cspell,

        -- ruby
        -- null_ls.builtins.diagnostics.rubocop,
        -- null_ls.builtins.formatting.rubocop,

        -- future checkout
        -- terrafmt
        -- dprint
      },
      diagnostics_format = "#{m}", -- #{<m,c,s>}
      border = "double",
    })

    vim.keymap.set("n", "<leader>in", "<cmd>NullLsInfo<cr>", { desc = "Null-ls Info" })
    vim.api.nvim_set_hl(0, "NullLsInfoBorder", { link = "FloatBorder" })
  end,
}
