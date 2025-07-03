return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>ga', ':Gwrite<CR>')
      vim.keymap.set('n', '<leader>gs', ':Git<CR>')
      vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit!<CR>')
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
      vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
      vim.keymap.set('n', '<leader>gl', ':Gllog<CR>')
      vim.keymap.set('n', '<leader>gm', ':Git mergetool<CR>')
      vim.keymap.set('n', '<leader>mh', ':diffget //2<CR>')
      vim.keymap.set('n', '<leader>ml', ':diffget //3<CR>')
    end,
  },
}
