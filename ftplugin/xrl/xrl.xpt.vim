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

fun! s:f.BuildIfNotEmpty() 
  if( self.V() != "..." )
    return {'action' : 'expandTmpl', 'tmplName' : self.V()}
  else
    return ''
  endif
endfunction

" ================================= Snippets ===================================

XPT entry " <entry id="...">...</entry>
<entry id="`id^">`
    `:summary:^
    `:description:^`
    `additionalTag?^
</entry>
..XPT

XPT summary " <summary>...</summary>
<summary>`summary^</summary>
..XPT

XPT description " <description>...</description>
<description>`description^</description>
..XPT

XPT workaround " <workaround>...</workaround>
<workaround>`workaround^</workaround>
..XPT

XPT rationale " <rationale>...</rationale>
<rationale>`rationale^</rationale>
..XPT
