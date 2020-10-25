" hide banner
let g:netrw_banner=0

" show previews on the right
let g:netrw_preview=1
let g:netrw_alto=0

" window size
let g:netrw_winsize=30

" opens in tree view by default
let g:netrw_liststyle=3

" hide dotfiles by default
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

" opening keybinds
nnoremap <leader>E :Explore<CR>
nnoremap <leader>L :30Lexplore<CR>

" saner navigation bindings
autocmd filetype netrw nmap <buffer> h -
autocmd filetype netrw nmap <buffer> l <cr>
autocmd filetype netrw nmap <buffer> cd gn
