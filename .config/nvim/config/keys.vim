" set leader to <space>
let mapleader = " "

" make typos less annoying
cnoreabbrev Q q
cnoreabbrev W w
nnoremap Q <NOP>

" remove an annoying binding, make reformatting current block nicer
nnoremap gQ vipJgqq

" create a shorter way of ending emails
autocmd FileType mail inoreabbrev mfg Mit freundlichen Grüßen,<CR>Kjell Hoffhenke
autocmd FileType mail inoreabbrev br Best Regards,<CR>Kjell Hoffhenke

" remove search highlighting shortcut
nmap <leader>s :nohlsearch<CR>

" toggle spelling
nmap <leader>S :setlocal spell!<CR>

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
nmap <leader>mb :Make build<CR>
nmap <leader>mr :Make run<CR>
nmap <leader>mi :!sudo make install <CR>

" temp fix for flutter
autocmd FileType dart nnoremap <leader>mr :FlutterRun -d linux<CR>
autocmd FileType dart nnoremap <leader>mq :FlutterQuit<CR>

" edit new file under cursor
nnoremap <leader>gf :e <cfile><CR>

" ctrl+s saving
noremap  <silent> <C-S> <cmd>update<CR><cmd>nohlsearch<CR>
vnoremap <silent> <C-S> <cmd>update<CR><cmd>nohlsearch<CR>
inoremap <silent> <C-S> <cmd>update<CR><cmd>nohlsearch<CR>

" make ctrl+alt+arrows resize splits
nnoremap <silent><C-A-Up>    <cmd>resize +2<CR>
nnoremap <silent><C-A-Down>  <cmd>resize -2<CR>
nnoremap <silent><C-A-Left>  <cmd>vertical resize +2<CR>
nnoremap <silent><C-A-Right> <cmd>vertical resize -2<CR>
tnoremap <silent><C-A-Up>    <cmd>resize +2<CR>
tnoremap <silent><C-A-Down>  <cmd>resize -2<CR>
tnoremap <silent><C-A-Left>  <cmd>vertical resize +2<CR>
tnoremap <silent><C-A-Right> <cmd>vertical resize -2<CR>

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

" replace and delete without copying the selection
vnoremap <leader>p "_dP
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" switch windows in any mode with alt + hjkl and alt + arrow keys
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
tnoremap <A-Left> <C-\><C-N><C-w>h
tnoremap <A-Down> <C-\><C-N><C-w>j
tnoremap <A-Up> <C-\><C-N><C-w>k
tnoremap <A-Right> <C-\><C-N><C-w>l
inoremap <A-Left> <C-\><C-N><C-w>h
inoremap <A-Down> <C-\><C-N><C-w>j
inoremap <A-Up> <C-\><C-N><C-w>k
inoremap <A-Right> <C-\><C-N><C-w>l
nnoremap <A-Left> <C-w>h
nnoremap <A-Down> <C-w>j
nnoremap <A-Up> <C-w>k
nnoremap <A-Right> <C-w>l

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

