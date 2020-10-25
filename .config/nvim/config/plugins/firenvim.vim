if exists('g:started_by_firenvim')
  " turn off statusbar
  set laststatus=0
  " turn on spell checking
  set spell
  " disable tabline
  let g:airline#extensions#tabline#enabled = 0
  " disable signcolumn
  set signcolumn=no
  " disable numbers
  set norelativenumber nonumber
  " add shortcut for focusing the page
  nnoremap <silent><Esc><Esc> :call firenvim#focus_page()<CR>
  " add shortcut for hiding the frame
  nnoremap <silent><C-z> :call firenvim#hide_frame()<CR>
  " use external commandline for firenvim
  let g:firenvim_config = {
    \ 'localSettings': {
      \ '.*': {
        \ 'cmdline': 'firenvim',
      \ },
      \ 'https?://.*twitch\.tv/.*': {
        \ 'takeover':'never'
      \ },
      \ 'https?://.*notion\.so/.*': {
        \ 'takeover':'never'
      \ },
    \ }
  \ }
  " Autowrite changes
  autocmd InsertLeave * ++nested write
  autocmd TextChanged * ++nested write
  " make shortcuts work as expected with xkeysnail
  inoremap <C-BS> <C-W>
  inoremap <TAB> <C-N>
  " set github and reddit filetype to markdown
  au BufEnter *github.com_*.txt,*reddit.com_*.txt set filetype=markdown
endif
