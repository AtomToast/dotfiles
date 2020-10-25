" toggle vista
nmap <silent><leader>v :Vista!!<CR>

" enable search in vista
autocmd FileType vista,vista_kind nnoremap <buffer> <silent> /
      \ :<c-u>call vista#finder#fzf#Run()<CR>

