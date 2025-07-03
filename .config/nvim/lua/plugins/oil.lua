return {
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup {
        keymaps = {
          ['<BS>'] = 'actions.parent',
        },
      }

      vim.keymap.set('n', '<leader>o', '<cmd>Oil<CR>')
    end,
  },
}
