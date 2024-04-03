return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        -- add = { text = '' },
        -- change = { text = '' },
        -- delete = { text = '' },
        -- topdelete = { text = '' },
        -- changedelete = { text = '' },
      },
    },
    config = function()
      require('gitsigns').setup {}
      local gs = package.loaded.gitsigns

      -- Navigation
      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Next hunk/diff' })

      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Previous hunk/diff' })

      -- Actions
      vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage Hunk' })
      vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset Hunk' })
      vim.keymap.set('v', '<leader>hs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Stage selected hunk' })
      vim.keymap.set('v', '<leader>hr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Reset selected hunk' })
      vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
      vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Unstage hunk' })
      vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
      vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
      vim.keymap.set('n', '<leader>hb', function()
        gs.blame_line { full = true }
      end, { desc = 'Git blame line' })
      vim.keymap.set('n', '<leader>hB', gs.toggle_current_line_blame, { desc = 'Toggle current line blame' })
      vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = 'Open diff of file' })
      vim.keymap.set('n', '<leader>hD', gs.toggle_deleted, { desc = 'Toggle deleted lines' })

      -- Text object
      vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'hunk' })
      vim.keymap.set({ 'o', 'x' }, 'ah', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'hunk' })
    end,
  },
}
