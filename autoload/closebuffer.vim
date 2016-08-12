" =============================================================================
" Filename: autoload/closebuffer.vim
" Author: itchyny
" License: MIT License
" Last Change: 2016/08/12 10:09:22.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! closebuffer#close() abort
  try
    if index(get(g:, 'closebuffer_filetype_bwipeout', [ 'quickrun' ]), &ft) >= 0
      silent bw!
    elseif index(get(g:, 'closebuffer_filetype_quit', [ 'vimshell', 'vimcalc', 'help' ]), &ft) >= 0
      silent q
    elseif index(get(g:, 'closebuffer_filetype_feedkeyq', [ 'gundo', 'calendar', 'agit', 'agit_stat', 'agit_diff' ]), &ft) >= 0
      \ || index(get(g:, 'closebuffer_filename_feedkeyq', [ '__Gundo_Preview__' ]), expand('%:t')) >= 0
      silent call feedkeys('q')
    elseif index(get(g:, 'closebuffer_filetype_bdelete', [ 'vimfiler' ]), &ft) >= 0
      silent bd!
    elseif index(get(g:, 'closebuffer_filename_bdelete', [ '__XtermColorTable__' ]), expand('%:t')) >= 0
      silent bd!
    elseif &ft ==# 'qf'
      try
        if get(b:, 'qflisttype', '') ==# 'location'
          lclose
        else
          wincmd p
          lclose
        endif
      catch
        enew
      endtry
    elseif expand('%') =~# '^gita://'
      tabclose!
    elseif len(filter(range(1, winnr('$')), 'winbufnr(v:val) == winbufnr(0)')) > 1
      silent q
    elseif &ft ==# '' && !&modified || (exists('*getcmdwintype') ? getcmdwintype() !=# '' : bufname('%') ==# '[Command Line]')
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
