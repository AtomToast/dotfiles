call coc#add_extension('coc-marketplace', 'coc-texlab',
                     \ 'coc-prettier', 'coc-snippets', 'coc-html', 'coc-xml',
                     \ 'coc-yaml', 'coc-css', 'coc-pyright', 'coc-tsserver',
                     \ 'coc-json', 'coc-sql', 'coc-vimlsp',
                     \ 'coc-cssmodules', 'coc-diagnostic', 'coc-db', 'coc-rust-analyzer')
set hidden
set nobackup
set nowritebackup
set signcolumn=auto:4
set shortmess+=c
set updatetime=100
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <c-n> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Format selected content
vmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)

" function text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" Remap for rename current word
let g:which_key_map.r = { 'name' : '+ripgrep | +rename' }
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Fix autofix problem of current line
let g:which_key_map.q = { 'name' : '+apply_quickfix' }
nmap <leader>qf  <Plug>(coc-fix-current)

" associate (v)hdl files with nand2tetris hack_hdl
let g:coc_filetype_map = {
      \'vhdl': 'hack_hdl',
      \'hdl': 'hack_hdl',
      \ }

