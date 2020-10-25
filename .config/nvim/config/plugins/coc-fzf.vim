" move preview window list to the right
let g:coc_fzf_preview='right:50%'

" keybinds
let g:which_key_map.c = { 'name' : '+CocList | +qf_list' }
"" Show all diagnostics
nnoremap <silent><leader>cd  :<C-u>CocFzfList diagnostics<cr>
"" Manage extensions
nnoremap <silent><leader>ce  :<C-u>CocFzfList extensions<cr>
"" Show commands
nnoremap <silent><leader>cc  :<C-u>CocFzfList commands<cr>
"" Find symbol of current document
nnoremap <silent><leader>co  :<C-u>CocFzfList outline<cr>
"" Search workspace symbols
nnoremap <silent><leader>cs  :<C-u>CocFzfList -I symbols<cr>
"" Resume last list
nnoremap <silent><leader>cr  :<C-u>CocFzfListResume<CR>
