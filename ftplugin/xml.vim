if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

syntax sync maxlines=1
setlocal synmaxcol=2000

let g:xml_syntax_folding = 1

let s:fsize = getfsize(expand("<afile>"))
if(s:fsize>0 && s:fsize<10485760)
  setlocal foldmethod=syntax
  setlocal foldlevel=3
endif

setlocal omnifunc=xmlcomplete#CompleteTags
