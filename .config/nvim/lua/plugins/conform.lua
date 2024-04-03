return {
  { -- Autoformat
    'stevearc/conform.nvim',
    config = function()
      local conform = require 'conform'
      conform.setup {
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style
          local disable_filetypes = { c = true, cpp = true }
          return {
            timeout_ms = 500,
            lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          }
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'ruff_format', 'ruff_fix' },
          sh = { 'shfmt' },
          zig = { 'zigfmt' },
          go = { 'gofmt' },
          rust = { 'rustfmt' },
          html = { 'prettier' },
          css = { 'prettier' },
          json = { 'prettier' },
          yaml = { 'prettier' },
          markdown = { 'prettier' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
        },
      }

      vim.keymap.set('n', '<leader>f', function()
        conform.format { async = true, timeout_ms = 500 }
      end, { desc = 'Format the current buffer' })
    end,
  },
}
