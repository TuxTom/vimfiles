if exists("b:did_ftplugin")
  finish
endif
" Don't set 'b:did_ftplugin = 1' because that is xml.vim's responsability.

" Just load the stuff for xml
runtime! ftplugin/xml.vim

setlocal omnifunc=htmlcomplete#CompleteTags
