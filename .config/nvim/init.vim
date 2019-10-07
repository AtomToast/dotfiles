""            _
"  _ ____   _(_)_ __ ___  _ __ ___
" | '_ \ \ / / | '_ ` _ \| '__/ __|
" | | | \ V /| | | | | | | | | (__
" |_| |_|\_/ |_|_| |_| |_|_|  \___|
"
""


call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'bling/vim-bufferline'
Plug 'sickill/vim-monokai'
Plug 'nerdypepper/agila.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'airblade/vim-gitgutter'
"Plug 'liuchengxu/vista.vim'
Plug 'scrooloose/nerdtree'
Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'
Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nacitar/a.vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()


" airline config
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme='bubblegum'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#fnamecollapse = 1

" markdown config
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1


" jsx config
let g:vim_jsx_pretty_colorful_config = 1


" indentLine config
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
"let g:indentLine_setConceal = 0
let g:indentLine_concealcursor="nc"

" set colorscheme
colorscheme agila " monokai

" set Visual mode color
highlight Visual guibg=#555585

" NERDTree remove padding before icons
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true

" NERDTress File highlighting
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" set gitgutter symbol colors
highlight GitGutterAdd    guifg=#009900 guibg=#3c3d37 ctermfg=2 ctermbg=237
highlight GitGutterChange guifg=#bbbb00 guibg=#3c3d37 ctermfg=3 ctermbg=237
highlight GitGutterDelete guifg=#ff2222 guibg=#3c3d37 ctermfg=1 ctermbg=237

" NERDTree highlighting based on git status
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeColorMapCustom = {
    \ "Modified"  : "#528AB3",
    \ "Staged"    : "#538B54",
    \ "Untracked" : "#BE5849",
    \ "Dirty"     : "#299999",
    \ "Clean"     : "#87939A",
    \ "Ignored"   : "#808080"
    \ }
"----------------------------------------

" split config
set splitbelow splitright

" set leader to <space>
let mapleader = " "

"set gitgutter shortcuts
nmap <leader>hj <Plug>GitGutterNextHunk
nmap <leader>hk <Plug>GitGutterPrevHunk

" remove search highlighting shortcut
nmap <leader>s :nohlsearch<CR>

" buffer shortcuts
nmap <leader>bl :ls<CR>
nmap <silent><leader>bn :bnext<CR>
nmap <silent><leader>bp :bprevious<CR>
nmap <silent><leader>bd :bdelete<CR>
nmap <silent><leader>ba :enew <BAR> :CtrlP<CR>
nmap <silent><leader>bq :bp <BAR> bd #<CR>

" switch to/from  header file
nmap <silent><leader>a :A<CR>

" shortcuts for moving lines
nnoremap <silent> <C-A-j> :m .+1<CR>==
nnoremap <silent> <C-A-k> :m .-2<CR>==
inoremap <silent> <C-A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <C-A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <C-A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <C-A-k> :m '<-2<CR>gv=gv

" ctrl+s saving
noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" make arrows resize splits
nnoremap <silent><Up>    :resize +2<CR>
nnoremap <silent><Down>  :resize -2<CR>
nnoremap <silent><Left>  :vertical resize +2<CR>
nnoremap <silent><Right> :vertical resize -2<CR>

" do not require ctrl+w to switch between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" configure ctrlp
let g:ctrlp_map = '<leader>p'
nmap <silent><leader>bb :CtrlPBuffer<CR>

" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" I'm a save addict
:au FocusLost * :wa
:set autowriteall

" enable relative numbers
set number relativenumber

" enable system clipboard
set clipboard+=unnamedplus

" set caps lock to escape in vim
"au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" configure tabs
set expandtab
set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType json setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Set maximum text width
autocmd FileType text,markdown,tex setlocal textwidth=80

" set matches for insert mode completion
set complete=.,w,b,u,t,i,kspell

" coc config
call coc#add_extension('coc-pairs', 'coc-marketplace', 'coc-texlab', 'coc-highlight', 'coc-yank', 'coc-prettier', 'coc-snippets', 'coc-emoji', 'coc-html', 'coc-yaml', 'coc-css', 'coc-python', 'coc-tsserver', 'coc-json')
set hidden
set nobackup
set nowritebackup
set signcolumn=yes
set shortmess+=c
set cmdheight=2
set updatetime=300
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
set termguicolors

imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" autoremove trailing whitespaces
autocmd BufWritePre * %s/\s\+$//e

" configure nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
nmap <silent><leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" disable indentLine in NERDTree
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']

" correct latex buffer filetype
let g:tex_flavor = "latex"
