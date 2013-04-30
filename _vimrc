" vim: set foldmethod=marker foldlevel=0 :

" Only load the settings once
if(exists("g:loaded_vimrc_thkl2944"))
  finish
endif
let g:loaded_vimrc_thkl2944 = 1

nmap <Leader>ve :e $MYVIMRC<CR>
nmap <Leader>vs :unlet g:loaded_vimrc_thkl2944<CR>:source $MYVIMRC<CR>

" general options {{{
set autoindent
set backspace=eol,start,indent
set completeopt=menuone,preview
set confirm
set diffopt=filler,iwhite,vertical
set display=lastline
set encoding=utf-8
set expandtab
set fileformats=unix,dos
set foldcolumn=5
" set foldlevelstart=2
set formatoptions+=roq
set formatoptions-=tc
set helplang=en
set hidden
set incsearch
set iskeyword+=-
set laststatus=2
set linebreak
set linespace=0
set nocscopetag
set hlsearch
set noignorecase
set number
set numberwidth=4
set scrolloff=3
set shiftwidth=4
set shortmess=filmnrxoOtTW
set showbreak=>\ 
set showtabline=2
set smartindent
set smarttab
set splitbelow
set splitright
set tabstop=4
set updatetime=1000
set whichwrap=<,>,[,],b,s
set wildignore+=.svn
set wildignore+=CVS
set wildmode=list:longest,full
set wrap
let mapleader="\\"
let maplocalleader="\\"
" }}}

" automatically open/close the quickfix/location window {{{
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
" }}}

" disable "Ex" mode on Q {{{
nnoremap Q <nop>
" }}}

" disable search highlighting on double <Esc> {{{
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" }}}

" Vim7.3 specific settings {{{
if(v:version >= 703)
  set cryptmethod=blowfish
  set conceallevel=2
  set concealcursor=
  set undofile
endif
" }}}

" Try to load file containing passwords {{{
if(filereadable(expand("~/_vimpasswordrc")))
  exec "source ~/_vimpasswordrc"
else
  echomsg "Password file could not be loaded!"
endif
" }}}

nnoremap <Leader><Leader>e :e <C-r>*<CR>
nnoremap <Leader><Leader>d :diffsplit <C-r>*<CR>

if(has("win32"))
  if(exists("$TOOLS_DIR"))
    let g:tools_basedir = $TOOLS_DIR
  else
    echoerr "Environment variable TOOLS_DIR not set, many things will not work!"
  endif

  " Always write "_vimrc", "_gvimrc" and "_vundlerc" to all relevant locations, "~", "$VIM/vimfiles" and "$HOMEDRIVE/$HOMEDIR" (if different from "~") {{{
  augroup Vimrc_BackupVimFile
    au!
    au BufWritePost _vimrc call BackupVimFile()
    au BufWritePost _gvimrc call BackupVimFile()
    au BufWritePost _vundlerc call BackupVimFile()
  augroup end

  fun! BackupVimFile() "{{{
    " TODO: check how this can be generalized
    let nethome = fnamemodify("H:\\", ":p")
    let userprofile = fnamemodify(expand("$USERPROFILE"), ":p")
    let vimfilesdir = fnamemodify(expand("$VIM/vimfiles"), ":p")
    let filedir = fnamemodify(expand("%:h"), ":p") 
    if(filedir == nethome)
      call DoWriteCopy(vimfilesdir)
      call DoWriteCopy(userprofile)
    elseif(filedir == userprofile)
      call DoWriteCopy(vimfilesdir)
      if(isdirectory(nethome))
        call DoWriteCopy(nethome)
      endif
    elseif(filedir == vimfilesdir)
      call DoWriteCopy(userprofile)
      if(isdirectory(nethome))
        call DoWriteCopy(nethome)
      endif
    endif
  endfunction "}}}

  fun! DoWriteCopy(targetDir) "{{{
    if(isdirectory(a:targetDir))
      echomsg "Writing copy of file ".expand("%:p")." to ".fnamemodify(expand(a:targetDir), ":p")
      let targetfile = fnamemodify(a:targetDir."/".expand("%:t"), ":p")
      let fc = readfile(expand("%:p"), 'b')
      if(writefile(fc, targetfile, 'b') != 0)
        throw "Copying file ".expand("%:p")." to ".targetfile." failed"
      endif
    else
      echoerr "Given target directory ".a:targetDir." does not exist!!"
    endif
  endfunction "}}}
  " }}}

  if(exists('g:tools_basedir'))
    " Load bundle data for Vundle
    exec "source " . expand("<sfile>:p:h") . "/_vundlerc"
  endif

  " Use standard Windows clipboard for copying/yanking {{{
  set clipboard=unnamed
  " }}}

  " Don't clutter working directory with swap or undo files... {{{
  if( !isdirectory( expand( "$TEMP/vim" ) ) )
    " Try to create directory, if it does not exist
    silent! call mkdir( expand( "$TEMP/vim" ), "p" )
  endif
  set directory=$TEMP/vim//,$TMP/vim//,.
  set undodir=$TEMP/vim//,$TMP/vim//,.
  " }}}

  " Maximize GUI on open {{{
  au GUIEnter * simalt ~x
  " }}}

  " Settings for 'showmarks' {{{
  let g:showmarks_enable=0
  let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.'`^<>[]{}()\""
  " }}}

  " snippet engines {{{
  let s:expand_template_key = "<C-CR>"

  " XPTemplate (not used anymore) {{{
  " let g:xptemplate_key=s:expand_template_key
  " let g:xptemplate_nav_next=s:expand_template_key
  " let g:xptemplate_nav_prev="<C-S-CR>"
  " let g:xptemplate_fallback=s:expand_template_key

  " let g:xptemplate_always_show_pum=1
  " let g:xptemplate_brace_complete=0
  " let g:xptemplate_pum_tab_nav=1
  " let g:xptemplate_strict=1
  " let g:xptemplate_highlight='following,next'
  " let g:xptemplate_highlight_nested=1
  " }}}

  " UltiSnips {{{
  py import sys; import vim; sys.path.append(vim.eval("$VIM") + "/vimfiles/python")
  
  let g:UltiSnipsExpandTrigger=s:expand_template_key
  let g:UltiSnipsJumpForwardTrigger=s:expand_template_key
  let g:UltiSnipsJumpBackwardTrigger="<C-S-CR>"
  let g:UltiSnipsRemoveSelectModeMappings = 0

  let g:ulti_expand_res = 0
  let g:ulti_jump_forwards_res = 0
  let g:ulti_jump_backwards_res = 0

  function! CR()
    if pumvisible()
      call UltiSnips_ExpandSnippet() 
      if g:ulti_expand_res > 0
        return ""
      endif
    endif
    return "\<CR>"
  endfunction
  inoremap <CR> <C-R>=CR()<CR>

  function! Esc()
    if pumvisible()
      return "\<C-Y>"
    endif
    return "\<Esc>"
  endfunction
  inoremap <Esc> <C-R>=Esc()<CR>

  function! Tab(mode)
    if (a:mode == 'i') && pumvisible()
      return "\<C-N>"
    else
      call UltiSnips_JumpForwards()
      if g:ulti_jump_forwards_res > 0
        return ""
      endif
    endif
    if (a:mode == 's')
      return "gv\<C-g>\<Tab>"
    endif
    return "\<Tab>"
  endfunction
  inoremap <Tab> <C-R>=Tab('i')<CR>
  vnoremap <Tab> <Esc>i<C-R>=Tab('s')<CR>

  function! STab(mode)
    if (a:mode == 'i') && pumvisible()
      return "\<C-P>"
    else
      call UltiSnips_JumpBackwards()
      if g:ulti_jump_backwards_res > 0
        return ""
      endif
    endif
    if (a:mode == 's')
      return "gv\<C-g>\<S-Tab>"
    endif
    return "\<S-Tab>"
  endfunction
  inoremap <S-Tab> <C-R>=STab('i')<CR>
  snoremap <S-Tab> <Esc>i<C-R>=STab('s')<CR>
  " function! Ulti_Expand_and_getRes()
    " call UltiSnips_ExpandSnippet()
    " return g:ulti_expand_res
  " endfunction
  " inoremap <CR> <C-R>=(pumvisible() && (Ulti_Expand_and_getRes() > 0))?"":"\n"<CR>

  let g:snips_author='thkl2944'
  " }}}
  " }}}

  " YouCompleteMe {{{
  let g:ycm_key_list_select_completion = ['<Down>']
  let g:ycm_key_list_previous_completion = ['<Up>']
  " }}}

  " NERDTree {{{
  let g:NERDTreeChDirMode=2
  let g:NERDTreeHijackNetrw=0
  let g:NERDTreeWinPos="left"
  let g:NERDChristmasTree=1
  let g:NERDTreeShowBookmarks=1

  nmap <silent> <Leader>N :NERDTreeToggle<CR>
  nmap <Leader>nb :NERDTreeFromBookmark 
  nmap <Leader>nf :NERDTree 

  " }}}

  " NERDCommenter {{{
  let g:NERDCreateDefaultMappings=0
  let g:NERDSpaceDelims=1
  let g:NERDCompactSexyComs=1
  let g:NERDDefaultNesting=0

  nmap <Leader>cc <Plug>NERDCommenterToggle
  vmap <Leader>cc <Plug>NERDCommenterToggle
  nmap <Leader>cm <Plug>NERDCommenterMinimal
  vmap <Leader>cm <Plug>NERDCommenterMinimal
  nmap <Leader>cs <Plug>NERDCommenterSexy
  vmap <Leader>cs <Plug>NERDCommenterSexy

  " }}}

  " delimitMate {{{
  let g:delimitMate_expand_cr=0
  let g:delimitMate_expand_space=0
  let g:delimitMate_smart_quotes=1
  let g:delimitMate_balance_matchpairs=1
  let g:delimitMate_tab2exit=0

  " }}}

  " scratch {{{
  let g:scratch_buffer_name = "###Scratch###"
  let g:scratch_show_command = "rightb split | hide buffer"

  " Toggle the scratch buffer {{{
  fun! ToggleScratchBuffer()
    if bufwinnr(g:scratch_buffer_name) == -1
      ScratchOpen
    else
      if winnr("$") == 1 && bufname("%") ==# g:scratch_buffer_name
        enew
      endif
      ScratchClose
    endif
  endfunction
  nnoremap <Leader>S :call ToggleScratchBuffer()<CR>
  " }}}

  " }}}

  " Powerline {{{
  let g:Powerline_stl_path_style="short"
  let g:Powerline_colorscheme = 'solarized256'
  let g:Powerline_theme = 'custom' " removed the branch info and unused plugin stuff from the default theme
  " let g:Powerline_theme = 'solarized256'
  " let g:Powerline_theme="skwp"
  " let g:Powerline_colorscheme="skwp"
  " let g:Powerline_symbols_override={'BRANCH': '‡', 'LINE': 'L', 'RO': '‼',}
  " let g:Powerline_dividers_override = ['', '►', '', '◄']
  " let g:Powerline_symbols="fancy"
  " }}}

  " netrw {{{
  let g:netrw_cygwin = 0
  let g:netrw_scp_cmd = "pscp.exe"
  let g:netrw_sftp_cmd = "psftp.exe"
  let g:netrw_list_cmd = "plink.exe HOSTNAME ls -Fla "
  " }}}

  " CtrlP {{{
  let g:ctrlp_cache_dir = $TEMP.'/vim/ctrlp'
  let g:ctrlp_show_hidden = 1

  let g:ctrlp_map = '<C-p>f'
  nnoremap <C-p>b :CtrlPBuffer<CR>
  nnoremap <C-p>m :CtrlPMRU<CR>
  nnoremap <C-p> :CtrlPLastMode<CR>
  " }}}

  " colorschemes {{{
  call togglebg#map("<F5>")
  " obsolete:
  " careful, self-destroying mapping... ;-). This is required as the autoload
  " file containing the :ToggleBG command is not sourced otherwise
  " nmap <F5> :nunmap <F5><CR>:DoToggleBG<CR>
  " command! -nargs=0 DoToggleBG :call togglebg#map("<F5>")|delcommand DoToggleBG|ToggleBG
  " }}}

  " Reviews {{{
  let g:reviewprotocol_dir = 'D:\work\reviews'

  function! OpenReviewProtocol(ticketId) " {{{
    execute "edit " . g:reviewprotocol_dir . "\\" . toupper(a:ticketId) . ".cwiki"
  endfunction
  " }}}
  command! -nargs=1 ReviewProtocol call OpenReviewProtocol("<args>")
  command! -nargs=1 RP call OpenReviewProtocol("<args>")
  " }}}

  if(exists('g:tools_basedir'))
    " Setup curl {{{
    let g:netrw_http_cmd=g:tools_basedir . '\Curl\curl.exe -o'
    " }}}"

    " Generalize path to ctags.exe {{{
    let s:ctags_cmd=g:tools_basedir . '\Ctags\ctags.exe'
    " }}}

    " Generalize path to xmllint.exe {{{
    let g:xmllint_cmd=g:tools_basedir . '\libxml\bin\xmllint.exe'
    " }}}

    " Needed for custom jira-snippets with XPTemplate {{{
    let g:jira_server = 'https://issue.ebgroup.elektrobit.com'
    let g:jira_cmdline_app = '' . g:tools_basedir . '\atlassian-cli-2.6.0\jira.bat'
    if(exists('g:username'))
      let g:jira_username = g:username
      let g:jira_password = g:userpass
    endif
    " }}}

    " Grep {{{
    let Grep_Path=g:tools_basedir . '\GNU\bin\grep.exe'
    let Fgrep_Path=g:tools_basedir . '\GNU\bin\fgrep.exe'
    let Egrep_Path=g:tools_basedir . '\GNU\bin\egrep.exe'
    let Agrep_Path=g:tools_basedir . '\GNU\bin\AGREPW32.exe'
    let Grep_Find_Path=g:tools_basedir . '\GNU\bin\find.exe'
    let Grep_Xargs_Path=g:tools_basedir . '\GNU\bin\xargs.exe'
    let Grep_Find_Use_Xargs=0

    execute 'set grepprg=' . g:tools_basedir . '\\GNU\\bin\\grep.exe\ -nH'
    " }}}

    " Taglist (disabled) {{{
    " let g:Tlist_Ctags_Cmd=s:ctags_cmd
    " let g:tlist_ant_settings='ant_tlist;p:Project;t:Target;r:Property;d:Task;e:Extension-Point'
    " let g:tlist_jproperties_settings='jproperties;r:Property'
    " let g:Tlist_File_Fold_Auto_Close=1
    " let Tlist_GainFocus_On_ToggleOpen=0
    " let Tlist_Enable_Fold_Column=0
    " let Tlist_Use_Right_Window=1
    " let Tlist_WinWidth=35
    " let Tlist_Sort_Type = "name"

    " nmap <Leader>T :TlistToggle<CR>
    " }}}
  endif

  " Eclim {{{
  if !exists('g:EclimStartOnStartup')
    augroup DisableEclim
      au VimEnter * EclimDisable
    augroup end
  endif
  " let g:EclimProjectTreeAutoOpen=1
  " let g:EclimShowErrors=1
  " }}}

  " NeoComplCache (disabled) {{{
  " let g:neocomplcache_enable_at_startup=1
  " let g:neocomplcache_disable_auto_complete=1
  " let g:neocomplcache_auto_completion_start_length=4
  " let g:neocomplcache_enable_cursor_hold_i=0
  " let g:neocomplcache_enable_smart_case=1
  " let g:neocomplcache_enable_ignore_case=1
  " let g:neocomplcache_enable_auto_select=1
  " let g:neocomplcache_enable_camel_case_completion=1
  " let g:neocomplcache_enable_underbar_completion=1
  " let g:neocomplcache_temporary_dir=$TEMP . '\NeoComplCache'
  " let g:neocomplcache_min_keyword_length=2
  " let g:neocomplcache_plugin_disable={'snippets_complete' : 1}
  " let g:neocomplcache_min_syntax_length = 3

  " if !exists('g:neocomplcache_keyword_patterns')
  " let g:neocomplcache_keyword_patterns = {}
  " endif
  " let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " If completion menu visible complete common string, otherwise start completion
  " imap <silent><expr><C-Space>     pumvisible() ? "\<Plug>completeCommonString" : "\<C-x>\<C-u>\<C-p>"

  " inoremap <expr><Plug>completeCommonString             neocomplcache#complete_common_string() . "\<C-x>\<C-u>\<C-p>"
  " inoremap <expr><C-x><C-f>                             neocomplcache#manual_filename_complete()
  " inoremap <expr><C-x><C-o>                             neocomplcache#manual_omni_complete()
  " inoremap <expr><C-n>                                  pumvisible() ? "\<C-n>" : neocomplcache#manual_keyword_complete()
  " inoremap <expr><C-BS>                                 neocomplcache#undo_completion()
  " }}}

  " Calendar (disabled) {{{
  " let g:calendar_monday=1

  " }}}

  " Command-T (disabled) {{{
  " let g:CommandTAlwaysShowDotFiles = 1
  " let g:CommandTScanDotDirectories = 1
  " let g:CommandTMatchWindowReverse = 1
  " let g:CommandTMaxCachedDirectories = 10
  " }}}

  " Vimwiki (disabled) {{{
  " let wiki={}
  " let wiki.path='~/vimwiki/'
  " let wiki.nested_syntaxes={'perl': 'perl', 'xml': 'xml', 'docbook': 'docbk', 'java': 'java', 'bash': 'sh', 'ant': 'ant', 'sql': 'sql', 'vim': 'vim'}
  " let wiki.diary_index='index'
  " let wiki.diary_rel_path='Journal/'
  " let wiki.maxhi=0
  " let g:vimwiki_list=[wiki]
  " let g:vimwiki_hl_headers=1
  " let g:vimwiki_hl_cb_checked=1
  " let g:vimwiki_menu=''
  " let g:vimwiki_use_mouse=1
  " let g:vimwiki_badsyms=' '
  " let g:vimwiki_camel_case=0
  " let g:vimwiki_dir_link='index'
  " let g:vimwiki_folding=1
  " let g:vimwiki_fold_lists=1
  " let g:vimwiki_conceallevel=2
  " let g:vimwiki_table_auto_fmt=0

  " function! ToggleJournalAndCal() "{{{
    " let winnr_cal = bufwinnr('__Calendar')
    " let winnr_journal = bufwinnr('*vimwiki\Journal\'.strftime('%Y-%m-%d').'.wiki')
    " if (winnr_cal == -1) || (winnr_journal == -1)
      " echomsg "Opening journal and calendar..."
      " if winnr_cal == -1
        " echomsg "Opening calendar..."
        " Calendar
        " normal 
      " endif
      " if winnr_journal == -1
        " echomsg "Opening journal..."
        " VimwikiMakeDiaryNote
      " endif
    " else
      " echomsg "Closing journal and calendar..."
      " if winnr_cal != -1
        " echomsg "Closing calendar..."
        " call s:CloseWin( winnr_cal )
      " endif
      " if winnr_journal != -1
        " echomsg "Closing journal..."
        " call s:CloseWin( winnr_journal )
      " endif
    " endif
  " endfunction
  " command! -nargs=0 ToggleJournalAndCal :call ToggleJournalAndCal()

  " fun! s:CloseWin( winnr ) "{{{
    " if (winnr('$') == 1) && (tabpagenr('$') == 1)
      " enew
    " else
      " execute a:winnr.'wincmd w'
      " close
    " endif
  " endfunction "}}}
  " }}}

  " nnoremap <Leader>J :ToggleJournalAndCal<CR>

  " function! PortJournalEntries() "{{{
    " echomsg "Port journal entries called"
    " let date = matchlist(expand('%:t:r'), '\(\d\{4}\)-\(\d\{2}\)-\(\d\{2}\)')
    " let date = date[1:-1]
    " if date[0] == '' || date[1] == '' || date[2] == ''
      " echoerr "PortJournalEntries: could not determine date, got ".date[0]."-".date[1]."-".date[2]
      " return
    " endif
    " let last_date = s:ReduceDate(date)
    " let tries = 0
    " let wiki_file = s:GetWikiFilename(last_date)
    " echomsg "Trying to read ".wiki_file
    " while !filereadable(wiki_file)
      " let tries += 1
      " if tries == 50
        " echoerr "PortJournalEntries: could not find last journal entry in the last 50 days"
        " return
      " endif
      " let last_date = s:ReduceDate(last_date)
      " let wiki_file = s:GetWikiFilename(last_date)
      " echomsg "Trying to read ".wiki_file
    " endwhile
    " echomsg "Copying journal entries from file ".wiki_file
    " execute 'read '.wiki_file
    " This will leave one empty line on top, so delete this:
    " 0 delete
    " Delete all completed top level items
    " This means:
    " - [%s/]: substitute
    " - [ ^\* \[X\] ]: every line beginning with '* [X] '
    " - [\_.\{-}]: followed by as many characters of any kind (including newline) as
    "   needed (but not more)
    " - [\(\n\?\ze\%$\)\|\(\n\ze\*\|\(\s*\n\)\)]: followed by one of
    "   - [\n\?\ze\%$]: optionally a newline (then stop the match, check only) and
    "     end-of-file
    "   - [\n\ze\*]: a newline (then stop the match, check only) and a literal asterisk
    "   - [\n\ze\s*\n]: a newline (then stop the match, check only) and as
    "     many whitespace characters as possible and another newline
    " % substitute/^\* \[X\] \_.\{-}\(\(\n\?\ze\%$\)\|\(\n\ze\*\)\|\(\n\ze\s*\n\)\)//e
    " Delete empty line at the end of the file that may occur due to the last
    " substitute
    " silent! /^\s*\%$/ delete
    " Reset the folding
    " call ResetJournalFolding()
  " endfunction "}}}

  " let s:days_per_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  " fun! s:ReduceDate(date) "{{{
    " let year = a:date[0]
    " let month = a:date[1]
    " let day = a:date[2]

    " let day -= 1
    " if day == 0 " Flip over month boundary
      " let month -= 1
      " if month == 0 " Flip over year boundary
        " let year -= 1
        " let month = 12
      " endif
      " let day = s:days_per_month[month-1]
    " endif
    " return [year, month, day]
  " endfunction "}}}

  " fun! s:GetWikiFilename( date ) "{{{
    " return printf("%s/vimwiki/Journal/%04d-%02d-%02d.wiki", expand('~'), a:date[0], a:date[1], a:date[2])
  " endfunction "}}}

  " fun! ResetJournalFolding() "{{{
    " echomsg "Reset folding called"
    " Close all folds
    " setlocal foldlevel=0
    " Open all folds that are not marked as done ("[X]")
    " global/^\s*\* \[[^X]\]/silent! verbose normal zo
  " endfunction "}}}

  " augroup Vimrc_PortJournalEntries
    " au!
    " au BufNewFile ~/vimwiki/Journal/[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9].wiki call PortJournalEntries()
  " augroup end

  " augroup Vimrc_JournalFolding
    " au!
    " au BufReadPost ~/vimwiki/Journal/[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9].wiki call ResetJournalFolding()
  " augroup end

  " }}}

  " Conque_Shell (disabled) {{{
  " let g:ConqueTerm_PyExe='C:\Tools\Python26\python.exe'

  " }}}

  " tselectbuffer (disabled) {{{
  " let g:tlib_inputlist_match = "fuzzy"

  " nnoremap <Leader>B :TSelectBuffer<CR>

  " }}}

  " minibufexpl.vim (disabled) {{{
  " let g:miniBufExplSplitBelow = 0
  " let g:miniBufExplorerMoreThanOne=0
  " let g:miniBufExplMapWindowNavVim = 1
  " let g:miniBufExplUseSingleClick = 1
  " let g:miniBufExplModSelTarget = 1
  " let g:miniBufExplMapCTabSwitchBufs = 1

  " fun! ReopenMBE()
  " TMiniBufExplorer
  " TMiniBufExplorer
  " endfun

  " augroup Vimrc_MBE
  " au BufWinEnter NERD_tree_* call ReopenMBE()
  " au BufWinEnter __Tag_List__ call ReopenMBE()
  " au BufWinEnter __Calendar call ReopenMBE()
  " augroup END

  " nmap <Leader>M :TMiniBufExplorer<CR>

  " }}}

  " Tagbar (disabled) {{{
  " let g:tagbar_ctags_bin=s:ctags_cmd
  " let g:tagbar_type_ant={'ctagstype': 'ant_tlist', 'kinds': ['p:Project', 't:Target', 'r:Property', 'd:Task', 'e:Extension-Point']}
  " let g:tagbar_type_jproperties={'ctagstype': 'jproperties', 'kinds': ['r:Property']}
  " let g:tagbar_width=35

  " nmap <Leader>T :TagbarToggle<CR>

  " }}}

  " session3150 (disabled) {{{
  "let g:session_autosave=1

  " }}}

  " easytags (disabled) {{{
  "let g:easytags_cmd=s:ctags_cmd
  "let g:easytags_file="easytags"

  " }}}

  " Source_Explorer (disabled) {{{
  " let g:SrcExpl_gobackKey="<BS>"
  " let g:SrcExpl_updateTagsCmd=s:ctags_cmd." -R ."
  " let g:SrcExpl_updateTagsKey="<F5>"

  " nmap <Leader>S :SrcExplToggle<CR>

  " }}}

  " SuperTab settings (disabled) {{{
  "let g:SuperTabDefaultCompletionType='context'
  "let g:SuperTabCompletionContexts=['s:ContextText', 's:ContextDiscover']
  "let g:SuperTabContextTextOmniPrecedence=['&omnifunc', '&completefunc']
  "let g:SuperTabContextDiscoverDiscovery=["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
  "
  "let g:SuperTabMappingForward='<c-space>'
  "let g:SuperTabMappingBackward='<s-c-space>'

  "let g:SuperTabLongestHighlight=1
  " }}}

  " OutlookVim (disabled) {{{
  " let g:outlook_textwidth=0
  " let g:outlook_use_tabs=1
  " let g:outlook_nodelete_unload=0
  " let g:outlook_noautoread=0
  " let g:outlook_javascript='C:\Tools\vim\plugins\OutlookVim\plugin\outlookvim.js'

  " }}}

endif

" Highlight word under cursor in whole file by pressing <Leader>hh {{{
let s:hl_cursor_word=0
fun! ToggleHlCursorWord()
  if s:hl_cursor_word == 0
    let s:hl_cursor_word=1
    augroup Vimrc_HlCursorWord
      au!
      au CursorHold,CursorHoldI * exec 'match IncSearch /\V\<'. escape(expand ("<cword>"), '\/') .'\>/'
    augroup end
  else
    let s:hl_cursor_word=0
    augroup Vimrc_HlCursorWord
      au!
    augroup end
    match none
  endif
endfunction
nnoremap <Leader>hh :call ToggleHlCursorWord()<CR>
" }}}

" Make behave Y like D, C, I etc... {{{
nmap Y y$
" }}}

" Mappings for tab control {{{
fun! CloseTab() "{{{
  if( tabpagenr("$") == 1)
    wincmd o
    enew
  else
    tabclose
  endif
endfunction "}}}

nmap <C-t> :tabnew<cr>
map <C-F4> :call CloseTab()<cr>
" }}}

" Move screen lines when wrapping... {{{
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
xnoremap <Down> gj
xnoremap <Up> gk
inoremap <expr> <Down> pumvisible() ? "\<Down>" : "\<C-o>gj"
inoremap <expr> <Up> pumvisible() ? "\<Up>" : "\<C-o>gk"
" }}}

" Make it possible to move in insert mode without touching the cursor keys via <C-motion> {{{
" Do not use the cursor keys for up/down to also move if the pum is visible
" and to move in screen lines
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj
inoremap <C-k> <C-o>gk
snoremap <C-h> <Left>
snoremap <C-l> <Right>
snoremap <C-j> <C-o>gj
snoremap <C-k> <C-o>gk
" }}}

" Ease window navigation, make <C-direction> behave like <C-w>direction {{{
nnoremap <M-h> :wincmd h<CR>
nnoremap <M-l> :wincmd l<CR>
nnoremap <M-k> :wincmd k<CR>
nnoremap <M-j> :wincmd j<CR>
" }}}

" Show leading whitespace that includes spaces, and trailing whitespace. {{{
au ColorScheme * hi default link ErrorWhiteSpace ErrorMsg

function! ToggleShowWhitespace()
  if !exists('b:ws_show')
    let b:ws_show=0
  endif
  let b:ws_show=!b:ws_show
  if b:ws_show
    match ErrorWhiteSpace /\t\|\s\+$/
    augroup Vimrc_ShowErrorWhiteSpace
      au!
      au InsertEnter [^_]*,?[^_]* match ErrorWhiteSpace /\t\|\s\+\%#\@<!$/
      au InsertLeave [^_]*,?[^_]* match ErrorWhiteSpace /\t\|\s\+$/
    augroup end
  else
    match none
    augroup Vimrc_ShowErrorWhiteSpace
      au!
    augroup end
  endif
endfunction

nnoremap <Leader><Space><Space> :call ToggleShowWhitespace()<CR>
" }}}

" FileType specific omnicomplete settings {{{
augroup OmniComplete
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup end
" }}}

if(has("gui_running"))
  set cursorline
  set cursorcolumn
else
  set nocursorline
  set nocursorcolumn
endif

set background=light
colorscheme solarized
filetype plugin indent on
autocmd Filetype * if &omnifunc == "" |
                \    setlocal omnifunc=syntaxcomplete#Complete |
                \  endif
syntax on
