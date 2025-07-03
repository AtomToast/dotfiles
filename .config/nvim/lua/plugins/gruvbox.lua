return {
  {
    'ellisonleao/gruvbox.nvim',
    opts = {
      transparent_mode = true,
      overrides = {
        -- These seem to not really be maintained as part of the colorscheme
        DapBreakpointSymbol = { link = 'GruvboxRedSign' },
        DapStoppedSymbol = { link = 'GruvboxGreenSign' },
      },
    },
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
}
