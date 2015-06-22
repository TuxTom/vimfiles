if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

fun! s:postAsJiraComment(...) range "{{{
  let s:commentText = ""
  for linenum in range(a:firstline, a:lastline)
    let s:commentText .= getline(linenum)
    let s:commentText .= "\r"
  endfor

  if(a:0 > 0 && a:1 != '')
    let s:issue = a:1
  else
    let s:issue = expand('%:t:r')
  endif

  let s:issue = substitute(s:issue, '.', '\u&', 'g')

  if(s:issue !~ '\u\+-\d\+')
    echoerr "Does not look like a valid issue id: " . s:issue
    return 1
  endif

  execute 'py from jira_functions import post_jira_comment; post_jira_comment(''' . g:jira_server . ''',''' . g:jira_username . ''',''' . g:jira_password . ''',''' . s:issue . ''',"""' s:commentText . '""")'
endfunction "}}}

command -buffer -nargs=? -range=% PostAsJiraComment <line1>,<line2>call s:postAsJiraComment("<args>")
