" Vim syntax file
" Language:	JET (Java Emitter Templates)

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'jet'
endif

" Source Java syntax
if version < 600
  source <sfile>:p:h/java.vim
else
  runtime! syntax/java.vim
endif
unlet b:current_syntax

" Next syntax items are case-sensitive
syn case match

" Include Java syntax again (nested)
syn include @jetJava syntax/java.vim

syn region jetScriptlet matchgroup=jetTag start=/<%/  keepend end=/%>/ contains=@jetJava
syn region jetDecl	matchgroup=jetTag start=/<%!/ keepend end=/%>/ contains=@jetJava
syn region jetExpr	matchgroup=jetTag start=/<%=/ keepend end=/%>/ contains=@jetJava
syn region jetDirective			  start=/<%@/	      end=/%>/ contains=htmlString,jetDirName,jetDirArg

syn keyword jetDirName contained jet include page taglib
syn keyword jetDirArg contained package imports 
syn keyword jetDirArg contained file uri prefix language extends import session buffer autoFlush
syn keyword jetDirArg contained isThreadSafe info errorPage contentType isErrorPage

hi def link jetTag htmlTag
hi def link jetDirective	 jetTag
hi def link jetDirName	 htmlTagName
hi def link jetDirArg	 htmlArg

if main_syntax == 'jet'
  unlet main_syntax
endif

let b:current_syntax = "jet"

" vim: ts=8
