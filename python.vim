"Set <F9> to run code in normal mode
au FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
"Set <F9> to run code in insert mode
au FileType python imap <buffer> <F9> <ESC>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

