XPTemplate priority=personal

let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common
      \ _common/functions

XPTvar $CURSOR_PH 

XPTvar $CL    <!--
XPTvar $CM
XPTvar $CR      -->
XPTinclude
      \ _comment/doubleSign

" ================================= Snippets ===================================

XPT jira " {{JiraTicket|{{JIRA domain int}}|<Ticket-Id>}}...
XSET queue|pre=TRESOS
XSET queue|post=UpperCase( V() )
XSET summary=getJiraSummary( R( 'queue' ), R( 'id' ) )
{{JiraTicket|{{JIRA domain int}}|`queue^-`id^}} - `summary^
..XPT