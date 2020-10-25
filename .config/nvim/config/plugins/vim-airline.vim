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
