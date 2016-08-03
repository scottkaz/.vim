if has ("gui_gtk2")
    set guifont=Andale\ Mono\ 11
endif

set columns=128 lines=48
set vb		" visual bell
set encoding=utf-8

set autoread

if (&foldmethod == 'diff')
    set columns=165
endif

" no scrollbars
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

set ch=2                " Make command line two lines high

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

  "set background=light
  "so ${VIMRUNTIME}/syntax/syntax.vim
  "colo kaz_colors

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
  highlight Normal guibg=grey90
  "highlight Cursor guibg=Green guifg=NONE
  "highlight Cursor guibg=Red guifg=NONE
  highlight Cursor guibg=Orange guifg=NONE
  highlight lCursor guibg=Cyan guifg=NONE
  highlight NonText guibg=grey80
  highlight Constant gui=NONE guibg=grey95
  highlight Special gui=NONE guibg=grey95

endif

set menuitems=999
