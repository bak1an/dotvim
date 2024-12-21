" setup plug and install plugins if they are not there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/refs/tags/0.14.0/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" use label mode for sneak plugin.
let g:sneak#label = 1

call plug#begin()
  " modern defaults
  Plug 'tpope/vim-sensible', { 'tag': 'v2.0' }

  " hit - to overview current folder
  Plug 'tpope/vim-vinegar', { 'commit': 'bb1bcddf43cfebe05eb565a84ab069b357d0b3d6' }

  " smart guessing of tabs/spaces size in file
  Plug 'tpope/vim-sleuth', { 'branch': 'master' }

  " working with surrounds (brackets, quotes)
  Plug 'tpope/vim-surround', { 'branch': 'master' }

  " repeats for vim-surround
  Plug 'tpope/vim-repeat', { 'branch': 'master' }

  " gc(c) to comment
  Plug 'tpope/vim-commentary', { 'branch': 'master' }

  " SudoWrite and SudoEdit live here
  Plug 'tpope/vim-eunuch', { 'branch': 'master' }

  " fuzzy files search on <space>f
  Plug 'ctrlpvim/ctrlp.vim', { 'commit': '475a864e7f01dfc5c93965778417cc66e77f3dcc' }

  " file tree
  Plug 'preservim/nerdtree', { 'commit': '9b465acb2745beb988eff3c1e4aa75f349738230' }

  " add more languages support
  Plug 'sheerun/vim-polyglot', { 'commit': 'f5393cfee07aeb666f4d75f9b3a83163862fb094' }

  " better %
  Plug 'https://github.com/adelarsq/vim-matchit', { 'commit': 'f52e59b05a937fe3102d431dd23f8ae4d8752ba3' }

  " faster moving around the file
  Plug 'justinmk/vim-sneak', { 'commit': 'c13d0497139b8796ff9c44ddb9bc0dc9770ad2dd' }

  " nice and shiny status line
  Plug 'vim-airline/vim-airline', { 'commit': '7a552f415c48aed33bf7eaa3c50e78504d417913' }

  " a bunch of themes, see previews at https://vimcolorschemes.com/rafi/awesome-vim-colorschemes
  Plug 'rafi/awesome-vim-colorschemes', { 'commit': 'ae5e02298c8de6a5aa98fe4d29a21874cfcc3619' }

  " highlight indent levels, <leader>ig to toggle
  Plug 'preservim/vim-indent-guides', { 'commit': 'a1e1390c0136e63e813d051de2003bf0ee18ae30' }
call plug#end()

" visual
  if (has("termguicolors"))
    set termguicolors
  endif
  syntax on
  set background=dark

  " change your theme here
  colorscheme hybrid_material

  " simplify right part of airline a bit
  au User AirlineAfterInit :let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])

" the keys
  let mapleader = ' '
  let maplocalleader = '\'

  " <space>f for fuzzy file search
  nnoremap <leader>f :CtrlP<CR>
  " <space>b for fuzzy buffers search
  nnoremap <leader>b :CtrlPBuffer<CR>
  " <space>m for mru files search
  nnoremap <leader>m :CtrlPMRUFiles<CR>

  " <space>e to toggle file tree
  nnoremap <leader>e :NERDTreeToggle<CR>
  " <space>E to reveal current file in tree
  nnoremap <leader>E :NERDTreeFind<CR>

  " gw to jump around file with labels, see sneak plugin
  " 2-character Sneak
  nmap gw <Plug>Sneak_s
  nmap gW <Plug>Sneak_S
  " visual-mode
  xmap gw <Plug>Sneak_s
  xmap gW <Plug>Sneak_S
  " operator-pending-mode
  omap gw <Plug>Sneak_s
  omap gW <Plug>Sneak_S

  " clean trailing whitespaces with \w
  map <localleader>w :%s/\s\+$//g<cr>

  " toggle spellcheck with \s
  map <localleader>s :set spell!<cr>

  " twice faster scrolling with C-e and C-y
  nnoremap <C-e> 2<C-e>
  nnoremap <C-y> 2<C-y>

  " when changing indent with > or < in visual mode - reselect it again right after
  vnoremap < <gv
  vnoremap > >gv

" editor behaviour
  " reload .vimrc when edited
  autocmd! bufwritepost .vimrc source %

  " better default search params
  set hlsearch
  set ignorecase
  set smartcase

  " do not break long lines
  set nowrap
  set textwidth=0

  " show line numbers and cursor and cmd
  set number
  set relativenumber
  set cursorline
  set showcmd

  " auto indent + default indent params (vim-sleuth will magically adjust this in actual file)
  set ai
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set shiftround
  set expandtab

  " syntax based folding, all open by default
  set foldmethod=syntax
  set foldlevel=99

  " highlight trailing whitespaces in red
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()

  " fuzzy search will show hidden files as well
  let g:ctrlp_show_hidden = 1

  " get extra configs from .exrc in current folder but do not fully trust it
  set secure
  set exrc
