" =============================================================================
" Filename: autoload/closebuffer.vim
" Author: itchyny
" License: MIT License
" Last Change: 2014/02/15 11:02:35.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! closebuffer#close()
  try
    if index(get(g:, 'closebuffer_filetype_bwipeout', [ 'quickrun' ]), &ft) >= 0
      silent bw!
    elseif index(get(g:, 'closebuffer_filetype_quit', [ 'vimshell', 'vimfiler' ]), &ft) >= 0
      silent q
    elseif index(get(g:, 'closebuffer_filetype_feedkeyq', [ 'gundo', 'calendar' ]), &ft) >= 0
      silent call feedkeys('q')
    elseif index(get(g:, 'closebuffer_filetype_bdelete', []), &ft) >= 0
      silent bd!
    elseif index(get(g:, 'closebuffer_filename_bdelete', [ '__XtermColorTable__' ]), expand('&:t')) >= 0
      silent bd!
    elseif len(filter(range(1, winnr('$')), 'winbufnr(v:val) == winbufnr(0)')) > 1
      silent q
    elseif &ft == '' && !&modified || expand('%:t') ==# '[Command Line]'
      silent q!
    elseif &modified
    else
      silent bd!
    endif
  catch
  endtry
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
