return {
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup {
        keymaps = {
          ['<BS>'] = 'actions.parent',
          ['<C-s>'] = false,
          ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
        },
      }

      vim.keymap.set('n', '<leader>o', '<cmd>Oil<CR>')
    end,
  },
}
