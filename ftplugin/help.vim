function! OpenHelpInRightSplit()
  let windowwidth = &tw

  if(&number)
    let windowwidth += &numberwidth
  endif

  let windowwidth += &foldcolumn

  " One character right border
  let windowwidth += 1

  wincmd L
  execute "vertical resize " . windowwidth
endf

setlocal nonumber
setlocal foldcolumn=1

augroup help
  au!
  au BufWinEnter <buffer> call OpenHelpInRightSplit()
augroup END

" jump to next link
nmap <buffer> <Tab> /\|\S\+\|<CR>:nohlsearch<CR>l

" jump to previous link
nmap <buffer> <S-Tab> h?\|\S\+\|<CR>:nohlsearch<CR>l

" follow link with <CR>
nmap <buffer> <CR> <C-]>

" go back with backspace
nmap <buffer> <BS> <C-O>
