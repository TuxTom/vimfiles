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
XSET summary=getJiraSummary(R('queue'), R('id'))
{{JiraTicket|{{JIRA domain int}}|`queue^-`id^}} - `id^getJiraSummary(R('queue'), R('id'))^
..XPT

XPT reviewprotocol " -- Review Protocol v2.0 --
XSET ticket|pre=expand( '%:t:r' )
XSET ticket|post=UpperCase( V() )
------------------------------------------------------------------------
Review Protocol v2.0
------------------------------------------------------------------------
Reviewer: `$author^
------------------------------------------------------------------------
Date:     `strftime("%Y-%m-%d %H:%M")^
------------------------------------------------------------------------
Ticket:   `ticket^
------------------------------------------------------------------------
A) Comments:
# `cursor^

------------------------------------------------------------------------
B) To be fixed/explained by developer:
# 

------------------------------------------------------------------------
C) Already fixed by reviewer:
# 

------------------------------------------------------------------------
Result:   REVIEW OK | FIX NEEDED | RE-REVIEW NEEDED
------------------------------------------------------------------------
..XPT
