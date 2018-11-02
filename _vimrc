" vim: set foldmethod=marker foldlevel=0 :

" Only load the settings once
if(exists("g:loaded_vimrc_thkl2944"))
  finish
endif
let g:loaded_vimrc_thkl2944 = 1

" general options {{{
set autoindent
set backspace=eol,start,indent
set completeopt=menuone,preview
set concealcursor=
set conceallevel=2
set confirm
if(!has('nvim'))
  set cryptmethod=blowfish
endif
set cursorline
set cursorcolumn
set diffopt=filler,iwhite,vertical
set display=lastline
set encoding=utf-8
set expandtab
set fileformats=unix,dos
set foldcolumn=2
set foldlevelstart=99
set formatoptions+=roq
set formatoptions-=tc
set gdefault
set helplang=en
set hidden
set hlsearch
set inccommand=split
set incsearch
set iskeyword+=-
set laststatus=2
set lazyredraw
set linebreak
set linespace=0
set listchars=eol:¶,tab:▸\ ,trail:·
set nocscopetag
set noignorecase
set number
set numberwidth=4
set scrolljump=5
set scrolloff=3
set shiftwidth=4
set shortmess=aOtTWI
set showbreak=\ 
set showtabline=2
set smartindent
set smarttab
set splitbelow
set splitright
set tabpagemax=100
set tabstop=4
set tildeop
set undofile
set updatetime=1000
set whichwrap=<,>,[,],b,s
set wildignore+=.git
set wildignore+=.svn
set wildignore+=CVS
set wildmode=list:longest,full
set wrap
let mapleader="\<Space>"
let maplocalleader=","
" }}}

if(!has('nvim'))
  packadd! editexisting
  packadd! matchit
endif

function! s:absolute(path)
  return substitute(fnamemodify(expand(substitute(a:path,"/","\\","g")),":p"),"\\","/","g")
endfunction

if(has('nvim'))
  let g:vimfilesdir = s:absolute("$VIM/../../../vimfiles/")
else
  let g:vimfilesdir = s:absolute("$VIM/vimfiles/")
endif

let g:vimrc = g:vimfilesdir . "_vimrc"
let g:bundlerc = g:vimfilesdir . "_deinrc"

if(has('nvim'))
  let g:python_host_prog  = 'C:\Tools\Python27\python'
  let g:python3_host_prog = 'C:\Tools\Python36\python'
endif

execute "nmap <Leader>ve :e " . g:vimrc . "<CR>"
execute "nmap <Leader>vs :unlet g:loaded_vimrc_thkl2944<CR>:source " . g:vimrc . "<CR>"
execute "nmap <Leader>be :e " . g:bundlerc . "<CR>"
execute "nmap <Leader>bs :source " . g:bundlerc . "<CR>"

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

" Copy file name or path to clipboard via <A-S-Insert> or <A-Insert> respectively {{{
nnoremap <A-Insert> :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
nnoremap <A-S-Insert> :let @*=substitute(expand("%:t"), "/", "\\", "g")<CR>
" }}}

" Terminal mode mappings {{{
if(has('nvim'))
  tnoremap <Esc> <C-\><C-n>
endif
" }}}

" Try to use powershell as shell (disabled) {{{
" if executable("powershell")
  " set shell=powershell
  " set shellcmdflag=-c
  " set shellquote=\"
  " set shellxquote=
" endif
" }}}

" Try to load file containing passwords {{{
if(filereadable(expand("~/_vimpasswordrc")))
  source ~/_vimpasswordrc
else
  echomsg "Password file could not be loaded!"
endif
" }}}

nnoremap <Leader><Leader>e :e <C-r>*<CR>
nnoremap <Leader><Leader>d :diffsplit <C-r>*<CR>

if(has("win32"))
  let g:tools_basedir = 'C:\Tools\'
  let g:caches_dir = s:absolute(g:tools_basedir . 'vim\caches')
  
  if(exists('g:tools_basedir'))
    " Load bundle data for Vundle
    exec "source " . g:bundlerc
  endif

  " Use standard Windows clipboard for copying/yanking {{{
  set clipboard=unnamed,unnamedplus
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
  if(!has('nvim'))
    au GUIEnter * simalt ~x
  endif
  " }}}

  " snippet engine / autocompletion {{{
  let s:expand_template_key = "<C-CR>"

   " UltiSnips {{{
  let g:UltiSnipsUsePythonVersion=2
  py import sys; import vim; sys.path.append(vim.vars['vimfilesdir'] + "python")

  let g:UltiSnipsExpandTrigger=s:expand_template_key
  let g:UltiSnipsJumpForwardTrigger=s:expand_template_key
  let g:UltiSnipsJumpBackwardTrigger="<C-S-CR>"
  let g:UltiSnipsRemoveSelectModeMappings = 0
  let g:UltiSnipsListSnippets = "<C-S-A-Tab>"

  let g:UltiSnipsEnableSnipMate = 0

  let g:ulti_expand_res = 0
  let g:ulti_jump_forwards_res = 0
  let g:ulti_jump_backwards_res = 0

  let g:snips_author='thkl2944'
  " }}}

  if(!has('nvim'))
    " {{{
    " neocomplete {{{
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#auto_completion_start_length = 3
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#data_directory = $TEMP.'/vim/neocomplete'
    " }}}

    " function! CR() {{{
    function! CR()
      if pumvisible()
        " call UltiSnips#ExpandSnippet()
        " if g:ulti_expand_res > 0
          " return ""
        " else
          return neocomplete#close_popup()
        " endif
      endif
      return "\<CR>"
    endfunction
    inoremap <CR> <C-R>=CR()<CR>

    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

    inoremap <expr><C-Space> neocomplete#start_manual_complete()
    inoremap <expr><A-Space> neocomplete#start_manual_complete('ultisnips')
    " }}}
    " }}}
  else
    " {{{
    " deoplete {{{
    let g:deoplete#enable_at_startup = 1
    " let g:neocomplete#enable_auto_delimiter = 1
    " let g:neocomplete#auto_completion_start_length = 3
    " let g:neocomplete#enable_camel_case = 1
    " let g:neocomplete#data_directory = $TEMP.'/vim/neocomplete'
    " }}}

    " function! CR() {{{
    function! CR()
      if pumvisible()
        " call UltiSnips#ExpandSnippet()
        " if g:ulti_expand_res > 0
          " return ""
        " else
          return deoplete#close_popup()
        " endif
      endif
      return "\<CR>"
    endfunction
    inoremap <CR> <C-R>=CR()<CR>

    inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

    inoremap <expr><C-Space> deoplete#manual_complete()
    inoremap <expr><A-Space> deoplete#manual_complete('ultisnips')
    " }}}
    " }}}
  endif

  " common mappings and functions {{{
  function! ExpandIfSnippet()
    if exists('v:completed_item')
      if empty(v:completed_item)
        return
      endif
      " echomsg "Completion done: " . v:completed_item.menu
      if (match(v:completed_item.menu, '^\[US\]') != -1)
        " echomsg "Attempting to expand " . v:completed_item.word
        call UltiSnips#ExpandSnippet()
      endif
    endif
  endf

  augroup Completion
    au!
    au CompleteDone * call ExpandIfSnippet()
  augroup END

  function! Tab(mode)
    call UltiSnips#JumpForwards()
    if g:ulti_jump_forwards_res > 0
      return ""
    endif

    if (a:mode == 'i') && pumvisible()
      return "\<C-N>"
    endif

    if (a:mode == 's')
      return "gv\<C-g>\<Tab>"
    elseif (a:mode == 'n')
      return "\<Esc>\<Tab>"
    endif

    return "\<Tab>"
  endfunction
  inoremap <Tab> <C-R>=Tab('i')<CR>
  vnoremap <Tab> <Esc>i<C-R>=Tab('s')<CR>
  nnoremap <Tab> a<C-R>=Tab('n')<CR>

  function! STab(mode)
    call UltiSnips#JumpBackwards()
    if g:ulti_jump_backwards_res > 0
      return ""
    endif

    if (a:mode == 'i') && pumvisible()
      return "\<C-P>"
    endif

    if (a:mode == 's')
      return "gv\<C-g>\<S-Tab>"
    elseif (a:mode == 'n')
      return "\<Esc>\<S-Tab>"
    endif

    return "\<S-Tab>"
  endfunction
  inoremap <S-Tab> <C-R>=STab('i')<CR>
  snoremap <S-Tab> <Esc>i<C-R>=STab('s')<CR>
  nnoremap <S-Tab> a<C-R>=STab('n')<CR>
  " }}}
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

  " vim-airline {{{
  let g:airline_inactive_collapse=0
  let g:airline_skip_empty_sections=1
  let g:airline_theme='solarized'
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'

  " let g:airline#extensions#tabline#enabled = 1
  " let g:airline#extensions#tabline#show_splits = 1
  " let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'

  let g:airline#extensions#whitespace#symbol = '☼'
  " }}}

  " taboo.vim {{{
  let g:taboo_tab_format = " %f%m%U "
  let g:taboo_renamed_tab_format = " [%l]%m%U "
  " }}}

  " Reviews {{{
  let g:reviewprotocol_dir = 'D:\work\reviews\'

  function! OpenReviewProtocol(ticketId) " {{{
    execute "edit " . g:reviewprotocol_dir . toupper(a:ticketId) . ".cwiki"
  endfunction
  " }}}
  function! ReviewProtocolComplete(A,L,P) " {{{
    let files = glob(g:reviewprotocol_dir . toupper(a:A) . '*.cwiki', 1, 1)
    let result = []
    let startidx = strlen(g:reviewprotocol_dir)
    let endidx = -(strlen('.cwiki') + 1)
    for file in files
      let result += [file[startidx : endidx]]
    endfor
    return result
  endfunction
  " }}}
  command! -nargs=1 -complete=customlist,ReviewProtocolComplete ReviewProtocol call OpenReviewProtocol("<args>")
  cnoreabbrev rp ReviewProtocol
  " }}}

  if(exists('g:tools_basedir'))
    " Setup curl {{{
    let g:netrw_http_cmd = s:absolute(g:tools_basedir . 'Curl\curl.exe') . ' -o'
    " }}}"

    " Setup ruby {{{
    let g:ruby_host_prog = s:absolute(g:tools_basedir . 'Ruby24-x64\bin\neovim-ruby-host.bat')
    " }}}

    " Needed for custom jira-snippets {{{
    let g:jira_server = 'https://issue.ebgroup.elektrobit.com'
    if(exists('g:username'))
      let g:jira_username = g:username
      let g:jira_password = g:userpass
    endif
    " }}}

    " neomru {{{
    let g:neomru#file_mru_path = g:caches_dir . "/neomru/file"
    let g:neomru#directory_mru_path = g:caches_dir . "/neomru/directory"
    " }}}

    if(!has('nvim'))
      " Unite {{{
      let g:unite_data_directory = $TEMP.'/vim/unite'
      let g:unite_enable_start_insert = 1
      let g:unite_enable_smart_case = 1
      let g:unite_source_rec_git_command = substitute( g:tools_basedir . '\Git\bin\git.exe', '\', '\\\\', 'g' )
      call unite#filters#matcher_default#use(['matcher_fuzzy'])
      call unite#custom#source('buffer,file_rec/async,file_rec,file,directory,directory_rec', 'sorters', 'sorter_rank')
      call unite#custom#profile('files,directories,buffers,changes,history,sources', 'context.ignorecase', 1)
      call unite#custom#profile('files,directories,buffers,changes,history,sources', 'context.smartcase', 1)

      nnoremap <C-p>f :Unite -auto-preview -no-split -buffer-name=files file buffer neomru/file<CR>
      nnoremap <C-p>d :Unite -no-split -buffer-name=directories directory<CR>
      nnoremap <C-p>b :Unite -auto-preview -no-split -buffer-name=buffers buffer<CR>
      nnoremap <C-p>s :Unite -winheight=100 -immediately -no-empty ultisnips<CR>

      nnoremap <C-p>i :Unite -auto-preview -no-split -buffer-name=git file_rec/git<CR>
      nnoremap <C-p> :Unite -no-split -buffer-name=sources source<CR>
      nnoremap <C-S-p> :UniteResume<CR>
      " }}}
    else
      " denite.nvim {{{
      nnoremap <C-p>f :Denite -auto-preview -buffer-name=files file buffer file_mru<CR>
      nnoremap <C-p>d :Denite -buffer-name=directories directory_rec directory_mru<CR>
      nnoremap <C-p>b :Denite -auto-preview -buffer-name=buffers buffer<CR>

      nnoremap <C-p>i :Denite -auto-preview --buffer-name=git file_rec/git<CR>
      nnoremap <C-p> :Denite -buffer-name=sources source<CR>
      " }}}
    endif
  endif
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

" Make Y behave like D, C, I etc... {{{
nmap Y y$
" }}}

" Mappings for tab control {{{
fun! CloseTab() "{{{
  let lasttabnr = tabpagenr("$")
  if( lasttabnr == 1)
    bufdo bdelete
  else
    let currenttabnr = tabpagenr()
    let currenttabbuflist = tabpagebuflist()
    for tabnr in range(1, lasttabnr)
      if( tabnr == currenttabnr )
        continue
      endif
      let tabbuflist = tabpagebuflist(tabnr)
      for bufnr in tabbuflist
        let currenttabbuflist = filter( currenttabbuflist, "v:val != bufnr" )
      endfor
    endfor
    for bufnr in currenttabbuflist
      exec "bdelete ".bufnr
    endfor
    if( currenttabnr == tabpagenr() )
      tabclose
    endif
  endif
endfunction "}}}

" fun! CloseBuf() "{{{
  " if(&buftype == 'help')
    " q
  " else
    " let currentbufnr = bufnr("%")
    " bnext
    " exec "bdelete " . currentbufnr
  " endif
" endfunction "}}}

" nmap <C-t> :enew<cr>
" map <C-F4> :call CloseBuf()<cr>
" command! -nargs=0 CloseBuf :call CloseBuf()
" map <C-Tab> :bnext<CR>
" map <C-S-Tab> :bprevious<CR>
nmap <C-t> :tabnew<cr>
map <C-F4> :call CloseTab()<cr>
command! -nargs=0 CloseTab :call CloseTab()
map <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprevious<CR>
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

" Make it possible to move in insert mode without touching the cursor keys via <C-motion> (disabled) {{{
" Do not use the cursor keys for up/down to also move if the pum is visible
" and to move in screen lines
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>
" inoremap <C-j> <C-o>gj
" inoremap <C-k> <C-o>gk
" snoremap <C-h> <Left>
" snoremap <C-l> <Right>
" snoremap <C-j> <C-o>gj
" snoremap <C-k> <C-o>gk
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

nnoremap <Leader>tw :call ToggleShowWhitespace()<CR>
" }}}

" FileType specific omnicomplete settings {{{
augroup OmniComplete
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup end
" }}}

set background=light
colorscheme NeoSolarized
filetype plugin indent on
autocmd Filetype * if &omnifunc == "" |
      \    setlocal omnifunc=syntaxcomplete#Complete |
      \  endif
syntax on
