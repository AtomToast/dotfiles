return {
  {
    'chrisgrieser/nvim-spider',
    lazy = true,
    keys = {
      {
        '<A-w>',
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { 'n', 'o', 'x' },
        desc = 'Next subword',
      },
      {
        '<A-b>',
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { 'n', 'o', 'x' },
        desc = 'Previous subword',
      },
      {
        '<A-e>',
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { 'n', 'o', 'x' },
        desc = 'Next end of subword',
      },
    },
    config = function()
      require('spider').setup()
      -- Inconsistency with how vim works, adapt or perish?
      vim.keymap.set('n', 'c<A-w>', "c<cmd>lua require('spider').motion('e')<CR>")
    end,
  },
}
