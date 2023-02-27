let g:which_key_map.w = { 'name': '+vimwiki' }
let g:which_key_map.w[' '] = { 'name': '+diary' }
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" let g:vimwiki_filetypes = ['markdown']
let g:vimwiki_root = '~/Nextcloud/Documents/vimwiki'
" let g:vimwiki_auto_header = 1
let g:vimwiki_listsyms = ' .oOx'
let g:vimwiki_auto_chdir = 1
let g:vimwiki_list = [
      \{'path': '~/Nextcloud/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md', 'auto_diary_index': 1, 'auto_tags': 1, 'auto_generate_tags': 1, 'links_space_char': '_',},
      \]
au FileType vimwiki nmap <buffer> <C-H> <Plug>VimwikiGoBackLink
au FileType vimwiki nmap <buffer> <C-J> <Plug>VimwikiVSplitLink
au FileType vimwiki nmap <buffer> <C-N> <Plug>VimwikiNextLink
au FileType vimwiki nmap <buffer> <C-P> <Plug>VimwikiPrevLink
au FileType vimwiki nmap <buffer> <A-s> :VimwikiSearchTags<space>
" au FileType vimwiki set syntax=vimwiki
au FileType vimwiki syntax on
au FileType vimwiki set syntax=markdown " perhaps make this conditional on file extension
au FileType vimwiki set nowrap

