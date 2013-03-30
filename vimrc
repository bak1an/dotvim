call pathogen#infect()
set nocompatible
colorscheme desert
set ai
set encoding=utf-8
autocmd! bufwritepost .vimrc source %

set autoread " reload file when changes happen in other editors
set tags=./tags

set mouse=a
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

set clipboard=unnamed

set history=700
set undolevels=700

set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
" disable formatting when pasting large chunks of code
set pastetoggle=<F2>

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

set hlsearch
set incsearch
set ignorecase
set smartcase

set nowrap " don't automatically wrap on load
set tw=79  " width of document (used by gd)
set fo-=t  " don't automatically wrap text when typing
set number " show line numbers

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

