"===============================================================================
"                            C U S T O M   S T U F F
"===============================================================================

"-------------------- SETTINGS --------------------

set nocompatible
set nu rnu
set tabstop=2
set lazyredraw
set smartcase

syntax on
filetype plugin indent on

"------------------ NORMAL MODE -------------------
"edit local vimrc
nnoremap \ve :tabnew ~/.vim/vimrc<CR>

"reload local vimrc
nnoremap \vr :so ~/.vim/vimrc<CR>

"save and edit - detect syntax
nnoremap \e :w<CR>:e<CR>

"open file explorer
nnoremap \\ :32Lex!<CR>

"edit next <++> flag
nnoremap <Space><Space> /<++><CR>c4l

"resize buffer windows
nnoremap <c-up>			4<c-w>+
nnoremap <c-left>		4<c-w><
nnoremap <c-down>		4<c-w>-
nnoremap <c-right>	4<c-w>>

"toggle search highlight
nnoremap <silent><expr> <F4> (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

"------------------ VISUAL MODE -------------------
"surround hacky solution
vnoremap [" s""<ESC>P
vnoremap [' s''<ESC>P
vnoremap [( s()<ESC>P
vnoremap [[ s[]<ESC>P
vnoremap [{ s{}<ESC>P

"make a section label
vnoremap <c-t>l d:SectionLabel("<c-r>"")<CR>

"------------------ INSERT MODE -------------------
"autoclose brackets
inoremap ( ()<++><ESC>F(a
inoremap [ []<++><ESC>F[a
inoremap { {}<++><ESC>F{a

"----------------- ABBREVIATIONS ------------------
abbr #!s #!/bin/sh
abbr #!b #!/bin/bash

"-------------- FUNCTIONS & COMMANDS --------------

function SectionLabel(title)
	let title = ' ' . toupper(a:title) . ' '
	let line_len = 50
	let title_len = len(title)
	let first_line_len = (line_len - title_len)/2
	let second_line_len = first_line_len + (line_len - title_len) % 2
	return repeat('-', first_line_len) . title . repeat('-', second_line_len)
endfunction
command! -nargs=1 SectionLabel norm "=SectionLabel(<args>)<c-m>p

function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction
command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()

"===============================================================================

