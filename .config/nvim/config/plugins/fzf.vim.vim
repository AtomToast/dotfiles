" configure fzf
nmap <silent><leader>p :GFiles<CR>
nmap <silent><leader>P :Files<CR>
nmap <silent><leader>bb :Buffers<CR>
nmap <silent><leader>bl :BLines<CR>
nmap <silent><leader>rg :Rg<CR>

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

