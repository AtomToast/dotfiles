" symbols and colors
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''
highlight GitGutterAdd    guifg=#a6e22e guibg=#2D2E27 ctermfg=2 ctermbg=237
highlight GitGutterChange guifg=#fd971f guibg=#2D2E27 ctermfg=3 ctermbg=237
highlight GitGutterDelete guifg=#f92672 guibg=#2D2E27 ctermfg=1 ctermbg=237

" keybinds
let g:which_key_map.h = { 'name' : '+gitgutter_hunks' }
nmap <leader>hj <Plug>(GitGutterNextHunk)
nmap <leader>hk <Plug>(GitGutterPrevHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)

