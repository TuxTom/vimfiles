XPTemplate priority=personal

let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common
      \ xml/xml



XPTvar $CURSOR_PH 

XPTvar $CL    <!--
XPTvar $CM
XPTvar $CR      -->
XPTinclude
      \ _comment/doubleSign

" ========================= Function and Variables =============================

" fun! s:f.InsertReqDefSnippet()
  " let snippetName = self.V0()
  " let [ ml, mr ] = XPTmark()
  " return ml . ":" . snippetName . ":" . mr
" endfunction

" ================================= Snippets ===================================

XPT requirements " <requirements ...></requirements>
<requirements fields="coverage,status,source,refinereq,linkreq,release,rationale"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://www.tresos.de/reqmgrng-1.0.xsd">

    <reqdefBaseID reqid="`baseId^"/>

    <reqdefDefaults>
        `:coverage:^
        `:release:^
        `:status:^
        `:source:^
    </reqdefDefaults>

    `cursor^
</requirements>
..XPT

" XPT reqd " <reqdef...></reqdef>
" XSET item|def=Choose(['coverage','release','status','source','refinereq','linkreq'], 0)
" XSET item|post=InsertReqDefSnippet()
" <reqdef reqid="`id^">`
    " `items...^
    " `item^`
    " `items...^
    " <desc>
        " `description^
    " </desc>
" </reqdef>
" ..XPT

XPT reqdef " <reqdef reqid="...">...</reqdef>
<reqdef reqid="`id^">`
    `coverage...{{^
    `:coverage:^`}}^`
    `release...{{^
    `:release:^`}}^`
    `status...{{^
    `:status:^`}}^`
    `source...{{^
    `:source:^`}}^`
    `refinereq...{{^
    `:refinereq:^`}}^`
    `linkreq...{{^
    `:linkreq:^`}}^
    `:description:^`
    `rationale...{{^
    `:rationale:^`}}^
</reqdef>
..XPT

XPT coverage " <coverage>...</coverage>
XSET coverage|def=Choose(['TEST','SRC','INFORMAL'], 0)
<coverage>`coverage^</coverage>
..XPT

XPT release " <release>...</release>
<release>`release^</release>
..XPT

XPT status " <status>...</status>
XSET status|def=Choose(['new','approved','implemented','rejected','not_applicable'], 0)
<status>`status^</status>
..XPT

XPT source " <source>$author</source>
<source>`$author^</source>
..XPT

XPT refinereq " <refinereq>...</refinereq>
<refinereq>`reqId^</refinereq>
..XPT

XPT linkreq " <linkreq>...</linkreq>
<linkreq>`reqId^</linkreq>
..XPT

XPT description " <desc>...</desc>
<desc>
    `description^
</desc>
..XPT

XPT rationale " <rationale>...</rationale>
<rationale>
    `rationale^
</rationale>
..XPT
