" set leader to <space>
let mapleader = " "

" make typos less annoying
cnoreabbrev Q q
cnoreabbrev W w
nnoremap Q <NOP>

" remove search highlighting shortcut
nmap <leader>s :nohlsearch<CR>

" toggle spelling
nmap <leader>S :setlocal spell!<CR>

" buffer shortcuts
let g:which_key_map.b = { 'name' : '+buffer' }
let g:which_key_map.b.n = 'switch to next buffer'
nmap <silent><leader>bn :bnext<CR>
let g:which_key_map.b.p = 'switch to previous buffer'
nmap <silent><leader>bp :bprevious<CR>
let g:which_key_map.b.d = 'deletes current buffer'
nmap <silent><leader>bd :bdelete<CR>
let g:which_key_map.b.a = 'adds new buffer'
nmap <silent><leader>ba :enew <BAR> :Files<CR>
let g:which_key_map.b.q = 'closes current buffer'
nmap <silent><leader>bq :bp <BAR> bd #<CR>
let g:which_key_map.b.o = 'close all but the current buffer'
nmap <silent><leader>bo :%bd\|e#\|bd#<cr>

" quickfix list shortcuts
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>
nnoremap <leader>cl :copen<CR>
" local quickfix list shortcuts
let g:which_key_map.l = { 'name' : '+local_qf_list' }
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>
nnoremap <leader>ll :lopen<CR>

" search and replace shortcut
let g:which_key_map.R = 'global search and replace'
nmap <leader>R :%s//gI<left><left><left>
vmap <leader>R :s//gI<left><left><left>

" call make with a shortcut
nmap <leader>mm :Make<CR>
nmap <leader>mc :Make clean<CR>
nmap <leader>mi :!sudo make install <CR>

" ctrl+s saving
noremap  <silent> <C-S> :update<CR>:nohlsearch<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>:nohlsearch<CR>
inoremap <silent> <C-S> <C-O>:update<CR><C-O>:nohlsearch<CR>

" make arrows resize splits
nnoremap <silent><A-Up>    :resize +2<CR>
nnoremap <silent><A-Down>  :resize -2<CR>
nnoremap <silent><A-Left>  :vertical resize +2<CR>
nnoremap <silent><A-Right> :vertical resize -2<CR>

" shortcut for entering semicolon at the end of the line
inoremap <A-;> <Esc>mbA;<Esc>`ba
nnoremap <A-;> mbA;<Esc>`b

" make j and k behave like gj and gk
nnoremap j gj
nnoremap k gk

" create a shortcut for taking the first correction
let g:which_key_map.z = 'apply first spelling suggestion'
nnoremap <leader>z 1z=

" fix last spelling mistake
let g:which_key_map.Z = 'fix spelling of last word'
nnoremap <leader>Z [s1z=

" remap Y to work like other captial letters
nnoremap Y y$

" switch windows in any mode with ctrl + alt + hjkl
tnoremap <C-A-h> <C-\><C-N><C-w>h
tnoremap <C-A-j> <C-\><C-N><C-w>j
tnoremap <C-A-k> <C-\><C-N><C-w>k
tnoremap <C-A-l> <C-\><C-N><C-w>l
inoremap <C-A-h> <C-\><C-N><C-w>h
inoremap <C-A-j> <C-\><C-N><C-w>j
inoremap <C-A-k> <C-\><C-N><C-w>k
inoremap <C-A-l> <C-\><C-N><C-w>l
nnoremap <C-A-h> <C-w>h
nnoremap <C-A-j> <C-w>j
nnoremap <C-A-k> <C-w>k
nnoremap <C-A-l> <C-w>l

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader>F :ZoomToggle<CR>

" open/switch to terminal split
nnoremap <silent><leader>t :call OpenTerminalSplit()<CR>

" <C-s> to exit terminal mode
tnoremap <C-s> <C-\><C-n>

fun! OpenTerminalSplit()
  let l:buf = GetTerminalBuf()
  if l:buf == -1
    10sp
    terminal
    let g:terminal_job_id = b:terminal_job_id
  else
    let l:win = GetBufWin(l:buf)
    call nvim_set_current_win(l:win)
  endif
endfun

fun! GetTerminalBuf()
  for l:buf in nvim_list_bufs()
    if nvim_buf_is_loaded(buf)
      let l:name = nvim_buf_get_name(buf)
      if l:name =~ ".*term.*"
        return buf
      endif
    endif
  endfor
  return -1
endfun

fun! GetBufWin(buf)
  for l:win in nvim_list_wins()
    if a:buf == nvim_win_get_buf(l:win)
      return l:win
    endif
  endfor
endfun

