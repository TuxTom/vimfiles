" Script to detect file types

if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile *.xml      call s:CustomFTxml()
  au! BufRead,BufNewFile *.arxml    set filetype=arxml
  au! BufRead,BufNewFile *.ddl      set filetype=sql
  au! BufRead,BufNewFile *.jet      set filetype=jet
  au! BufRead,BufNewFile *.xrl      set filetype=xrl
  au! BufRead,BufNewFile *.cwiki    set filetype=confluencewiki
augroup END

func! s:CustomFTxml()
  let n = 1
  while n < 100 && n < line("$")
    let line = getline(n)
    if line =~ '^\s*<project'
      set filetype=ant
      return
    endif
    if line =~ '^\s*<requirements'
      set filetype=reqmgr
      return
    endif
    if line =~ '^\s*<AUTOSAR'
      set filetype=arxml
      return
    endif
    if line =~ '^\s*<releasenotes'
      set filetype=xrl
      return
    endif
    if line =~ '^\s*<sect\d'
      set filetype=docbk
      return
    endif
    let n += 1
  endwhile
endfunction
