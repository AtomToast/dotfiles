return {
  { -- Tag files and jump directly to them
    'cbochs/grapple.nvim',
    opts = { scope = 'git' },
    config = function()
      require('grapple').setup {}
      vim.keymap.set('n', '<A-0>', '<cmd>Grapple toggle_tags<CR>', { desc = 'Show Tags list' })
      for tag = 1, 9 do
        vim.keymap.set('n', '<A-' .. tag .. '>', '<cmd>Grapple select index=' .. tag .. '<CR>', { desc = 'Select tag ' .. tag })
        vim.keymap.set('n', '<leader>' .. tag, '<cmd>Grapple tag index=' .. tag .. '<CR>', { desc = 'Tag buffer as ' .. tag })
      end
    end,
  },
}
