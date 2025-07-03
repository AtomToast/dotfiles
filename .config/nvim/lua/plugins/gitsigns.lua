return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
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
      vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
      vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
      vim.keymap.set('n', '<leader>hP', gs.preview_hunk_inline, { desc = 'Preview hunk inline' })
      vim.keymap.set('n', '<leader>hb', function()
        gs.blame_line { full = true }
      end, { desc = 'Git blame line' })
      vim.keymap.set('n', '<leader>hB', gs.blame, { desc = 'Git blame file' })
      vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = 'Open diff of file' })

      -- Text object
      vim.keymap.set({ 'o', 'x' }, 'ih', gs.select_hunk, { desc = 'hunk' })
      vim.keymap.set({ 'o', 'x' }, 'ah', gs.select_hunk, { desc = 'hunk' })

      -- Show git signs on the right side of the linenumbers
      -- Inspired by https://github.com/folke/snacks.nvim/blob/main/lua/snacks/statuscolumn.lua
      local sign_cache = {}
      local timer = assert((vim.uv or vim.loop).new_timer())
      timer:start(50, 50, function()
        sign_cache = {}
      end)

      function _G.get_buf_signs(buf)
        local signs = {}
        local extmarks = vim.api.nvim_buf_get_extmarks(buf, -1, 0, -1, { details = true, type = 'sign' })

        for _, em in pairs(extmarks) do
          local lnum = em[2] + 1
          local sign = em[4]

          signs[lnum] = signs[lnum] or {}
          table.insert(signs[lnum], sign)
        end
        return signs
      end

      function _G.status_column()
        if vim.v.virtnum ~= 0 then
          return ''
        end

        local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
        local buf_signs = {}
        if sign_cache[buf] then
          buf_signs = sign_cache[buf]
        else
          buf_signs = _G.get_buf_signs(buf) or {}
          sign_cache[buf] = buf_signs
        end
        local line_signs = buf_signs[vim.v.lnum] or {}

        local sign, git_sign
        for _, s in pairs(line_signs) do
          if s.sign_hl_group:find 'GitSign' then
            git_sign = s
          else
            if not sign then
              sign = s
            elseif s.priority > sign.priority then
              sign = s
            end
          end
        end
        local components = {
          sign and ('%#' .. sign.sign_hl_group .. '#' .. sign.sign_text .. '%*') or '  ',
          [[%=%l]],
          git_sign and ('%#' .. git_sign.sign_hl_group .. '#' .. git_sign.sign_text .. '%*') or (vim.bo[buf].buftype == '' and '  ' or ' '),
        }
        return table.concat(components, '')
      end

      vim.o.statuscolumn = [[%!v:lua.status_column()]]
    end,
  },
}
