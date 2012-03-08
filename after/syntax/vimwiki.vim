" Highlight 'arrows'
syntax match SpecialKey /<[=\-~+]\+>\|<[=\-~+]\+\|[=\-~+]\+>/

" Only highlight the remaining line as comment, keep highlighting for
" checkbox, if checkbox is checked
if g:vimwiki_hl_cb_checked
  execute 'syntax match VimwikiCheckBoxDone /\('.
        \ g:vimwiki_rxListBullet.'\s*\['.g:vimwiki_listsyms[4].'\]\)\@<=.*$/'.
        \ ' contains=VimwikiNoExistsLink,VimwikiLink'
  execute 'syntax match VimwikiCheckBoxDone /\('.
        \ g:vimwiki_rxListNumber.'\s*\['.g:vimwiki_listsyms[4].'\]\)\@<=.*$/'.
        \ ' contains=VimwikiNoExistsLink,VimwikiLink'
endif
