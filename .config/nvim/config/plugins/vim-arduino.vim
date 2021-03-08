let g:arduino_serial_cmd = 'picocom {port} -b {baud} -l'

nnoremap <leader>mam :ArduinoVerify<CR>
nnoremap <leader>mau :ArduinoUpload<CR>
nnoremap <leader>mad :ArduinoUploadAndSerial<CR>
nnoremap <leader>mab :ArduinoChooseBoard<CR>
nnoremap <leader>map :ArduinoChooseProgrammer<CR>

" my_file.ino [arduino:avr:uno] [arduino:usbtinyisp] (/dev/ttyACM0:9600)
function! MyStatusLine()
  let port = arduino#GetPort()
  let line = 'arduino [' . g:arduino_board . '] [' . g:arduino_programmer . ']'
  if !empty(port)
    let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
  endif
  return line
endfunction

autocmd BufNewFile,BufRead *.ino let g:airline_section_x='%{MyStatusLine()}'
