" =============================================================================
" Filename: plugin/closebuffer.vim
" Author: itchyny
" License: MIT License
" Last Change: 2014/12/14 00:52:46.
" =============================================================================

if exists('g:loaded_closebuffer') || v:version < 700
  finish
endif
let g:loaded_closebuffer = 1

let s:save_cpo = &cpo
set cpo&vim

inoremap <silent> <Plug>(closebuffer) <ESC>:<C-u>call closebuffer#close()<CR>
nnoremap <silent> <Plug>(closebuffer) :<C-u>call closebuffer#close()<CR>
vnoremap <silent> <Plug>(closebuffer) :<C-u>call closebuffer#close()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
