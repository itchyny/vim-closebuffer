" =============================================================================
" Filename: plugin/closebuffer.vim
" Author: itchyny
" License: MIT License
" Last Change: 2014/02/13 16:03:53.
" =============================================================================

if exists('g:loaded_closebuffer') && g:loaded_closebuffer
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

inoremap <silent> <Plug>(closebuffer) <ESC>:<C-u>call closebuffer#close()<CR>
nnoremap <silent> <Plug>(closebuffer) :<C-u>call closebuffer#close()<CR>
vnoremap <silent> <Plug>(closebuffer) :<C-u>call closebuffer#close()<CR>

let g:loaded_closebuffer = 1

let &cpo = s:save_cpo
unlet s:save_cpo
