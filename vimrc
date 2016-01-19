
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible	" Use Vim defaults (much better!)

set backspace=indent,eol,start

set backup		" keep a backup file
set backupdir=~/.vim_backup

set viminfo='20,<50,%,h	" read/write a .viminfo file, don't store more
			" than 50 lines of registers, save buffer list
set ignorecase
set hidden
set wildmode=list:longest

set showcmd

set nofoldenable

set showmatch
set matchtime=3

" Disable Q entering Ex mode
nnoremap Q <nop>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  ""syntax on
  "syntax enable
  set hlsearch

  highlight WhitespaceEOL ctermbg=red guibg=red
  match WhitespaceEOL /\s\+$/
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " the above line doesn't seem to actually work, so...
  autocmd BufRead *.txt set tw=78 formatoptions=tcqln ai

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

" shell command, taken from http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
" runs shell command, opens new scratch buffer for output
" Example: :Shell git blame %
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction

" Define function to list buffers.
" Similar to :ls, but shows the short filename for each buffer, similar to
" Buffers menu.
command! Ls call ListBuffers()
function! ListBuffers()
    redir => ls_output
    silent exec 'ls'
    redir END

    let list = substitute(ls_output, '"\(\f*/\)*\(\f*\)"', '\=submatch(2)', "g")

    echo list
endfunction

