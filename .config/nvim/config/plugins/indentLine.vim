let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_char = '|'
"let g:indentLine_setConceal = 0
let g:indentLine_concealcursor="inc"
" disable concealcursor in normal and insert mode in vimwiki and markdown
" files
autocmd FileType markdown,vimwiki,json let g:indentLine_concealcursor="c"
let g:indentLine_faster = 1
let g:indentLine_bufTypeExclude = ["help", "terminal"]
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_color_gui = '#575B61'
set list lcs=tab:\|·,trail:·
