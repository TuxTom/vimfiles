XPTemplate priority=personal

let s:f = g:XPTfuncs()

fun! s:f.getJiraSummary(queue, id)
  if a:queue == "" || a:id == ""
    return
  endif

  " echomsg  g:jira_cmdline_app . " -s " . g:jira_server . " -u " . g:jira_username . " -p " . g:jira_password . " -a getFieldValue --field Summary --issue " . a:queue . "-" . a:id 
  let result = system( g:jira_cmdline_app . " -s " . g:jira_server . " -u " . g:jira_username . " -p " . g:jira_password . " -a getFieldValue --field Summary --issue " . a:queue . "-" . a:id )
  " echo "result: " . result
  if v:shell_error
    echoerr "error: " . v:shell_error
    return
  endif

  " split into lines
  let lines = split( result, '\n' )

  " remove the first line "Issue xxx has field 'Summary' with value"
  if len( lines ) > 1
    call remove( lines, 0 )
    return substitute( join( lines, "\n" ), '\s\+$', '', '' )
  endif
endfunction

