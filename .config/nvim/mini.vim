""
"  _       _ _         _
" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"
""


call plug#begin('~/.local/share/nvim/mini_plugged')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
" Plug 'tpope/vim-sensible' " is this actually needed?
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'crusoexia/vim-monokai'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'Yggdroot/indentLine'
Plug 'chaoren/vim-wordmotion'
Plug 'plasticboy/vim-markdown'
Plug 'kovetskiy/sxhkd-vim'
Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'unblevable/quick-scope'
Plug 'nacitar/a.vim'
Plug 'liuchengxu/vim-which-key'
call plug#end()


" hide classic mode display
set noshowmode
set laststatus=0

" markdown config
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_math = 1

" indentLine config
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_char = '|'
"let g:indentLine_setConceal = 0
let g:indentLine_concealcursor="c"
let g:indentLine_faster = 1
set list lcs=tab:\|·,trail:·

" set colorscheme
colorscheme  monokai

" enable italic fonts in vim in fbpad
set t_ZH=�[3m
set t_Co=256

if $TERM !~ "dvtm"
  " enable truecolor support
  set termguicolors

  " set up colorizer
  lua require'colorizer'.setup()
endif

" display indicator before linewraps
set showbreak=>\ \ \

" enable highlighting of the current line
set cursorline

set scrolloff=3

" highlight yanks
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

"----------------------------------------

" split config
set splitbelow splitright

" set the grep program to ripgrep
set grepprg=rg\ --vimgrep

" set path to work recursively through directories
set path=.,,**

" set leader to <space>
let mapleader = " "

" set up which key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
set timeoutlen=500
let g:which_key_map =  {}

" Restore last position when reopening file
au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g'\"" |
      \ endif

" make typos less annoying
cnoreabbrev Q q
cnoreabbrev W w
nnoremap Q <NOP>

" remove search highlighting shortcut
nmap <leader>s :nohlsearch<CR>

" toggle spelling
nmap <leader>S :setlocal spell!<CR>

" buffer shortcuts
let g:which_key_map.b = { 'name' : '+buffer' }
let g:which_key_map.b.n = 'switch to next buffer'
nmap <silent><leader>bn :bnext<CR>
let g:which_key_map.b.p = 'switch to previous buffer'
nmap <silent><leader>bp :bprevious<CR>
let g:which_key_map.b.d = 'deletes current buffer'
nmap <silent><leader>bd :bdelete<CR>
let g:which_key_map.b.a = 'adds new buffer'
nmap <silent><leader>ba :enew <BAR> :Files<CR>
let g:which_key_map.b.q = 'closes current buffer'
nmap <silent><leader>bq :bp <BAR> bd #<CR>
let g:which_key_map.b.o = 'close all but the current buffer'
nmap <silent><leader>bo :%bd\|e#\|bd#<cr>

" quickfix list shortcuts
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>
nnoremap <leader>cl :copen<CR>
" local quickfix list shortcuts
let g:which_key_map.l = { 'name' : '+local_qf_list' }
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>
nnoremap <leader>ll :lopen<CR>

" switch to/from  header file
let g:which_key_map.a = 'switch to alternate file'
nmap <silent><leader>a :A<CR>

" search and replace shortcut
let g:which_key_map.R = 'global search and replace'
nmap <leader>R :%s//gI<left><left><left>

" open netrw
nnoremap <leader>E :Explore<CR>
nnoremap <leader>L :30Lexplore<CR>

" create saner navigation bindings
autocmd filetype netrw nmap <buffer> h -
autocmd filetype netrw nmap <buffer> l <cr>
autocmd filetype netrw nmap <buffer> cd gn

" call make with a shortcut
nmap <leader>mm :Make<CR>

" ctrl+s saving
noremap  <silent> <C-S> :update<CR>:nohlsearch<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>:nohlsearch<CR>
inoremap <silent> <C-S> <C-O>:update<CR><C-O>:nohlsearch<CR>

" make arrows resize splits
nnoremap <silent><Up>    :resize +2<CR>
nnoremap <silent><Down>  :resize -2<CR>
nnoremap <silent><Left>  :vertical resize +2<CR>
nnoremap <silent><Right> :vertical resize -2<CR>

" shortcut for entering semicolon at the end of the line
inoremap <A-,> <Esc>A;<Esc>
nnoremap <A-,> A;<Esc>

" swap semicolon and comma because of my german layout
nnoremap ; ,
nnoremap , ;
nnoremap g, g;
nnoremap g; g,

" make j and k behave like gj and gk
nnoremap j gj
nnoremap k gk


" create a shortcut for taking the first correction
let g:which_key_map.z = 'apply first spelling suggestion'
nnoremap <leader>z 1z=

" fix last spelling mistake
let g:which_key_map.Z = 'fix spelling of last word'
nnoremap <leader>Z [s1z=

" use alt + word motion keys for special behaviour
let g:wordmotion_mappings = {
\ 'w' : '<A-w>',
\ 'b' : '<A-b>',
\ 'e' : '<A-e>',
\ 'ge' : 'g<A-e>',
\ 'aw' : 'a<A-w>',
\ 'iw' : 'i<A-w>',
\ '<C-R><C-W>' : '<C-R><A-w>'
\ }

" set additional characters as space characters
let g:wordmotion_spaces = '_-.'

" configure fzf
nmap <silent><leader>p :Files<CR>
nmap <silent><leader>P :GFiles<CR>
nmap <silent><leader>bb :Buffers<CR>
nmap <silent><leader>bl :BLines<CR>
nmap <silent><leader>rg :Rg<CR>

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" remap Y to work like other captial letters
nnoremap Y y$

" switch windows in any mode with ctrl + alt + hjkl
tnoremap <C-A-h> <C-\><C-N><C-w>h
tnoremap <C-A-j> <C-\><C-N><C-w>j
tnoremap <C-A-k> <C-\><C-N><C-w>k
tnoremap <C-A-l> <C-\><C-N><C-w>l
inoremap <C-A-h> <C-\><C-N><C-w>h
inoremap <C-A-j> <C-\><C-N><C-w>j
inoremap <C-A-k> <C-\><C-N><C-w>k
inoremap <C-A-l> <C-\><C-N><C-w>l
nnoremap <C-A-h> <C-w>h
nnoremap <C-A-j> <C-w>j
nnoremap <C-A-k> <C-w>k
nnoremap <C-A-l> <C-w>l

nnoremap <silent><leader>tt :10sp<CR>:terminal<CR>

" ° to exit terminal mode
tnoremap <C-s> <C-\><C-n>

" remove a lot of clutter from terminal buffers
autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 " norelativenumber nonumber
autocmd TermOpen * startinsert

" Prefer Neovim terminal insert mode to normal mode.
autocmd BufEnter term://* startinsert

" I'm a save addict
au FocusLost * :wa
set autowriteall

" enable relative numbers
set number relativenumber

" enable system clipboard
set clipboard+=unnamedplus

" enable instant substitute preview
set inccommand=nosplit

" smarter searching
set ignorecase
set smartcase

" configure tabs
set autoindent
" Indenting defaults (does not override vim-sleuth's indenting detection)
" Defaults to 4 spaces for most filetypes
if get(g:, '_has_set_default_indent_settings', 0) == 0
  " Set the indenting level to 2 spaces for the following file types.
  autocmd FileType typescript,javascript,jsx,tsx,css,html,ruby,elixir,kotlin,sql,haskell,vim,markdown
        \ setlocal expandtab tabstop=2 shiftwidth=2
  set expandtab
  set tabstop=4
  set shiftwidth=4
  let g:_has_set_default_indent_settings = 1
endif

" Set maximum text width and spelling
if !exists('g:started_by_firenvim')
    autocmd FileType text,markdown,tex,mail setlocal textwidth=79 spell
endif

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

" set spell check languages
set spelllang=en_us,en_gb,de_20

" set matches for insert mode completion
set complete=.,w,b,u,t,i,kspell

" enable persistent undohistory
set undofile

" autoremove trailing whitespaces
fun! StripTrailingWhitespace()
  " Don't strip on these filetypes
  if (index(['markdown'], &filetype) >= 0)
    return
  endif
  %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()

" auto-pairs configuration
let g:AutoPairsShortcutBackInsert = '<M-i>'
autocmd FileType vim let g:AutoPairsMultilineClose = 0

" correct latex buffer filetype
let g:tex_flavor = "latex"

" netrw hide banner
let g:netrw_banner=0

" netrw show previews on the right
let g:netrw_preview=1
let g:netrw_alto=0

" netrw window size
let g:netrw_winsize=30

" netrw opens in tree view by default
let g:netrw_liststyle=3

" hide dotfiles by default in netrw
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

" quick-scope configuration
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_buftype_blacklist = ['terminal']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

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
