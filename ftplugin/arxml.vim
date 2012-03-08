if exists("b:did_ftplugin")
  finish
endif
" Don't set 'b:did_ftplugin = 1' because that is xml.vim's responsability.

" Just load the stuff for xml
runtime ftplugin/xml.vim

if has("folding")
  set foldtext=ArxmlFoldText()
  function! ArxmlFoldText()
    if &fdm=='diff'
      return foldtext()
    endif

    let foldtext = matchstr( getline( v:foldstart ), '\s*<[-A-Z]\+>' )
    let shortname = matchstr( getline( v:foldstart + 1 ), '<SHORT-NAME>\zs[-A-Za-z0-9]\+\ze<\/SHORT-NAME>' )
    if( shortname != "" )
      echomsg "Short name found: " . shortname
      let foldtext .= ' "' . shortname . '"'
      echomsg "New foldtext: " . foldtext
    endif
    let foldtext .= ' (' . ( v:foldend-v:foldstart ) . ' lines) '
    let linelength = winwidth(0) - &foldcolumn
    if( &number || &relativenumber )
      let linelength -= &numberwidth
    endif
    let foldtext = strpart( foldtext, 0, linelength )

    return foldtext
  endfunction
endif
