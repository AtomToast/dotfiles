" symbols and colors
let g:signify_sign_add = ''
let g:signify_sign_change = ''
let g:signify_sign_delete = ''
let g:signify_sign_delete_first_line = ''
highlight SignifySignAdd    guifg=#a6e22e guibg=#2D2E27 ctermfg=2 ctermbg=237
highlight SignifySignChange guifg=#fd971f guibg=#2D2E27 ctermfg=3 ctermbg=237
highlight SignifySignDelete guifg=#f92672 guibg=#2D2E27 ctermfg=1 ctermbg=237

let g:signify_priority = 5

" keybinds
let g:which_key_map.h = { 'name' : '+gitgutter_hunks' }
nmap <leader>hj <Plug>(signify-next-hunk)
nmap <leader>hk <Plug>(signify-prev-hunk)
nmap <leader>hp :SignifyHunkDiff<cr>
nmap <leader>hu :SignifyHunkUndo<cr>

omap ih <plug>(signify-motion-inner-pending)
xmap ih <plug>(signify-motion-inner-visual)
omap ah <plug>(signify-motion-outer-pending)
xmap ah <plug>(signify-motion-outer-visual)
