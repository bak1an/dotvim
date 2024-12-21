" setup plug and install plugins if they are not there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/refs/tags/0.14.0/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  " modern defaults
  Plug 'tpope/vim-sensible', { 'tag': 'v2.0' }
  " hit - to overview current folder
  Plug 'tpope/vim-vinegar', { 'commit': 'bb1bcddf43cfebe05eb565a84ab069b357d0b3d6' }
  " fuzzy files search on <space>f
  Plug 'ctrlpvim/ctrlp.vim', { 'commit': '475a864e7f01dfc5c93965778417cc66e77f3dcc' }
  " add more languages support
  Plug 'sheerun/vim-polyglot', { 'commit': 'f5393cfee07aeb666f4d75f9b3a83163862fb094' }
  " a bunch of themes, see previews at https://vimcolorschemes.com/rafi/awesome-vim-colorschemes
  Plug 'rafi/awesome-vim-colorschemes', { 'commit': 'ae5e02298c8de6a5aa98fe4d29a21874cfcc3619' }
call plug#end()

" visual
if (has("termguicolors"))
  set termguicolors
endif
syntax on
set background=dark
colorscheme hybrid_material

" the keys
let mapleader = ' '
let localleader = '\'

nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMRUFiles<CR>

map <localleader>w :%s/\s\+$//g<cr>

nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

vnoremap < <gv
vnoremap > >gv

" editor behaviour
autocmd! bufwritepost .vimrc source %

set ai
set hlsearch
set ignorecase
set smartcase
set nowrap
set number
set relativenumber
set cursorline
set showcmd

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

if !exists(":SudoWrite")
  command SudoWrite w !sudo tee > /dev/null %
endif

set secure
set exrc
