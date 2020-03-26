""
"  _       _ _         _
" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"
""


call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-speeddating'
if !exists('g:started_by_firenvim')
    Plug 'tpope/vim-sensible'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
endif
Plug 'junegunn/vim-easy-align'
Plug 'sickill/vim-monokai'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'luochen1990/rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'chaoren/vim-wordmotion'
Plug 'airblade/vim-rooter'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'plasticboy/vim-markdown'
Plug 'baskerville/vim-sxhkdrc'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'elzr/vim-json'
Plug 'elixir-editors/vim-elixir'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'airblade/vim-gitgutter'
Plug 'liuchengxu/vista.vim'
Plug 'djoshea/vim-autoread'
Plug 'honza/vim-snippets'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'nacitar/a.vim'
Plug 'psliwka/vim-smoothie'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ryanoasis/vim-devicons'
call plug#end()


" airline config
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme='base16_monokai'
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

" hide classic mode display
set noshowmode

" markdown config
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0


" jsx config
let g:vim_jsx_pretty_colorful_config = 1


" indentLine config
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
"let g:indentLine_setConceal = 0
let g:indentLine_concealcursor="c"
let g:indentLine_faster = 1

" set termguicolors
set termguicolors

" set colorscheme
colorscheme  monokai
highlight Normal guibg=#282828
highlight Pmenu guibg=#383830
highlight elixirAtom guifg=#ae81ff
highlight elixirModuleDeclaration guifg=#f4bf75
highlight elixirAlias guifg=#fd971f
highlight elixirStringDelimiter guifg=#e6db74

" set up colorizer
lua require'colorizer'.setup()

" set gitgutter symbol colors
highlight GitGutterAdd    guifg=#a6e22e guibg=#3c3d37 ctermfg=2 ctermbg=237
highlight GitGutterChange guifg=#fd971f guibg=#3c3d37 ctermfg=3 ctermbg=237
highlight GitGutterDelete guifg=#f92672 guibg=#3c3d37 ctermfg=1 ctermbg=237

" rainbow parantheses config
let g:rainbow_active = 1

"----------------------------------------

" split config
set splitbelow splitright

" set leader to <space>
let mapleader = " "

" set gitgutter shortcuts
nmap <leader>hj <Plug>(GitGutterNextHunk)
nmap <leader>hk <Plug>(GitGutterPrevHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)

" remove search highlighting shortcut
nmap <leader>s :nohlsearch<CR>

" toggle spelling
nmap <leader>S :setlocal spell!<CR>

" buffer shortcuts
nmap <leader>bl :ls<CR>
nmap <silent><leader>bn :bnext<CR>
nmap <silent><leader>bp :bprevious<CR>
nmap <silent><leader>bd :bdelete<CR>
nmap <silent><leader>ba :enew <BAR> :Files<CR>
nmap <silent><leader>bq :bp <BAR> bd #<CR>

" git/fugitive shortcuts
nmap <leader>ga :Gwrite<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gl :Glog<CR>

" switch to/from  header file
nmap <silent><leader>a :A<CR>

" search and replace shortcut
nmap <leader>R :%s//g<left><left>

" open netrw
nnoremap <leader>E :Explore<CR>
nnoremap <leader>L :30Lexplore<CR>

" toggle vista
nmap <silent><leader>v :Vista!!<CR>

" start and stop MarkdownPreview
nmap <leader>mp :MarkdownPreview<CR>
nmap <leader>ms :MarkdownPreviewStop<CR>

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

" shortcut for entering semicolon at the end of the line
inoremap <A-,> <Esc>A;<Esc>
nnoremap <A-,> A;<Esc>

" create an empty line above/below
nnoremap <A-o> o<Esc>k
nnoremap <A-O> O<Esc>j
inoremap <A-o> <C-o>o<C-o>k
inoremap <A-O> <C-o>O<C-o>j

" create a shortcut for taking the first correction
nnoremap <leader>z 1z=

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
nmap <silent><leader>bb :Buffers<CR>
nmap <silent><leader>rg :Rg<CR>

" vim-easy-align configuration
"" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" remap Y to work like other captial letters
nnoremap Y y$

" switch windows in any mode with alt + hjkl
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" remove a lot of clutter from terminal buffers
autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 norelativenumber nonumber

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

" Set maximum text width and spelling
autocmd FileType text,markdown,tex setlocal textwidth=80 spell

" enable syntax highlighting in vifmrc
autocmd FileType vifm set syntax=vim

" enable comment highlighting in json
autocmd FileType json syntax match Comment +\/\/.\+$+

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc silent! !pkill -USR1 sxhkd
            \ && notify-send -t 1700 'reloaded sxhkd config'

" enable search in vista
autocmd FileType vista,vista_kind nnoremap <buffer> <silent> /
            \ :<c-u>call vista#finder#fzf#Run()<CR>

" set spell check languages
set spelllang=en_us,en_gb,de_20

" set matches for insert mode completion
set complete=.,w,b,u,t,i,kspell

" coc config
call coc#add_extension('coc-pairs', 'coc-marketplace', 'coc-texlab',  'coc-yank',
                     \ 'coc-prettier', 'coc-snippets', 'coc-emoji', 'coc-html',
                     \ 'coc-yaml', 'coc-css', 'coc-python', 'coc-tsserver',
                     \ 'coc-json', 'coc-sql', 'coc-elixir')
set hidden
set nobackup
set nowritebackup
set signcolumn=yes
" set shortmess+=c
" set cmdheight=2
set updatetime=300
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <C-j> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <C-j> pumvisible() ? coc#_select_confirm() :
            \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
            \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd FileType vim let b:coc_pairs_disabled = ['"']

inoremap <silent><expr> <c-n> coc#refresh()

"" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

"" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"" Format selected content
vmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)

"" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

"" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

"" Using CocList
""" Show all diagnostics
nnoremap <silent><leader>cd  :<C-u>CocList diagnostics<cr>
""" Manage extensions
nnoremap <silent><leader>ce  :<C-u>CocList extensions<cr>
""" Show commands
nnoremap <silent><leader>cc  :<C-u>CocList commands<cr>
""" Find symbol of current document
nnoremap <silent><leader>co  :<C-u>CocList outline<cr>
""" Search workspace symbols
nnoremap <silent><leader>cs  :<C-u>CocList -I symbols<cr>
""" Do default action for next item.
nnoremap <silent><leader>cj  :<C-u>CocNext<CR>
""" Do default action for previous item.
nnoremap <silent><leader>ck  :<C-u>CocPrev<CR>
""" Resume latest coc list
nnoremap <silent><leader>cr  :<C-u>CocListResume<CR>

" autoremove trailing whitespaces
fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()

" correct latex buffer filetype
let g:tex_flavor = "latex"

" markdown-preview config
let g:mkdp_browser = 'surf'

" netrw hide banner
let g:netrw_banner=0

" netrw opens in tree view by default
let g:netrw_liststyle=3

" hide dotfiles by default in netrw
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

" firenvim configuration
if exists('g:started_by_firenvim')
    " turn off statusbar
    set laststatus=0
    " disable tabline
    let g:airline#extensions#tabline#enabled = 0
    " disable signcolumn
    set signcolumn=no
    " disable numbers
    set norelativenumber nonumber
    " add shortcut for focusing the page
    nnoremap <silent><Esc><Esc> :call firenvim#focus_page()<CR>
    " add shortcut for hiding the frame
    nnoremap <silent><C-z> :call firenvim#hide_frame()<CR>
    " use external commandline for firenvim
    let g:firenvim_config = {
        \ 'localSettings': {
            \ '.*': {
                \ 'cmdline': 'firenvim',
            \ },
        \ }
    \ }
endif
