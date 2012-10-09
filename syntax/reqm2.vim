if exists("b:current_syntax")
  finish
endif

doau Syntax docbk

syn keyword docbkKeyword comment conflicts conflictswith creationdate defaults dependencies dependson contained
syn keyword docbkKeyword description dstversion furtherinfo id idprefix link links linksto needscoverage contained
syn keyword docbkKeyword needsobj priority provcov providescoverage rationale release releases safetyclass contained
syn keyword docbkKeyword safetyrationale shortdesc source sourcefile sourceline specdocument specobject contained
syn keyword docbkKeyword specobjects status target testexec testin testout testpasscrit usecase verifycrit contained
syn keyword docbkKeyword version contained

syn region docbkRegion start="<linksto>"lc=9 end="</linksto>"me=e-10 contains=xmlRegion,xmlEntity,sgmlRegion,sgmlEntity keepend
syn region docbkRegion start="<id>"lc=4 end="</id>"me=e-5 contains=xmlRegion,xmlEntity,sgmlRegion,sgmlEntity keepend
syn region docbkRegion start="<idprefix>"lc=10 end="</idprefix>"me=e-11 contains=xmlRegion,xmlEntity,sgmlRegion,sgmlEntity keepend

let b:current_syntax = "reqm2"
