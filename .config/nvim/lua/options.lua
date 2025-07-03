-- Enable relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Disable status line
vim.opt.laststatus = 1

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Don't show useless completion info in status
vim.opt.shortmess:append 'c'

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Please don't indent with 8 width tabs like wtf
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Speed up vimgrep
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.grepformat = '%f:%l:%c:%m'

-- Set spell checking languages
vim.opt.spelllang = { 'en_us', 'en_gb', 'de_20' }

-- Speed up startup and help with venvs
vim.g.python3_host_prog = '/usr/bin/python'

-- Save undo history
vim.opt.undofile = true

-- I'm a save addict
vim.opt.autowriteall = true
vim.api.nvim_create_autocmd('FocusLost', { pattern = '*?', command = 'wa' })

-- Restore last position when reopening file
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if not (ft:match 'commit' and ft:match 'rebase') and last_known_line > 1 and last_known_line <= vim.api.nvim_buf_line_count(opts.buf) then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- Prefer Neovim terminal insert mode to normal mode.
vim.api.nvim_create_autocmd({ 'TermOpen', 'WinEnter' }, { pattern = 'erm://*', command = 'startinsert' })

-- Restart sxhkd when it's config is saved
vim.api.nvim_create_autocmd('BufWritePost', { pattern = '*sxhkdrc', command = 'silent! !pkill -USR1 sxhkd && notify-send -t 1700 "reloaded sxhkd config"' })

-- Automatically remove trailing whitespace
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  callback = function()
    if not vim.tbl_contains({ 'vimwiki', 'markdown' }, vim.bo.filetype) then
      vim.cmd [[%s/\s\+$//e]]
    end
  end,
})
