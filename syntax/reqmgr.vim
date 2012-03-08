if exists("b:current_syntax")
  finish
endif

doau Syntax docbk

syn keyword docbkKeyword coverage desc linkreq rationale refinereq release requirements contained
syn keyword docbkKeyword reqdef reqdefBaseID reqdefDefaults source status contained

let b:current_syntax = "reqmgr"
