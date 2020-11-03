" ___  ____           ______ _ _ _ 
" |  \/  (_)          | ___ (_) | |
" | .  . |_ _ __   ___| |_/ /_| | |
" | |\/| | | '_ \ / _ \ ___ \ | | |
" | |  | | | | | |  __/ |_/ / | | |
" \_|  |_/_|_| |_|\___\____/|_|_|_| 
" === Basic nvim Configuration ===
set langmap=ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz
filetype plugin indent on
syntax on
set hidden
set number
set relativenumber
set cursorline
set showcmd
set encoding=utf-8
set signcolumn=number

set inccommand=nosplit
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
set colorcolumn=140
set fillchars+=vert:│
set foldmethod=marker

set nowrap
set linebreak
set clipboard=unnamedplus

if has('mouse')
    set mouse=nv  " Enable mouse in several mode
    set mousemodel=popup  " Set the behaviour of mouse
endif

set guifont=InconsolataLGC\ Nerd\ Font\ Mono:h22

let g:polyglot_disabled = ['autoindent']

" === === === ===
" === Plugins ===
" === === === ===

if has('vim_starting')
 set runtimepath+=~/.config/nvim
endif

call plug#begin('~/.config/nvim/plugged') " === Colorschemes ===
    Plug 'MineBill/vim-colors'
    Plug 'rakr/vim-one'

    Plug 'shougo/unite.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'MineBill/vim-cmake'
    Plug 'moll/vim-bbye'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vlime/vlime', {'rtp': 'vim/'}
    Plug 'itmecho/bufterm.nvim'
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    Plug 'sainnhe/sonokai'
    Plug 'glepnir/zephyr-nvim'
    "Plug 'TaDaa/vimade'

    " === Visual ===
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    "Plug 'ap/vim-buftabline'
    Plug 'voldikss/vim-floaterm'
    Plug 'vim-airline/vim-airline'
    "Plug 'itchyny/lightline.vim'


    Plug 'https://github.com/MineBill/coc-cord', {'branch': 'logging', 'do': 'yarn install --frozen-lockfile && yarn build'}


    " === Functional ===
    Plug 'mattn/emmet-vim'
    Plug 'preservim/nerdcommenter'
    Plug 'airblade/vim-rooter'
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':let coc_enabled=1'}
    Plug 'bkad/CamelCaseMotion'


    " === Languages ===
    Plug 'sheerun/vim-polyglot'
    Plug 'nvim-lua/completion-nvim'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'dense-analysis/ale'
    "Plug 'neovim/nvim-lspconfig'
    "Plug 'steelsojka/completion-buffers'
    "Plug 'nvim-lua/diagnostic-nvim'

    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } 
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()
colorscheme sonokai

" === === ===  ===
" === Settings ===
" === === ===  ===

" === Generic ===
"let g:polyglot_disabled = ['autoindent']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

let g:camelcasemotion_key = "<Leader>"

" === Limelight ===
let g:limelight_conceal_ctermfg = 'gray'


" === NERD Tree Settings ===
let g:NERDTreeWinSize = 25


" === Completion ===
inoremap <expr><Tab>   pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-P>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"
set completeopt=menuone,noinsert,noselect


" === Ale Options ===
let g:ale_haskell_ghc_options = "-fno-code -v0 -dynamic"


" === Emmet Settings ===
let g:user_emmet_leader_key = ','


lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = false, -- Use this to enable language injection (this is very unstable)
  },
}
EOF


"{{ === Key binds ===
let mapleader = " "
let maplocalleader = "\\"
inoremap fd <Esc>
nnoremap ; :
nnoremap : ;

nnoremap J <Nop>
nnoremap K <Nop>
vnoremap J <Nop>
vnoremap K <Nop>

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

"nnoremap <Leader>b :Unite buffer<CR>
"nnoremap <Leader>f :Unite file<CR>

" === File operations ===
nnoremap <Leader>fo :FZF<CR>
nnoremap <Leader>fw :w<CR>


" === Autocomplete window (CoC) ===
noremap <S-Tab> :bn<CR>
noremap <C-Tab> :bp<CR>


" === CoC Keybinds ===
nnoremap <silent> gh :call CocActionAsync('doHover')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
"nmap <silent> <C-[> <Plug>(coc-diagnostic-prev)
"nmap <silent> <C-]> <Plug>(coc-diagnostic-next)
nmap <silent> <C-[> <Plug>(ale_previous_wrap)
nmap <silent> <C-]> <Plug>(ale_next_wrap)


" === ALE Keybinds ===
nnoremap <Leader>ad :ALEDetail<CR>


" === CMake Keybinds ===
nnoremap <Leader>cg :CMakeGenerate<CR>
nnoremap <Leader>cb :CMakeBuild<CR>
nnoremap <Leader>cc :CMakeClean<CR>
nnoremap <Leader>co :CMakeOpen<CR>


" === Git Keybinds ===
nnoremap <Leader>gs :Git status<CR>
nnoremap <Leader>ga :Git add
nnoremap <Leader>gA :Git add -A<CR>
nnoremap <Leader>gc :Git commit<CR>


nnoremap <Leader>bd :Bd<CR>
nnoremap <Leader>r :RnvimrToggle<CR>

" }}

function! FormatCppOnSave()
    let l:formatdiff = 1
    pyf /usr/share/clang/clang-format.py
endfunction


" === Autocommands ===
autocmd BufWritePre *.hpp,*.h,*.cc,*.cpp call FormatCppOnSave()

augroup HighlightYank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END


augroup ZenMode
    autocmd!
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END


augroup CMake
    autocmd!
    autocmd User CMakeCommandOk call cmake#console#Close()
augroup END

" VSCode-like popup terminal
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new __term__
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            setlocal hidden bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nospell nonu norelativenumber winfixheight nomodifiable
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <Leader>tt <CMD>BufTermToggle<CR>
tnoremap <Esc> <C-\><C-n>
