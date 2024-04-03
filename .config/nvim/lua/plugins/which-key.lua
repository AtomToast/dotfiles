return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function()
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = '[H]unk', _ = 'which_key_ignore' },
      }
    end,
  },
}
