" ___  ____           ______ _ _ _ 
" |  \/  (_)          | ___ (_) | |
" | .  . |_ _ __   ___| |_/ /_| | |
" | |\/| | | '_ \ / _ \ ___ \ | | |
" | |  | | | | | |  __/ |_/ / | | |
" \_|  |_/_|_| |_|\___\____/|_|_|_| 
" === Basic nvim Configuration ===
filetype plugin indent on
syntax on
set hidden
set number
set relativenumber
set cursorline
set showcmd
set encoding=utf-8

set incsearch
set title
set noswapfile
set nobackup
set nowb

set autoread
set undodir=~/.vimundo
set undofile

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4
set expandtab
set termguicolors
set colorcolumn=0

set nowrap
set linebreak


let g:polyglot_disabled = ['autoindent']


" === === === ===
" === Plugins ===
" === === === ===

if has('vim_starting')
 set runtimepath+=~/.config/nvim
endif

call plug#begin('~/.config/nvim/plugged')
" === Colorschemes ===
Plug 'MineBill/vim-colors'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rakr/vim-one'
Plug 'deviantfero/wpgtk.vim'
"Plug 'jaredgorski/spacecamp'
"Plug 'embark-theme/vim', { 'as': 'embark' }
"Plug 'arcticicestudio/nord-vim'
"Plug 'reewr/vim-monokai-phoenix'
"Plug 'Badacadabra/vim-archery'


" === Visual ===
"Plug 'junegunn/goyo.vim'
"Plug 'junegunn/limelight.vim'
Plug 'ap/vim-buftabline'
Plug 'voldikss/vim-floaterm'
Plug 'vim-airline/vim-airline'
"Plug 'itchyny/lightline.vim'


" === Functional ===
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-rooter'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':let coc_enabled=1'}


" === Languages ===
Plug 'sheerun/vim-polyglot'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'nvim-lua/completion-nvim'
"Plug 'neovim/nvim-lspconfig'
"Plug 'steelsojka/completion-buffers'
"Plug 'nvim-lua/diagnostic-nvim'

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

colorscheme one
"colorscheme wpgtkAlt

" === === ===  ===
" === Settings ===
" === === ===  ===

" === Generic ===
"let g:polyglot_disabled = ['autoindent']
let g:lightline = { 'colorscheme': 'wombat' }
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_powerline_fonts = 1
"let g:airline_symbols = { '∫' }
set fillchars+=vert:⏐
hi VertSplit ctermbg=NONE guibg=NONE

" === Limelight ===
let g:limelight_conceal_ctermfg = 'gray'


" === NERD Tree Settings ===
let g:NERDTreeWinSize = 25


" === Completion ===
inoremap <expr><Tab>   pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-P>" : "\<Tab>"

set completeopt=menuone,noinsert,noselect

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"


" === Vim-Rainbow ===
let g:rainbow_active = 1


" === Emmet Settings ===
let g:user_emmet_leader_key = ','


" === Key binds ===
let mapleader = " "
inoremap fd <Esc>
nnoremap ; :
nnoremap : ;

nnoremap <Leader>fed :e $MYVIMRC<CR>
nnoremap <Leader>feR :source $MYVIMRC<CR>
nnoremap <Leader>so  :source %<CR>

nnoremap m :NERDTreeToggle<CR>


" === Searching Key binds ===
nnoremap <C-n> :noh<CR>
nnoremap n nzz
nnoremap N Nzz


" === surround words with ({[< ===
nnoremap <Leader>s( diwi()<Esc>hp
nnoremap <Leader>s{ diwi{}<Esc>hp
nnoremap <Leader>s< diwi<><Esc>hp
nnoremap <Leader>s[ diwi[]<Esc>hp
nnoremap <Leader>s" diwi""<Esc>hp
nnoremap <Leader>s' diwi''<Esc>hp
"' inoremap <C-O> <Esc><S-O>


" === NERD Keybinds ===
nnoremap <Leader>of :FZF<CR>


" === Autocomplete window (CoC) ===

noremap <S-Tab> :bn<CR>
noremap <C-Tab> :bp<CR>

" === Autocommands ===
augroup HighlightYank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END


augroup Completion
    autocmd!
    autocmd BufEnter * lua require'completion'.on_attach()
augroup END


augroup ZenMode
    autocmd!
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END
