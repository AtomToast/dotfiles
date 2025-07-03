return {
  {
    'mfussenegger/nvim-lint',
    dependencies = {
      'rshkarin/mason-nvim-lint',
    },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        sh = { 'shellcheck' },
        vim = { 'vint' },
        python = { 'mypy', 'ruff' },
      }

      -- WORK
      require('mason-nvim-lint').setup {
        ignore_install = { 'mypy', 'ruff' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
        -- WORK
        pattern = '{*}' .. '{' .. '*/test/*' .. '}\\@<!', --exclude test directory
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
