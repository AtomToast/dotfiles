return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Diagnostic keymaps
          map('[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')
          map(']d', vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')
          map('gK', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
          map('<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')

          -- To jump back from definition, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('<C-]>', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gt', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('<leader>a', '<cmd>ClangdSwitchSourceHeader<CR>', 'Switch to [A]lternate File')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Hightlight references under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            map('<leader>rh', vim.lsp.buf.document_highlight, '[H]ighlight [R]eferences')

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- Opens a popup that displays documentation about the word under your cursor
          -- Opens help file if in help document
          local function show_documentation()
            if vim.bo.filetype:match 'help' or vim.bo.filetype:match 'vim' then
              vim.cmd(' ' .. vim.fn.expand '<cword>')
            else
              vim.lsp.buf.hover()
            end
          end
          map('K', show_documentation, 'Hover Documentation')
          vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'LSP: Show signature help' })

          vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = 'DiagnosticSignError' })
          vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = 'DiagnosticSignWarn' })
          vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo', linehl = '', numhl = 'DiagnosticSignInfo' })
          vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint', linehl = '', numhl = 'DiagnosticSignHint' })
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {},
        gopls = {},
        zls = {},
        rust_analyzer = {},
        html = {},
        cssls = {},
        tsserver = {},
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
        'mypy', -- Python static type checking
        'ruff', -- Python linting and formatting
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
