return {
  {
    'ellisonleao/gruvbox.nvim',
    opts = {
      transparent_mode = true,
      overrides = {
        -- Gruvbox Gitsigns highlighting is broken, a suggested fix is just
        -- disabling the background of the sign column
        SignColumn = { link = 'LineNr' },
        -- Aqua is too similar to green and I'm used to orange
        -- If you don't have the fix above, use 'GruvboxOrangeSign' etc
        GitSignsChange = { link = 'GruvboxOrange' },
      },
    },
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
}
