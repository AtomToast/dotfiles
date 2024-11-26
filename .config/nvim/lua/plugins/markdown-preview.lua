return {
  {
    'iamcco/markdown-preview.nvim',

    build = 'cd app && npm install && git restore .',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'markdown' },
        callback = function()
          vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', {
            buffer = true,
            desc = 'Toggle Markdown Preview',
          })
        end,
      })
    end,
    ft = { 'markdown' },
  },
}
