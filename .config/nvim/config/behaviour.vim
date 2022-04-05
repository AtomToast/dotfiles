" set the grep program to ripgrep
set grepprg=rg\ --vimgrep

" set path to work recursively through directories
set path=.,,**

" define python provider
let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python'

" Restore last position when reopening file
au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g'\"" |
      \ endif

" remove a lot of clutter from terminal buffers
autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 " norelativenumber nonumber
autocmd TermOpen * startinsert

" Prefer Neovim terminal insert mode to normal mode.
autocmd BufEnter term://* startinsert

" I'm a save addict
au FocusLost * :wa
set autowriteall

" automatically load changes to open files
set autoread

" enable system clipboard
set clipboard+=unnamedplus

" enable instant substitute preview
set inccommand=nosplit

"
set ignorecase
set smartcase

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc silent! !pkill -USR1 sxhkd
      \ && notify-send -t 1700 'reloaded sxhkd config'

" Update binds when xkeysnail is updated.
autocmd BufWritePost *xkeysnail/config.py silent! !killall xkeysnail;
      \ xkeysnail -q .config/xkeysnail/config.py 1>/dev/null &; disown
      \ && notify-send -t 1700 'reloaded xkeysnail config'

" automatically add filename as header to markdown files
function ConvertName2Title() abort
    return substitute(substitute(expand("%:t:r"), "_", " ","g"), "\\<.","\\U\\0","g")
endfunction
autocmd BufNewFile *.md execute "normal i# \<C-r>=ConvertName2Title()\<CR>"

" set matches for insert mode completion
set complete=.,w,b,u,t,i,kspell

" remove status line spam
set shortmess+=c

" enable persistent undohistory
set undofile

" set spell check languages
set spelllang=en_us,en_gb,de_20

" autoremove trailing whitespaces
fun! StripTrailingWhitespace()
  " Don't strip on these filetypes
  if (index(['vimwiki','markdown'], &filetype) >= 0)
    return
  endif
  %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()

" correct latex buffer filetype
let g:tex_flavor = "latex"

" hide stuff inside of dvtms editor mode
function! HideClutter() abort
  " turn off statusbar
  setlocal laststatus=0
  " disable tabline
  let g:airline#extensions#tabline#enabled = 0
  " disable signcolumn
  setlocal signcolumn=no
  " disable numbers
  setlocal norelativenumber nonumber
  " disable indentLine
  IndentLinesDisable
endfunction
autocmd BufEnter *dvtm-editor* call HideClutter()
