XPTemplate priority=personal

let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common
      \ _common/functions

XPTvar $CURSOR_PH 

XPTvar $CS #
XPTinclude
      \ _comment/doubleSign

XPT jira " <Ticket-Id> - <summary>
XSET queue|pre=TRESOS
XSET queue|post=UpperCase( V() )
XSET summary=getJiraSummary( R( 'queue' ), R( 'id' ) )
`queue^-`id^ - `summary^
`cursor^
..XPT

XPT jira_ticket hidden " Echo(UpperCase($_xSnipName) . " - <summary>")
XSET summary=getJiraSummary( UpperCase(_xSnipName()), R( 'id' ) )
`UpperCase(_xSnipName())^-`id^ - `summary^
`cursor^
..XPT

XPT tresos alias=jira_ticket
XPT tresoswp alias=jira_ticket
