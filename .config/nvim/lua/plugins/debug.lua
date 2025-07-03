return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
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
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F4>', dap.step_back, { desc = 'Debug: Step Back' })
    vim.keymap.set('n', '<F6>', dap.restart, { desc = 'Debug: Restart' })

    vim.keymap.set({ 'n', 'v' }, '<leader>de', function()
      dapui.eval(nil, { enter = true })
    end, { silent = true, desc = 'Debug: Calculate expression' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<leader>gb', dap.run_to_cursor, { desc = 'Debug: Run to Cursor' })

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

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

    -- Install golang specific config
    require('dap-go').setup()

    -- Python settings
    local python = require 'dap-python'
    python.test_runner = 'pytest'
    local python_path = table.concat({ vim.fn.stdpath 'data', 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, '/'):gsub('//+', '/')
    python.setup(python_path)

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
