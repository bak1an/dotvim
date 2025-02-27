" setup plug and install plugins if they are not there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/refs/tags/0.14.0/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" use label mode for sneak plugin.
let g:sneak#label = 1

" only tag what is tracked by git
let g:gutentags_file_list_command = 'git ls-files'

" ignore more things in ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|tags'

" will skip ctags plugins and keybinds if there is no ctags in the system
let s:ctags_present = executable('ctags')

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

  " faster replaces with [count]["x]gr{motion} ([count]grr for lines)
  Plug 'vim-scripts/ReplaceWithRegister', { 'commit': '832efc23111d19591d495dc72286de2fb0b09345' }

  " indent level as a text object
  Plug 'michaeljsmith/vim-indent-object', { 'commit': '8ab36d5ec2a3a60468437a95e142ce994df598c6' }

  " git changes signs
  Plug 'airblade/vim-gitgutter', { 'commit': '7b0b5098e3e57be86bb96cfbf2b8902381eef57c' }

  " git is here
  Plug 'tpope/vim-fugitive', { 'commit': 'fcb4db52e7f65b95705aa58f0f2df1312c1f2df2' }

  if s:ctags_present
    " tagbar
    Plug 'preservim/tagbar', { 'commit': '5e090da54bf999c657608b6c8ec841ef968d923d' }

    " automatic tags generation
    Plug 'ludovicchabant/vim-gutentags', { 'commit': 'aa47c5e29c37c52176c44e61c780032dfacef3dd' }
  endif

  " fuzzy files search on <space>f
  Plug 'ctrlpvim/ctrlp.vim', { 'commit': '475a864e7f01dfc5c93965778417cc66e77f3dcc' }

  " file tree
  Plug 'preservim/nerdtree', { 'commit': '9b465acb2745beb988eff3c1e4aa75f349738230' }

  " add more languages support
  Plug 'sheerun/vim-polyglot', { 'commit': 'f5393cfee07aeb666f4d75f9b3a83163862fb094' }

  " better %
  Plug 'adelarsq/vim-matchit', { 'commit': 'f52e59b05a937fe3102d431dd23f8ae4d8752ba3' }

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

  highlight! link SignColumn LineNr

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

  if s:ctags_present
    " \e to toggle tagbar
    nnoremap <localleader>e :TagbarToggle<CR>
    " \E to reveal current tag
    nnoremap <localleader>E :TagbarOpen fj<CR>
    " <space>t for tag search
    nnoremap <leader>t :CtrlPTag<CR>
  endif

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

  " window resizing keymaps using Alt + Arrow keys
  noremap <silent> <M-Left> :vertical resize -2<CR>
  noremap <silent> <M-Right> :vertical resize +2<CR>
  noremap <silent> <M-Down> :resize -2<CR>
  noremap <silent> <M-Up> :resize +2<CR>

  " when changing indent with > or < in visual mode - reselect it again right after
  vnoremap < <gv
  vnoremap > >gv

" editor behaviour
  " reload .vimrc when edited
  autocmd! bufwritepost .vimrc source %

  " make vim ui faster
  set updatetime=250

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

" language specific configs
  autocmd FileType yaml setlocal foldmethod=indent
  autocmd FileType vim setlocal foldmethod=indent

" get extra configs from .exrc in current folder but do not fully trust it
set secure
set exrc
