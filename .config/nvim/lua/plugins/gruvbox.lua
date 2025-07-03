return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('gruvbox').setup {
        transparent_mode = true,
        overrides = {
          -- These seem to not really be maintained as part of the colorscheme
          DapBreakpointSymbol = { link = 'GruvboxRedSign' },
          DapStoppedSymbol = { link = 'GruvboxGreenSign' },
          -- No transparency on floating windows
          NormalFloat = {
            bg = require('gruvbox').palette['dark1'],
            fg = require('gruvbox').palette['light1'],
          },
        },
      }

      vim.cmd.colorscheme 'gruvbox'
    end,
  },
}
