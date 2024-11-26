return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'LiadOz/nvim-dap-repl-highlights',
    -- Dependency for dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      handlers = {},
      ensure_installed = {
        'python',
        'delve',
        'codelldb',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F4>', dap.step_back, { desc = 'Debug: Step Back' })
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F6>', dap.restart, { desc = 'Debug: Restart' })
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: Toggle DAP-UI' })
    vim.keymap.set('n', '<F9>', dap.terminate, { desc = 'Debug: Terminate' })

    vim.keymap.set({ 'n', 'v' }, '<leader>de', function()
      dapui.eval(nil, { enter = true })
    end, { silent = true, desc = 'Debug: Calculate expression' })
    vim.keymap.set('n', '<leader>dE', function()
      dap.repl.execute(vim.fn.expand '<cexpr>')
    end, { silent = true, desc = 'Debug: Execute expression' })
    vim.keymap.set('v', '<leader>dE', function()
      local lines = vim.fn.getregion(vim.fn.getpos '.', vim.fn.getpos 'v')
      dap.repl.execute(table.concat(lines, '\n'))
    end, { silent = true, desc = 'Debug: Execute expression' })
    vim.keymap.set('n', '<leader>dd', dap.down, { silent = true, desc = 'Debug: Go Down the Stacktrace' })
    vim.keymap.set('n', '<leader>du', dap.up, { silent = true, desc = 'Debug: Go Up the Stacktrace' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<leader>gB', dap.run_to_cursor, { desc = 'Debug: Run to Cursor' })

    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpointSymbol', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStoppedSymbol', linehl = 'DapStoppedSymbol', numhl = 'DapStoppedSymbol' })

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        enabled = false,
      },
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    -- dap.listeners.before.event_terminated.dapui_config = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited.dapui_config = function()
    --   dapui.close()
    -- end

    require('nvim-dap-virtual-text').setup {}
    require('nvim-dap-repl-highlights').setup()

    -- Install golang specific config
    require('dap-go').setup()

    -- configure codelldb adapter
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'codelldb',
        args = { '--port', '${port}' },
      },
    }

    -- setup a debugger config for zig projects
    dap.configurations.zig = {
      {
        name = 'Launch',
        type = 'codelldb',
        request = 'launch',
        program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
      {
        name = 'Debug tests in current file',
        type = 'codelldb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = function()
          vim.fn.system { 'zig', 'test', '--test-no-exec', '-femit-bin=zig-out/bin/test-binary', vim.api.nvim_buf_get_name(0) }
          -- local out = vim.fn.system { 'zig', 'test', '-femit-bin=zig-out/bin/test-binary', vim.api.nvim_buf_get_name(0) }
          -- if vim.v.shell_error ~= 0 then
          --   vim.notify(out, vim.log.levels.ERROR)
          --   return nil
          -- end
          -- local lines = vim.split(out, '\n')
          -- vim.print(vim.inspect(lines))
          return 'zig-out/bin/test-binary'
        end,
        console = 'integratedTerminal',
      },
      {
        name = 'Debug test under cursor',
        type = 'codelldb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = function()
          local ts_query = [[
            (test_declaration
              (string
                (string_content) @name))
          ]]
          local filetype = vim.bo.filetype
          local bufnr = vim.api.nvim_get_current_buf()
          local query = vim.treesitter.query.parse(filetype, ts_query)
          local parser = vim.treesitter.get_parser(bufnr, filetype)
          local tree = parser:parse()[1]
          local root = tree:root()
          local stop = vim.api.nvim_win_get_cursor(0)[1]
          local testname = nil

          for _, node in query:iter_captures(root, bufnr, 0, stop) do
            testname = vim.treesitter.get_node_text(node, 0)
          end

          vim.fn.system { 'zig', 'test', '--test-no-exec', '--test-filter', testname, '-femit-bin=zig-out/bin/test-binary', vim.api.nvim_buf_get_name(0) }
          return 'zig-out/bin/test-binary'
        end,
        console = 'integratedTerminal',
      },
    }

    -- Python settings
    local python = require 'dap-python'
    python.test_runner = 'pytest'
    local python_path = table.concat({ vim.fn.stdpath 'data', 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, '/'):gsub('//+', '/')
    python.setup(python_path)

    -- WORK
    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Python: Run all tests',
      module = 'pytest',
      args = { '--cov', '--cov-report=', '--cov-config=pyproject.toml', '--exitfirst', '-n', 'auto', '--dist', 'loadfile', 'server/test/mili' },
      console = 'integratedTerminal',
    })

    local config = { showReturnValue = true }
    for i = 1, #dap.configurations.python do
      dap.configurations.python[i] = vim.tbl_extend('force', dap.configurations.python[i], config)
    end
    vim.keymap.set('n', '<leader>dm', function()
      python.test_method { config = config }
    end, { desc = 'Debug Method above cursor' })
    vim.keymap.set('n', '<leader>dc', function()
      python.test_class { config = config }
    end, { desc = 'Debug Class above cursor' })
    vim.keymap.set('v', '<leader>ds', function()
      python.debug_selection { config = config }
    end, { desc = 'Debug selection' })
  end,
}
