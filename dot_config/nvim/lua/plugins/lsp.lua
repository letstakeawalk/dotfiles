return {
  {
    "williamboman/mason.nvim",
    dependencies = "williamboman/mason-lspconfig.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" },
    },
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "",
            package_uninstalled = "✗",
          },
        },
      })
      require("mason-lspconfig").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- "kevinhwang91/nvim-ufo",
    },
    event = "BufReadPre",
    config = function()
      require("neodev").setup() -- important to setup before lspconfig
      local lsp_config = require("lspconfig")

      local function diagnostic_goto(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
          go({ severity = severity })
        end
      end

          -- See `:help vim.diagnostic.*` for documentation on any of the below functions
          -- stylua: ignore start
          vim.keymap.set("n", "E", vim.diagnostic.open_float, { desc = "Open Float" })
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
          vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Goto next error" })
          vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Goto previous error" })
          vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Goto next warning" })
          vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Goto previous warning" })
          vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format File" })
          vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })
          vim.keymap.set("n", "<leader>de", vim.diagnostic.enable, { silent = true, desc = "Show diagnostic" })
          vim.keymap.set("n", "<leader>dd", vim.diagnostic.disable, { silent = true, desc = "Hide diagnostic" })
      -- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)  -- ??
      -- stylua: ignore end

      local on_attach = function(_, bufnr)
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = function(desc)
          return { noremap = true, silent = true, buffer = bufnr, desc = desc }
        end
        vim.keymap.set("n", "H", vim.lsp.buf.signature_help, bufopts("Display Signature Help"))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts("Display Hover Info"))
        vim.keymap.set("n", "T", vim.lsp.buf.type_definition, bufopts("Display Type Definition"))
        vim.keymap.set({ "n", "v" }, "<leader>ra", vim.lsp.buf.code_action, bufopts("Code Action"))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts("Rename"))
      end

      -- cmp-nvim-lsp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- ufo
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }

      -- Use a loop to conveniently call 'setup' on multiple servers and
      -- map buffer local keybindings when the language server attaches
      local servers = {
        -- rust
        rust_analyzer = {},
        -- python
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off", -- let mypy handle type checking
                diagnosticSeverityOverrides = {
                  reportUndefinedVariable = "none", -- "error," "warning," "information," "true," "false," or "none"
                },
              },
            },
            pyright = { disableOrganizeImports = true },
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              -- filter out Hint diagnostics
              local filtered_diags = {}
              for _, diag in pairs(result.diagnostics) do
                if diag.severity ~= vim.lsp.protocol.DiagnosticSeverity.Hint then
                  table.insert(filtered_diags, diag)
                end
              end
              result.diagnostics = filtered_diags
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
            end,
          },
        },
        -- ruff_lsp = {},
        sourcery = {
          init_options = {
            --- The Sourcery token for authenticating the user.
            --- This is retrieved from the Sourcery website and must be
            --- provided by each user. The extension must provide a
            --- configuration option for the user to provide this value.
            token = "user_heTw00STPPekjfZDY90TOPHbuifdgRdHn1TuJ_c8SE3qWzCTiy7m7zcyGIY",

            --- The extension's name and version as defined by the extension.
            extension_version = "vim.lsp",

            --- The editor's name and version as defined by the editor.
            editor_version = "vim",
          },
        },
        -- typescript
        tsserver = {},
        eslint = {},
        -- lua
        sumneko_lua = {
          command = { "lua-language-server" },
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" }, -- Get the language server to recognize the `vim` global
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
                checkThirdParty = false,
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false,
              },
              format = {
                enable = false,
              },
            },
          },
        },
        vimls = {},
        tailwindcss = {},
        dockerls = {},
        sqlls = {},
        taplo = {}, -- yaml
        yamlls = {}, -- yaml
        -- TODO: add snippet support to capabilities
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
        cssls = {},
        html = {},
        jsonls = {},
        bashls = {},
        emmet_ls = {},
      }
      for server, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        config.flags = flags
        lsp_config[server].setup(config)
      end

      --------------------------------------------------------------------------------
      -- UI customization ------------------------------------------------------------
      --------------------------------------------------------------------------------
      -- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#borders
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      ---@diagnostic disable-next-line: duplicate-set-field
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -- gutter (sign column) symbols
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- display the source of diagnostic
      vim.diagnostic.config({
        virtual_text = false,
        -- virtual_text = {
        --   severity = vim.diagnostic.severity.ERROR,
        --   source = false, -- Or "if_many"
        -- },
        -- float = {
        --   source = "always", -- Or "if_many"
        -- },
      })

      -- auto diagnostic hover window
      -- vim.api.nvim_create_autocmd({ "CursorHold" }, {
      --   group = vim.api.nvim_create_augroup("Lsp", {}),
      --   callback = function()
      --     vim.diagnostic.open_float(nil, { focus = false })
      --   end,
      -- })

      --------------------------------------------------------------------------------
      -- DEBUG
      -- vim.lsp.set_log_level("debug") -- set this then run :LspInfo
    end,
  },
}
