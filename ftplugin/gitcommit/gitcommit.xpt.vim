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
`queue^-`id^ - `id^substitute(getJiraSummary(R('queue'), R('id')), '\(\u\+\)-\(\d\+\)', '\1 - \2', 'g')^
`cursor^
..XPT

XPT jira_ticket hidden " Echo(UpperCase($_xSnipName) . " - <summary>")
`UpperCase(_xSnipName())^-`id^ - `id^substitute(getJiraSummary(UpperCase(_xSnipName()), R('id')), '\(\u\+\)-\(\d\+\)', '\1 - \2', 'g')^
`cursor^
..XPT

XPT tresos alias=jira_ticket synonym=TRESOS
XPT tresoswp alias=jira_ticket synonym=TRESOSWP
