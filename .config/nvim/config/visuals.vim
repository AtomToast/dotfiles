" hide classic mode display
set noshowmode

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
endif

" display indicator before linewraps
set showbreak=>\ \ \

" enable highlighting of the current line
set cursorline

" disable status line
set laststatus=1

" split config
set splitbelow splitright

" enable relative numbers
set number relativenumber

" configure tabs
set smartindent
" Indenting defaults (does not override vim-sleuth's indenting detection)
" Defaults to 4 spaces for most filetypes
if get(g:, '_has_set_default_indent_settings', 0) == 0
  " Set the indenting level to 2 spaces for the following file types.
  autocmd FileType typescript,javascript,jsx,tsx,css,html,ruby,elixir,kotlin,sql,haskell,vim,markdown,vimwiki
        \ setlocal expandtab tabstop=2 shiftwidth=2
  set expandtab
  set tabstop=4
  set shiftwidth=4
  let g:_has_set_default_indent_settings = 1
endif
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

" Set maximum text width and spelling
if !exists('g:started_by_firenvim')
    autocmd FileType text,markdown,tex,mail setlocal textwidth=79 spell
    autocmd FileType python setlocal textwidth=79
endif

" enable comment highlighting in json
autocmd FileType json syntax match Comment +\/\/.\+$+

" set filetype of .S files to asm
autocmd BufRead,BufNewFile *.S set filetype=asm

" highlight yanks
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END
