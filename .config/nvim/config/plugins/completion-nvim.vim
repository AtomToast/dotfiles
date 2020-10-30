" lua require'nvim_lsp'.pyls.setup{on_attach=require'completion'.on_attach}
" lua require'nvim_lsp'.vimls.setup{on_attach=require'completion'.on_attach}
" lua require'nvim_lsp'.hls.setup{on_attach=require'completion'.on_attach}
" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

set completeopt=menuone,noinsert,noselect
set shortmess+=c

imap <silent> <c-n> <Plug>(completion_trigger)
