" ___  ____           ______ _ _ _ 
" |  \/  (_)          | ___ (_) | |
" | .  . |_ _ __   ___| |_/ /_| | |
" | |\/| | | '_ \ / _ \ ___ \ | | |
" | |  | | | | | |  __/ |_/ / | | |
" \_|  |_/_|_| |_|\___\____/|_|_|_|
"
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

if exists('g:neovide')
    set guifont=Victor\ Mono:h19
    let g:neovide_refresh_rate            = 140
    let g:neovide_cursor_animation_length = 0
    let g:neovide_cursor_trail_length     = 0
    let g:neovide_cursor_antialiasing     = v:true
    let g:neovide_fullscreen              = v:false
endif

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
Plug 'jaredgorski/spacecamp'
Plug 'embark-theme/vim', { 'as': 'embark' }


" === Visual ===
Plug 'frazrepo/vim-rainbow'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'ap/vim-buftabline'
Plug 'voldikss/vim-floaterm'
Plug 'vim-airline/vim-airline'
"Plug 'itchyny/lightline.vim'


" === Functional ===
Plug 'mattn/emmet-vim'
Plug 'lilydjwg/colorizer'
Plug 'preservim/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'editorconfig/editorconfig-vim'


" === Languages ===
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'nvim-lua/completion-nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'steelsojka/completion-buffers'
Plug 'nvim-lua/diagnostic-nvim'

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

"colorscheme space-vim-dark
"colorscheme space-vim-dark
"colorscheme gruvbox
colorscheme deus

" === === ===  ===
" === Settings ===
" === === ===  ===

" === NVIM LSP ===
lua << END
local lsp = require'nvim_lsp'
lsp.rust_analyzer.setup{}
lsp.tsserver.setup{}
lsp.gdscript.setup{}
lsp.clangd.setup{}
lsp.pyls.setup{}
END


" === Generic ===
let g:polyglot_disabled = ['autoindent']
let g:lightline = { 'colorscheme': 'wombat' }
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
"let g:airline_symbols = { '∫' }
set fillchars+=vert:⏐
hi VertSplit ctermbg=NONE guibg=NONE

" === Limelight ===
let g:limelight_conceal_ctermfg = 'gray'


" === NERD Tree Settings ===
let g:NERDTreeWinSize = 25


" === Completion ===
let g:completion_chain_complete_list = [
    \{ 'complete_items' : [ 'lsp', 'buffer' ] },
    \{ 'mode' : '<c-p>' },
    \{ 'mode' : '<c-n>' }
\]
let g:completion_items_priority = {
        \ 'Field': 5,
        \ 'Function': 7,
        \ 'Variables': 7,
        \ 'Method': 10,
        \ 'Interfaces': 5,
        \ 'Constant': 5,
        \ 'Class': 5,
        \ 'Keyword': 4,
        \ 'UltiSnips' : 1,
        \ 'vim-vsnip' : 0,
        \ 'Buffers' : 1,
        \ 'TabNine' : 0,
        \ 'File' : 0,
        \}
let g:completion_sorting = 'length'
set completeopt=menuone,noinsert,noselect

" Fixes conflict with the auto-pairs plugin
let g:completion_confirm_key = ""
inoremap <expr> <cr>    pumvisible() ? "\<Plug>(completion_confirm_completion)" : "\<cr>"


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


nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


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
"'

inoremap <C-O> <Esc><S-O>


" === NERD Keybinds ===
nnoremap <Leader>of :FZF<CR>


" === Autocomplete window (CoC) ===
inoremap <expr><Tab>   pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-P>" : "\<Tab>"

noremap <S-Tab> :bn<CR>
noremap <C-Tab> :bp<CR>


" === Nvim Lsp ===
nnoremap <Leader>h <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>gt <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <Leader>fmt <cmd>lua vim.lsp.buf.formatting()<CR>


" === Autocommands ===
function! EchoTest()
    echo "Test"
    echom "Message Test"
endfunction


augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END


augroup Completion
    autocmd!
    "autocmd BufEnter * lua require'completion'.on_attach()
augroup END


augroup ZenMode
    autocmd!
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END
