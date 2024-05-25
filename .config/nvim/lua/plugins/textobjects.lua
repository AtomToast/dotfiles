return {
  {
    'chrisgrieser/nvim-various-textobjs',
    lazy = false,
    config = function()
      vim.keymap.set({ 'o', 'x' }, 'i<A-w>', "<cmd>lua require('various-textobjs').subword('inner')<CR>")
      vim.keymap.set({ 'o', 'x' }, 'a<A-w>', "<cmd>lua require('various-textobjs').subword('outer')<CR>")

      vim.keymap.set('n', 'dsi', function()
        -- select outer indentation
        require('various-textobjs').indentation('outer', 'outer')

        -- plugin only switches to visual mode when a textobj has been found
        local indentationFound = vim.fn.mode():find 'V'
        if not indentationFound then
          return
        end

        -- dedent indentation
        vim.cmd.normal { '<', bang = true }

        -- delete surrounding lines
        local endBorderLn = vim.api.nvim_buf_get_mark(0, '>')[1]
        local startBorderLn = vim.api.nvim_buf_get_mark(0, '<')[1]
        vim.cmd(tostring(endBorderLn) .. ' delete') -- delete end first so line index is not shifted
        vim.cmd(tostring(startBorderLn) .. ' delete')
      end, { desc = 'Delete Surrounding Indentation' })

      vim.keymap.set({ 'o', 'x' }, 'ii', "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>", { desc = 'inner indentation' })
      vim.keymap.set({ 'o', 'x' }, 'ai', "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>", { desc = 'outer indentation' })
      vim.keymap.set({ 'o', 'x' }, 'iI', "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>", { desc = 'indentation and starting border' })
      vim.keymap.set({ 'o', 'x' }, 'aI', "<cmd>lua require('various-textobjs').indentation('inner', 'outer')<CR>", { desc = 'indentation and ending border' })

      vim.keymap.set(
        { 'o', 'x' },
        'ig',
        "<cmd>lua require('various-textobjs').greedyOuterIndentation('inner')<CR>",
        { desc = 'indentation and greedy borders' }
      )
      vim.keymap.set(
        { 'o', 'x' },
        'ag',
        "<cmd>lua require('various-textobjs').greedyOuterIndentation('outer')<CR>",
        { desc = 'indentation and greedy borders (with white space)' }
      )

      vim.keymap.set({ 'o', 'x' }, 'I', "<cmd>lua require('various-textobjs').restOfIndentation()<CR>", { desc = 'Until the end of the current indentation' })

      vim.keymap.set({ 'o', 'x' }, 'iq', "<cmd>lua require('various-textobjs').anyQuote('inner')<CR>", { desc = 'any quoted string without the quotes' })
      vim.keymap.set({ 'o', 'x' }, 'aq', "<cmd>lua require('various-textobjs').anyQuote('outer')<CR>", { desc = 'any quoted string' })

      vim.keymap.set(
        { 'o', 'x' },
        'iQ',
        "<cmd>lua require('various-textobjs').pyTripleQuotes('inner')<CR>",
        { buffer = true, desc = 'triple quoted python string without the quotes' }
      )
      vim.keymap.set(
        { 'o', 'x' },
        'aQ',
        "<cmd>lua require('various-textobjs').pyTripleQuotes('outer')<CR>",
        { buffer = true, desc = 'triple quoted python string' }
      )

      vim.keymap.set({ 'o', 'x' }, 'gG', "<cmd>lua require('various-textobjs').entireBuffer()<CR>", { desc = 'The entire File' })

      vim.keymap.set({ 'o', 'x' }, '|', "<cmd>lua require('various-textobjs').column()<CR>", { desc = 'Until the end of the current column' })

      vim.keymap.set({ 'o', 'x' }, 'u', "<cmd>lua require('various-textobjs').url()<CR>", { desc = 'URL' })
    end,
  },
}
