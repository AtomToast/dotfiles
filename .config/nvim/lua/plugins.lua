local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  'tpope/vim-sleuth',

  { 'kylechui/nvim-surround', opts = {} },

  { 'numToStr/Comment.nvim', opts = {} },

  require 'plugins/highlight-colors',

  require 'plugins/fugitive',

  require 'plugins/gitsigns',

  require 'plugins/which-key',

  require 'plugins/telescope',

  require 'plugins/lspconfig',

  require 'plugins/conform',

  require 'plugins/lint',

  require 'plugins/cmp',

  require 'plugins/gruvbox',

  require 'plugins/markdown-preview',

  require 'plugins/todo-comments',

  require 'plugins/treesitter',

  require 'plugins/debug',

  require 'plugins/dadbod',

  -- require 'plugins/indent_line',

  require 'plugins/autopairs',

  require 'plugins/grapple',

  require 'plugins/spider',

  require 'plugins/textobjects',

  require 'plugins/wiki',
}
