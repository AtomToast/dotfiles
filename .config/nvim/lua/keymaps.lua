-- Set leader to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make typos less annoying
vim.cmd.abbreviate('Q', 'q')
vim.cmd.abbreviate('W', 'w')
vim.keymap.set('n', 'Q', '<NOP>', { desc = 'Disable q' })

-- Enable mouse but only for scrolling because foot doesn't do this right
vim.opt.mouse = 'a'

-- Remove an annoying binding, make reformatting current block nicer
vim.keymap.set('n', 'gQ', 'vipJgqq', { desc = 'Reformat current paragraph' })

-- Set highlight on search, but clear on saving or pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Toggle spell checking
vim.keymap.set('n', '<leader>S', '<cmd>setlocal spell!<CR>', { desc = 'Toggle spell checking' })

-- Enable saving with Ctrl+S (also remove search highlighting)
vim.keymap.set({ 'n', 'v', 'i' }, '<C-s>', '<cmd>update<CR><cmd>nohlsearch<CR>')

-- Call make with a shortcut
vim.keymap.set('n', '<leader>mm', ':silent make<bar>cwindow<CR>', { desc = 'Run default make command' })
vim.keymap.set('n', '<leader>mc', ':silent make clean<bar>cwindow<CR>', { desc = 'Run make clean' })
vim.keymap.set('n', '<leader>mb', ':silent make build<bar>cwindow<CR>', { desc = 'Run make build' })
vim.keymap.set('n', '<leader>mr', ':silent make run<bar>cwindow<CR>', { desc = 'Run make run' })
vim.keymap.set('n', '<leader>mi', ':!sudo make install<bar>cwindow<CR>', { desc = 'Run sudo make install' })

-- Quickfix list shortcuts
vim.keymap.set('n', '<leader>cn', vim.cmd.cnext, { desc = 'Go to [N]ext error in quickfix list' })
vim.keymap.set('n', '<leader>cp', vim.cmd.cprevious, { desc = 'Go to [P]revious error in quickfix list' })
vim.keymap.set('n', '<leader>cl', vim.cmd.cwindow, { desc = 'Toggle quickfix [L]ist window' })
vim.keymap.set('n', '<leader>ln', vim.cmd.lnext, { desc = 'Go to [N]ext error in location list' })
vim.keymap.set('n', '<leader>lp', vim.cmd.lprevious, { desc = 'Go to [P]revious error in location list' })
vim.keymap.set('n', '<leader>ll', vim.cmd.lwindow, { desc = 'Toggle location [L]ist window' })

-- Search and replace (substitute)
vim.keymap.set('n', '<leader>R', ':%s//gI<left><left><left>', { desc = 'Search and [R]eplace in whole file' })
vim.keymap.set('v', '<leader>R', ':s//gI<left><left><left>', { desc = 'Search and [R]eplace in selection' })

-- Create and edit new file under cursor
vim.keymap.set('n', '<leader>gf', '<cmd>e <cfile><CR>', { desc = 'Create and edit new [F]ile under cursor' })

-- Insert semicolon at the end of the line
vim.keymap.set('n', '<A-;>', 'mkA;<Esc>`k')
vim.keymap.set('i', '<A-;>', '<Esc>mkA;<Esc>`ka')

-- Insert comma at the end of the line
vim.keymap.set('n', '<A-,>', 'mkA,<Esc>`k')
vim.keymap.set('i', '<A-,>', '<Esc>mkA,<Esc>`ka')

-- Make j and k behave like gj and gk
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Apply first spelling suggestion
vim.keymap.set('n', '<leader>z', '1z=', { desc = 'Apply first spelling suggestion' })

-- Fix last spelling mistake
vim.keymap.set('n', '<leader>Z', '[s1z=', { desc = 'Fix last spelling mistake' })

-- Replace without copying the selection
vim.keymap.set('v', '<leader>p', '"_dP', { desc = 'Replace the selection without replacing the clipboard' })

-- Exit terminal mode in the builtin terminal with Ctrl+s
vim.keymap.set('t', '<C-s>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  Use Alt+<hjkl> and Alt+arrow keys to switch between windows
vim.keymap.set({ 'n', 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n', 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'n', 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set({ 'n', 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set({ 'n', 't', 'i' }, '<A-Left>', '<C-\\><C-n><C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n', 't', 'i' }, '<A-Down>', '<C-\\><C-n><C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'n', 't', 'i' }, '<A-Up>', '<C-\\><C-n><C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set({ 'n', 't', 'i' }, '<A-Right>', '<C-\\><C-n><C-w><C-l>', { desc = 'Move focus to the right window' })

-- Use Ctrl+Alt+<hjkl> and Ctrl+Alt+arrows to resize splits
vim.keymap.set({ 'n', 't', 'i' }, '<C-A-h>', '<cmd>vertical resize +2<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<C-A-j>', '<cmd>resize -2<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<C-A-k>', '<cmd>resize +2<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<C-A-l>', '<cmd>vertical resize -2<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<C-A-Left>', '<cmd>vertical resize +2<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<C-A-Down>', '<cmd>resize -2<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<C-A-Up>', '<cmd>resize +2<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<C-A-Right>', '<cmd>vertical resize -2<CR>')

-- 'q' closes more temp buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'checkhealth', 'fugitive*', 'git', 'help', 'lspinfo', 'netrw', 'oil', 'notify', 'qf', 'query' },
  callback = function()
    vim.keymap.set('n', 'q', vim.cmd.close, { desc = 'Close the current buffer', buffer = true })
  end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 500 }
  end,
})
