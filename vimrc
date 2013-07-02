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
au CursorHold * silent! checktime
set tags=./tags,tags

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

set secure
set exrc

set nowrap " don't automatically wrap on load
set tw=79  " width of document (used by gd)
set fo-=t  " don't automatically wrap text when typing
set number " show line numbers
set nomodeline

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

" found here http://stackoverflow.com/a/1919805/893870
nnoremap <Leader>H :call<SID>LongLineHLToggle()<cr>
hi OverLength ctermbg=none cterm=none
match OverLength /\%>80v/
fun! s:LongLineHLToggle()
    if !exists('w:longlinehl')
        let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
        echo "Long lines highlighted"
    else
        call matchdelete(w:longlinehl)
        unl w:longlinehl
        echo "Long lines unhighlighted"
    endif
endfunction

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
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

let g:pymode_lint_ignore = "E501,W391,C0301"
let g:pymode_lint_checker = "pyflakes,pep8,mccabe,pylint"

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

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

if !exists(":SudoWrite")
  command SudoWrite w !sudo tee > /dev/null %
endif

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
runtime macros/matchit.vim

set pastetoggle=<f5>
set hidden

map <f9> :set wrap!<cr>
vmap <leader>j ! python -m json.tool<cr>
vmap <leader>x ! tidy -i -q -xml<cr>
map <leader>w :%s/\s\+$//g<cr>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>


" https://github.com/nelstrom/vim-visual-star-search
" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star
nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
"--------------------------------------------------------------------------------

nnoremap & :&&<CR>
xnoremap & :&&<CR>

let g:pymode_breakpoint=0
let g:pymode_breakpoint_key = '<leader>R'

nmap <f11> :PyLintToggle<CR>
nmap <f10> :PyLintWindowToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F7> :! ctags -R --python-kinds=-i<CR>
nmap <leader>t :CtrlPBufTag<CR>
nmap <leader>T :CtrlPBufTagAll<CR>
nmap <leader>TT :CtrlPTag<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>B :CtrlPMRU<CR>

function WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction
command W call WriteCreatingDirs()

nmap <leader>s :set spell!<CR>
