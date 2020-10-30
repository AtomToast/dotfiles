call which_key#register('<Space>', "g:which_key_map")
" mapleader also defined here to work with order of defined files
let mapleader = " "
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
set timeoutlen=500
let g:which_key_map = {}

