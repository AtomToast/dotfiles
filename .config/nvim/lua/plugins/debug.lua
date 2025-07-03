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
    require('nvim-dap-repl-highlights').setup {}

    -- Install golang specific config
    require('dap-go').setup()

    -- Python settings
    local python = require 'dap-python'
    python.test_runner = 'pytest'
    local python_path = table.concat({ vim.fn.stdpath 'data', 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, '/'):gsub('//+', '/')
    python.setup(python_path)

    -- WORK
    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Run all tests',
      module = 'pytest',
      args = { '--exitfirst', '-n', 'auto', '--dist', 'loadfile', 'server/test/mili' },
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
