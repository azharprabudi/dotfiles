" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Vim themes
Plug 'rakr/vim-two-firewatch'

" Vim icons family 
Plug 'ryanoasis/vim-devicons'

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Nerdtree family
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Airline family
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" CTRLSpace family
Plug 'vim-ctrlspace/vim-ctrlspace'

" Goyo family
Plug 'junegunn/goyo.vim'

" Indentline family
Plug 'Yggdroot/indentLine'

" Automatically set 'shiftwidth' + 'expandtab' (indention) based on file type.
Plug 'tpope/vim-sleuth'

" CTRLp family
Plug 'kien/ctrlp.vim'

" Initialize plugin system
call plug#end()

" User Configuration
" Vim themes
set background=dark
let g:two_firewatch_italics=1
colo two-firewatch

let g:airline_theme='twofirewatch'

" NERDTree git status use NerdFonts
let g:NERDTreeGitStatusUseNerdFonts = 1
let NERDTreeMapOpenInTab='\r'
let NERDTreeShowHidden=1


" Remap NERDTree
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> <C-w>w

" Remap Goyo
nnoremap <C-g> :Goyo<CR>

" Start NERDTree and leave the cursor in it
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Vim Configuration
set hidden
set encoding=utf8
set conceallevel=1
set guifont=DroidSansMono\ Nerd\ Font\ 11
set nocompatible
set expandtab
set shiftwidth=2
set autoindent
set smartindent
set backspace=indent,eol,start

" Vim Airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:CtrlSpaceDefaultMappingKey = "<C-space> "

" Show the line number
set number
set relativenumber
set termguicolors

" Remap vim tabs
nnoremap <C-j> :tabprevious<CR>                                                                            
nnoremap <C-k> :tabnext<CR>

" Indentline conf
set list lcs=tab:\|\
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 239

" CTRLp conf
let g:ctrlp_working_path_mode = 'c'