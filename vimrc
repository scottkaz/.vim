"--------------------------------------------------------------------
" Setup for vundle (vim plugin manager)
"--------------------------------------------------------------------
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
"
set nocompatible              " be iMproved, required for vundle
filetype off                  " required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
Plugin 'wincent/command-t'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

"Plugin 'valloric/youcompleteme'

Plugin 'rust-lang/rust.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
"--------------------------------------------------------------------
" End of setup for vundle
"
" Put your non-Plugin stuff after this
"--------------------------------------------------------------------

" YouCompleteMe options
"let g:ycm_extra_conf_globlist = ['~/mantis-top/*']
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
"let g:ycm_autoclose_preview_window_after_insertion = 1

set backspace=indent,eol,start

set ai

set backup		" keep a backup file
set backupdir=~/.vim_backup

set viminfo='20,<50,%,h	" read/write a .viminfo file, don't store more
			" than 50 lines of registers, save buffer list
set ignorecase
set hidden
set wildmode=list:longest

set nomodeline

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
if &t_Co > 1 || has("gui_running")
  ""syntax on
  "syntax enable
  set hlsearch

  "highlight WhitespaceEOL ctermbg=red guibg=red
  "match WhitespaceEOL /\s\+$/

  " Highlight trailing spaces
  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  autocmd FileType text setlocal tw=78 sw=8 formatoptions=tcql2 noexpandtab nosmarttab
  "autocmd BufRead *.txt setlocal tw=78 sw=8 formatoptions=tcqln noexpandtab nosmarttab

  autocmd FileType python setlocal tw=999 sw=4 formatoptions=crqlnj expandtab smarttab
  autocmd FileType perl setlocal tw=999 sw=4 formatoptions=crqlnj expandtab smarttab
  autocmd FileType json setlocal tw=999 sw=4 formatoptions=crqlnj expandtab smarttab
  autocmd FileType javascript setlocal tw=78 sw=4 formatoptions=crqlnj expandtab smarttab
  autocmd FileType html setlocal tw=78 sw=2 formatoptions=crqlnj expandtab smarttab
  autocmd FileType sh setlocal tw=78 sw=4 formatoptions=crqlnj expandtab smarttab

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

set grepprg=ag\ -s

" CommandT options
let g:CommandTFileScanner="git"
let g:CommandTTraverseSCM="pwd"
let g:CommandTMaxHeight=0
let g:CommandTGitScanSubmodules=0
let g:CommandTWildIgnore="tools/x86*,tools/arm*,**/nautilus-toolchain-arm/*,**/3rdParty/*,*.o,*.d"
