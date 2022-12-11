-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local function ts_organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

local function py_organize_imports()
  local params = {
    command = 'pyright.organizeimports',
    arguments = { vim.uri_from_bufnr(0) },
  }
  vim.lsp.buf.execute_command(params)
end

return {
  -- python
  pyright = {
    settings = {
      python = {
        analysis = {
          -- default values from lspconfig
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'workspace',
          -- custom value
          typeCheckingMode = "off", -- let mypy handle type checking
          diagnosticSeverityOverrides = {
            -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md
            -- "error," "warning," "information," "true," "false," or "none"
            reportUndefinedVariable = "none"
          }
        }
      },
      pyright = {
        disableOrganizeImports = true
      }
    },
    handlers = {
      ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        -- filter Hints
        -- https://github.com/neovim/nvim-lspconfig/issues/726#issuecomment-1075539112
        -- https://github.com/neovim/neovim/issues/17757#issuecomment-1073266618
        local filtered_diags = {}
        for _, diag in pairs(result.diagnostics) do
          if diag.severity ~= vim.lsp.protocol.DiagnosticSeverity.Hint then
            table.insert(filtered_diags, diag)
          end
        end
        result.diagnostics = filtered_diags
        vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
      end,
      -- disable diagnostics for pyright type checker; let null-ls(mypy) handle them.
      -- ['textDocument/publishDiagnostics'] = function(...) end
    },
    commands = {
      OrganizeImports = {
        py_organize_imports,
        description = 'Organize Imports',
      },
    },
  },

  -- pylsp = {
  --   settings = {
  --     pylsp = {
  --       -- configurationSources = { "pylint" },
  --       plugins = {
  --         black = { enabled = false },
  --         pylint = { enabled = false },
  --         mypy = { enabled = false },
  --         isort = { enabled = false },
  --         rope_completion = { enabled = true },
  --         pydocstyle = { enabled = false },
  --         autopep8 = { enabled = false },
  --         mccabe = { enabled = false },
  --         flake8 = { enabled = false },
  --         pycodestyle = { enabled = false },
  --         pyflakes = { enabled = false },
  --         yapf = { enabled = false }
  --       }
  --     }
  --   }
  -- },

  -- typescript
  tsserver = {
    commands = {
      OrganizeImports = {
        ts_organize_imports,
        description = "Organize Imports"
      }
    }
  },

  -- lua
  sumneko_lua = {
    command = { "lua-language-server" },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- path = runtime_path, -- Setup your lua path
        },
        diagnostics = {
          globals = { 'vim' }, -- Get the language server to recognize the `vim` global
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },

  vimls = {},
  tailwindcss = {},
  --[[ jsonls = {}, ]]
  --[[ cssls = {}, ]]
}
