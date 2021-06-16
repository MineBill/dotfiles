"  __  __ _            ____  _ _ _ 
" |  \/  (_)_ __   ___| __ )(_) | |
" | |\/| | | '_ \ / _ \  _ \| | | |
" | |  | | | | | |  __/ |_) | | | |
" |_|  |_|_|_| |_|\___|____/|_|_|_|
" MineBill's neovim configuration file

nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
" Settings {{{
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
set foldlevel=100
set foldmethod=indent

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

set nowrap
set linebreak
set clipboard=unnamedplus
set completeopt=menuone

set guicursor=
set guifont=Noto\ Sans\ Mono\ Nerd\ Font:h18
" set guifont=mononoki\ Nerd\ Font:h20

" -------------------------------
"  Neovide-specific settings
let g:neovide_refresh_rate=140
let g:neovide_transparency=0.99
let g:neovide_cursor_animation_length=0.0
let g:neovide_cursor_trail_length=0.0

let g:nim_nep1=1

if has('mouse')
    set mouse=nv  " Enable mouse in several mode
    set mousemodel=popup  " Set the behaviour of mouse
endif

if has('vim_starting')
 set runtimepath+=~/.config/nvim
endif

lua require('plugins')
lua require('lsp_config')
lua require('compe_config')

let g:netrw_banner = 0

" colorscheme ayu
colorscheme colzig
" }}}

" Keybinds {{{
let mapleader = " "
let maplocalleader = "\\"
inoremap fd <Esc>
inoremap φδ <Esc>

nnoremap ; :
nnoremap : ;

nnoremap J <Nop>
nnoremap K <Nop>
vnoremap J <Nop>
vnoremap K <Nop>

inoremap <C-j> <Down>
inoremap <C-k> <Up>

cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

nnoremap <C-j> <CMD>call TermToggle(15)<CR>
tnoremap <C-j> <CMD>call TermToggle(15)<CR>
tnoremap <Esc> <C-\><C-n>

vnoremap <C-j> <Down>
vnoremap <C-k> <Up>

nnoremap <Leader>fed :e $MYVIMRC<CR>
nnoremap <Leader>feR :source $MYVIMRC<CR>
nnoremap <Leader>so  :source %<CR>

" Searching Key binds
nnoremap <C-n> :noh<CR>
nnoremap n nzz
nnoremap N Nzz

" File operations
noremap <S-Tab> :bn<CR>
noremap <C-Tab> :bp<CR>

nnoremap <silent> <C-p> :Telescope find_files<CR>
nnoremap <silent> <C-b> :Telescope buffers<CR>
nnoremap m :NERDTreeToggle<CR>
" Terminal
" }}}

" Autocommands {{{
" autocmd BufEnter * lua require'completion'.on_attach()
autocmd BufEnter *.zig set ft=zig
augroup HighlightYank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

augroup ZenMode
    autocmd!
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
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
" }}}
