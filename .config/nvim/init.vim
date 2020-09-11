""
"  _       _ _         _
" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"
""


call plug#begin('~/.local/share/nvim/plugged')
" Plug 'dstein64/vim-startuptime'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
if !exists('g:started_by_firenvim')
    Plug 'tpope/vim-sensible'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
endif
Plug 'Konfekt/vim-CtrlXA'
Plug 'godlygeek/tabular'
Plug 'crusoexia/vim-monokai'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'luochen1990/rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript', 'javascript.jsx', 'typescript.tsx'] }
Plug 'Yggdroot/indentLine'
Plug 'chaoren/vim-wordmotion'
Plug 'airblade/vim-rooter'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'plasticboy/vim-markdown'
Plug 'kovetskiy/sxhkd-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'vifm/vifm.vim'
Plug 'vimwiki/vimwiki'
Plug 'elzr/vim-json'
Plug 'elixir-editors/vim-elixir'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neovimhaskell/haskell-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'airblade/vim-gitgutter'
Plug 'liuchengxu/vista.vim'
Plug 'djoshea/vim-autoread'
Plug 'honza/vim-snippets'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'unblevable/quick-scope'
Plug 'nacitar/a.vim'
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
let g:airline_symbols.linenr = '  '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#whitespace#skip_indent_check_ft = {
            \ 'make': ['indent', 'mixed-indent-file'],
            \ 'markdown': ['trailing'],
            \ 'vimwiki': ['trailing']
            \ }

" hide classic mode display
set noshowmode

" markdown config
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_math = 1

" jsx config
let g:vim_jsx_pretty_colorful_config = 1


" indentLine config
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
"let g:indentLine_setConceal = 0
let g:indentLine_concealcursor="c"
let g:indentLine_faster = 1

" set colorscheme
colorscheme  monokai
" highlight Normal guibg=#282828
highlight elixirAtom guifg=#ae81ff
highlight elixirModuleDeclaration guifg=#f4bf75
highlight elixirAlias guifg=#fd971f
highlight elixirStringDelimiter guifg=#e6db74

" enable italic fonts in vim in fbpad
set t_ZH=�[3m
set t_Co=256

if $TERM !~ "dvtm"
    " enable truecolor support
    set termguicolors

    " set up colorizer
    lua require'colorizer'.setup()
endif

" set gitgutter symbol colors
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''
highlight GitGutterAdd    guifg=#a6e22e guibg=#3c3d37 ctermfg=2 ctermbg=237
highlight GitGutterChange guifg=#fd971f guibg=#3c3d37 ctermfg=3 ctermbg=237
highlight GitGutterDelete guifg=#f92672 guibg=#3c3d37 ctermfg=1 ctermbg=237

" rainbow parantheses config
let g:rainbow_active = 1

" display indicator before linewraps
set showbreak=>\ \ \

" enable highlighting of the current line
set cursorline

"----------------------------------------

" split config
set splitbelow splitright

" set the grep program to ripgrep
set grepprg=rg\ --vimgrep

" set leader to <space>
let mapleader = " "

" Restore last position when reopening file
au BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \ exe "normal! g'\"" |
          \ endif

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
nmap <silent><leader>bo :%bd\|e#\|bd#<cr>

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
nmap <leader>R :%s//gI<left><left><left>

" open netrw
nnoremap <leader>E :Explore<CR>
nnoremap <leader>L :30Lexplore<CR>

" open vifm
nnoremap <leader>V :Vifm<CR>

" create saner navigation bindings
autocmd filetype netrw nmap <buffer> h -
autocmd filetype netrw nmap <buffer> l <cr>
autocmd filetype netrw nmap <buffer> cd gn

" toggle vista
nmap <silent><leader>v :Vista!!<CR>

" start and stop MarkdownPreview
nmap <leader>mp :MarkdownPreview<CR>
nmap <leader>ms :MarkdownPreviewStop<CR>

" convert into markdown link
nnoremap <leader>ml :norm 0y$yss]A(<esc>p

" convert into vimwiki markdown link
function! Convert2Link() abort
    norm 0y$
    .s/ /_/g
    exec "norm
                \ guu
                \\"=expand('%:t:r')\<CR>Pa/\<esc>
                \I[\<C-r>0](\<C-o>A)"
endfunction

nnoremap <leader>mL :call Convert2Link()<CR>

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

" create an empty line above/below
nnoremap <A-o> o<Esc>k
nnoremap <A-O> O<Esc>j
inoremap <A-o> <C-o>o<C-o>k
inoremap <A-O> <C-o>O<C-o>j

" create a shortcut for taking the first correction
nnoremap <leader>z 1z=

" fix last spelling mistake
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
nmap <silent><leader>p :GFiles<CR>
nmap <silent><leader>P :Files<CR>
nmap <silent><leader>bb :Buffers<CR>
nmap <silent><leader>rg :Rg<CR>

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" vim-easy-align configuration
"" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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

nnoremap <silent><C-A-t> :10sp<CR>:terminal<CR>

" esc to exit terminal mode
tnoremap ° <C-\><C-n>

" remove a lot of clutter from terminal buffers
autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 norelativenumber nonumber
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

"
set ignorecase
set smartcase

" set caps lock to escape in vim
"au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" configure tabs
set expandtab
set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

autocmd FileType typescript*,javascript,json,css,html,markdown,sql
            \ setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Set maximum text width and spelling
if !exists('g:started_by_firenvim')
    autocmd FileType text,markdown,tex,mail setlocal textwidth=80 spell
endif

" enable comment highlighting in json
autocmd FileType json syntax match Comment +\/\/.\+$+

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc silent! !pkill -USR1 sxhkd
            \ && notify-send -t 1700 'reloaded sxhkd config'

" Update binds when xkeysnail is updated.
autocmd BufWritePost *xkeysnail/config.py silent! !killall xkeysnail;
            \ xkeysnail -q .config/xkeysnail/config.py 1>/dev/null &; disown
            \ && notify-send -t 1700 'reloaded xkeysnail config'

" enable search in vista
autocmd FileType vista,vista_kind nnoremap <buffer> <silent> /
            \ :<c-u>call vista#finder#fzf#Run()<CR>

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

" coc config
call coc#add_extension('coc-pairs', 'coc-marketplace', 'coc-texlab',  'coc-yank',
                     \ 'coc-prettier', 'coc-snippets', 'coc-html', 'coc-xml',
                     \ 'coc-yaml', 'coc-css', 'coc-python', 'coc-tsserver',
                     \ 'coc-json', 'coc-sql', 'coc-vimlsp',
                     \ 'coc-cssmodules', 'coc-diagnostic', 'coc-db', 'coc-rust-analyzer')
set hidden
set nobackup
set nowritebackup
set signcolumn=auto:4
set shortmess+=c
" set cmdheight=2
set updatetime=300
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
            \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd FileType vim,vifm let b:coc_pairs_disabled = ['"']

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

" function text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

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

"" Using CocFzfList
""" Show all diagnostics
nnoremap <silent><leader>cd  :<C-u>CocFzfList diagnostics<cr>
""" Manage extensions
nnoremap <silent><leader>ce  :<C-u>CocFzfList extensions<cr>
""" Show commands
nnoremap <silent><leader>cc  :<C-u>CocFzfList commands<cr>
""" Find symbol of current document
nnoremap <silent><leader>co  :<C-u>CocFzfList outline<cr>
""" Search workspace symbols
nnoremap <silent><leader>cs  :<C-u>CocFzfList -I symbols<cr>
""" Do default action for next item.
nnoremap <silent><leader>cj  :<C-u>CocNext<CR>
""" Do default action for previous item.
nnoremap <silent><leader>ck  :<C-u>CocPrev<CR>
""" Resume latest coc list
nnoremap <silent><leader>cr  :<C-u>CocFzfListResume<CR>

""" move preview window list to the right
let g:coc_fzf_preview='right:50%'

" autoremove trailing whitespaces
fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    if (index(['vimwiki','markdown'], &filetype) >= 0)
        return
    endif
    %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()

" closetag configuration
"" file extensions where this plugin is enabled
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js,*.tsx,*.ts"
"" make the list of non-closing tags self-closing in the specified files
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.tsx,*.ts'

" correct latex buffer filetype
let g:tex_flavor = "latex"

" markdown-preview config
let g:mkdp_browser = 'surf'

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

" firenvim configuration
if exists('g:started_by_firenvim')
    " turn off statusbar
    set laststatus=0
    " turn on spell checking
    set spell
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
            \ 'https?://.*twitch\.tv/.*': {
                \ 'takeover':'never'
            \ },
            \ 'https?://.*notion\.so/.*': {
                \ 'takeover':'never'
            \ },
        \ }
    \ }
    " Autowrite changes
    autocmd InsertLeave * ++nested write
    autocmd TextChanged * ++nested write
    " make shortcuts work as expected with xkeysnail
    inoremap <C-BS> <C-W>
    inoremap <TAB> <C-N>
    " set github and reddit filetype to markdown
    au BufEnter *github.com_*.txt,*reddit.com_*.txt set filetype=markdown
endif

" quick-scope configuration
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_buftype_blacklist = ['terminal']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" vimwiki configuration
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_root = '~/Nextcloud/Documents/vimwiki'
let g:vimwiki_list = [
            \{'path': '~/Nextcloud/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
            \{'path': '~/Nextcloud/Documents/vimwiki/uni', 'syntax': 'markdown', 'ext': '.md'},
            \{'path': '~/Nextcloud/Documents/vimwiki/uni/2020_spring_semester', 'syntax': 'markdown', 'ext': '.md'},
            \{'path': '~/Nextcloud/Documents/vimwiki/programming', 'syntax': 'markdown', 'ext': '.md'},
            \{'path': '~/Nextcloud/Documents/vimwiki/programming/elixir', 'syntax': 'markdown', 'ext': '.md'},
            \{'path': '~/Nextcloud/Documents/vimwiki/Todos', 'syntax': 'markdown', 'ext': '.md'},
            \]
au FileType vimwiki nmap <buffer> <C-H> <Plug>VimwikiGoBackLink
au FileType vimwiki nmap <buffer> <C-J> <Plug>VimwikiVSplitLink
au FileType vimwiki nmap <buffer> <C-N> <Plug>VimwikiNextLink
au FileType vimwiki nmap <buffer> <C-P> <Plug>VimwikiPrevLink
au FileType vimwiki set syntax=markdown
