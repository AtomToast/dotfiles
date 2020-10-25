" start and stop MarkdownPreview
let g:which_key_map.m = { 'name' : '+markdown | +make' }
autocmd FileType markdown,vimwiki nmap <buffer><leader>mp :MarkdownPreview<CR>
autocmd FileType markdown,vimwiki nmap <buffer><leader>ms :MarkdownPreviewStop<CR>

let g:mkdp_browser = 'surf'
