if exists("b:current_syntax")
  finish
endif

doau Syntax docbk

syn keyword docbkKeyword entry summary description workaround rationale contained

let b:current_syntax = "xrl"
