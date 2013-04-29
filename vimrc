set nocompatible

filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

set t_Co=256
let g:molokai_original = 1
colorscheme molokai
set ai
set encoding=utf-8
autocmd! bufwritepost .vimrc source %

let mapleader = ","

nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation
map <Leader>a ggVG  " select all

" Use the damn hjkl keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

set autoread " reload file when changes happen in other editors
au CursorHold * checktime
set tags=./tags

set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

set clipboard=unnamed

set history=700
set undolevels=700
set laststatus=2
set noshowmode

set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set nrformats=

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

set cursorline

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

set wildmenu
set wildmode=list:longest
set wildignore=.git,*.swp,*/tmp/*
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" found here: http://stackoverflow.com/a/2170800/70778
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction
inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" ignore E501
let g:pymode_lint_ignore = "E501"

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTree %<CR>

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

let g:gist_clip_command = 'xclip -selection clipboard'

au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab

