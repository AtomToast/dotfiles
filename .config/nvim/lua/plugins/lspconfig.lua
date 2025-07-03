return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      { 'mason-org/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
      { -- optional completion source for require statements and module annotations
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = 'lazydev',
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          })
        end,
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Diagnostic keymaps
          map('<leader>cd', vim.diagnostic.setqflist, 'Open diagnostic quickfix list')
          map('<leader>ld', vim.diagnostic.setloclist, 'Open diagnostic location list')

          -- To jump back from definition, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('<C-]>', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grt', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>a', '<cmd>ClangdSwitchSourceHeader<CR>', 'Switch to [A]lternate File')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

          -- Signature help
          vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'LSP: Show signature help' })
        end,
      })

      local severity_icons = { '', '', '', '' }
      vim.diagnostic.config {
        severity_sort = true,
        virtual_text = {
          prefix = function(diagnostic)
            return severity_icons[diagnostic.severity] or '■'
          end,
        },
        signs = {
          text = severity_icons,
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignHint',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignInfo',
          },
        },
        jump = {
          float = true,
        },
      }

      vim.lsp.inlay_hint.enable()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {},
        gopls = {},
        zls = {},
        rust_analyzer = {},
        html = {},
        cssls = {},
        ts_ls = {},
        jsonls = {},
        yamlls = {},
        texlab = {},
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                ruff = {
                  enabled = true,
                  format = { 'I' },
                },
                pylsp_mypy = {
                  enabled = true,
                  -- WORK
                  exclude = { 'test/*' },
                },
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
        'debugpy',
        -- FIXME: breaking path order somehow with WORK python env
        -- 'mypy', -- Python static type checking
        -- 'ruff', -- Python linting and formatting
        'prettier', -- Formatting for all the web stuff and more
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- workaround to install Pylsp plugins
      require('mason-registry'):on('package:install:success', function(pkg)
        if pkg.name ~= 'python-lsp-server' then
          return
        end

        local venv = vim.fn.resolve(vim.fn.stdpath 'data' .. '/mason/packages/python-lsp-server/venv')

        require('plenary.job')
          :new({
            command = venv .. '/bin/pip',
            args = { 'install', 'pylsp-mypy', 'python-lsp-ruff' },
            cwd = venv,
            env = { VIRTUAL_ENV = venv },
            on_start = function()
              vim.print 'Installing pylsp plugins...'
            end,
            on_exit = function()
              vim.print 'Finished installing pylsp plugins.'
            end,
          })
          :start()
      end)
    end,
  },
}
