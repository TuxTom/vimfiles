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

XPTvar $JIRA_ADDR https://issue.ebgroup.elektrobit.com/browse/
XPTvar $HELPDESK_ADDR http://deeras12/helpdesk/scripts/main.asp
XPTvar $WIKI_ADDR H:/vimwiki/

" ========================= Function and Variables =============================

fun! s:f.vimwikiBulletIfNoneYet()
  return getline(".") =~ '^\s*\*' ? "" : "* " 
endfunction

fun! s:f.vimwikiTodoItemIfNoneYet()
  let line = getline(".")
  if line !~ '^\s*\*'
    " line does not start with bullet
    return "* [ ] "
  elseif line !~ '^\s*\*\s\+\[\s\?\]'
    " bullet found but no checkbox
    return "[ ] "
  endif
  return ""
endfunction

" fun! s:f.getRelPath(target)
  " let basepath = expand('%:p:h')
  " let result = ""
  " while basepath != ""
    " if(stridx(target, basepath) == 0)
      
    " endif
  " endwhile
  " let cwd = getcwd()
  " try
    " cd %:p:h
    " let result = fnamemodify(a:target, ':.')
  " finally
    " exec "cd " . cwd
  " endtry
  " return result
" endfunction

" ================================= Snippets ===================================

XPT jira " $JIRA_ADDR...
XSET queue|pre=TRESOS
XSET queue|post=UpperCase( V() )
XSET summary=getJiraSummary( R( 'queue' ), R( 'id' ) )
`$JIRA_ADDR^`queue^-`id^ - `summary^
..XPT

XPT jira_ticket hidden " Echo($JIRA_ADDR . UpperCase($_xSnipName) . "-...")
XSET summary=getJiraSummary( UpperCase(_xSnipName()), R( 'id' ) )
`$JIRA_ADDR^`UpperCase(_xSnipName())^-`id^ - `summary^
..XPT

XPT tresos alias=jira_ticket
XPT tresoswp alias=jira_ticket
XPT toolbuildenv alias=jira_ticket

XPT task " * `task^ `jira^<ticket-id> [ | * [ ] item ]...
XSET task|def=Choose(['implement', 'review', 'analyze', 'design', 'document'])
`vimwikiTodoItemIfNoneYet()^`task^ `:jira:^
    `item...^* [ ] `item^
    `item...^
..XPT

XPT helpdesk " Echo($HELPDESK_ADDR . "?ticketid=...")
`$HELPDESK_ADDR^?ticketid=`ticketid^
..XPT

XPT review " Echo("[[Review_<TICKET-ID>][Review " . $JIRA_ADDR . "<TICKET-ID> - <Description>]]")
XSET queue|pre=TRESOS
XSET queue|post=UpperCase( V() )
XSET path|pre=../Misc/
[[`path^Review_`queue^-`id^][Review `:jira:^]]
..XPT
