" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
let mapleader =","

" Behavior
syntax on
syntax enable

filetype on
filetype plugin on
filetype indent on

set ttimeoutlen=0
set updatetime=300
set splitbelow splitright
set conceallevel=0

set autoindent
set smartindent
set cindent
set cinoptions=g0,:0,N-s,(0

set noexpandtab
set foldmethod=indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab


set wrap
set linebreak
set nolist
set shortmess+=c
set whichwrap+=<,>,h,l
set virtualedit=block,onemore
set backspace=2
set sidescroll=10

set hlsearch
set incsearch
set ignorecase
set smartcase

set autoread
set autowrite
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.nvim/undodir
set undofile
nnoremap c "_c

set nocompatible
set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,gbk,cp936,gb2312,gb18030

" vim-interface
set t_Co=256
if has('termguicolors')
    set termguicolors
endif
set noeb
set mouse=a
set hidden
set showcmd
set ruler
set cursorline
set number relativenumber
set cmdheight=3
set laststatus=2
set showtabline=2
set noshowmode
set nofoldenable
set signcolumn=auto

" Command Completion
set wildmenu
set wildmode=longest:full,full
set completeopt=menu,menuone,noselect


" Vim-Plug init
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" Vim-Plug Plugins

call plug#begin('~/.config/nvim/plugged')

Plug 'kyazdani42/nvim-web-devicons'
Plug 'glepnir/galaxyline.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/nvim-bufferline.lua'

Plug 'junegunn/vim-easy-align'
Plug 'itchyny/vim-cursorword'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'sbdchd/neoformat'
Plug 'airblade/vim-gitgutter'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'windwp/nvim-ts-autotag'
Plug 'rhysd/accelerated-jk'
Plug 'vimlab/split-term.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'onsails/lspkind-nvim'
Plug 'glepnir/lspsaga.nvim'
" Plug 'hrsh7th/nvim-compe'
Plug 'ray-x/lsp_signature.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'vim-scripts/c.vim'
Plug 'rust-lang/rust.vim'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'altercation/vim-colors-solarized'

call plug#end()

" colorscheme solarized
colorscheme koehler
"" clear the color of signcolumn
highlight clear SignColumn

" Edit Setting
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" autoformat after saved
" augroup fmt
"	autocmd!
"	let blacklist = ['org']
"	autocmd BufWritePre * if index(blacklist, &ft) < 0 | undojoin | Neoformat
" augroup END

augroup RELOAD
	autocmd!
	" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

	" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e
augroup END

" Automatically change work directory
autocmd BufEnter * silent! lcd %:p:h

autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType c,cpp,cc setlocal tabstop=4
autocmd FileType rust setlocal tabstop=4

" Init.vim Setting
imap jj <Esc>
nnoremap <leader><leader>v :tabe $MYVIMRC<cr>

" Plug Setting
" nnoremap <leader><leader>i :PlugInstall<cr>
" nnoremap <leader><leader>u :PlugUpdate<cr>
" nnoremap <leader><leader>c :PlugClean<cr>

" Common Settings
nnoremap <A-r> :@:<cr>
nnoremap <A-s> :lua require "lsp_signature".on_attach()<cr>

" Clipboard
set go=a
set clipboard+=unnamedplus

" Clipboard Remap
vnoremap <leader>y  "+y
nnoremap <leader>Y  "+yg_
nnoremap <leader>y  "+y
nnoremap <leader>yy  "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" TagBar
nmap <leader>t :TagbarToggle<cr>

" Split Navigation shortcuts
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Buffer Navigation
noremap <A-q> :bw<cr>
noremap <A-S-q> :bw!<cr>

" Keep selection after shift
vnoremap < <gv
vnoremap > >gv

" Accelerated J/K
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" Split-vim terminal
noremap <F5> :Term<CR>
noremap <C-w>t :Term<CR>
noremap <C-w>T :VTerm<CR>

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Bufferline
noremap <A-j> :BufferLineCycleNext<cr>
noremap <A-k> :BufferLineCyclePrev<cr>

" lspsaga
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent> gd :Lspsaga preview_definition<CR>
autocmd CursorHold * Lspsaga show_line_diagnostics
nnoremap <silent> g[ :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> g] :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>
highlight link LspSagaFinderSelection Search

" MarkdownPreview
noremap <F12> :MarkdownPreviewToggle<CR>

" Sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

autocmd FileType rust nmap <leader>mbb :Cbuild<cr>
autocmd FileType rust nmap <leader>mbt :Ctest<cr>
autocmd FileType rust nmap <leader>mbr :Crun<cr>
