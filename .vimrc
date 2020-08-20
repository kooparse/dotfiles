"
" I use some external libraries.
" On macOS, you should run `brew install fzf bat ripgrep` before using
" this vimrc.
"
filetype plugin on

" Plug settings.
call plug#begin('~/.vim/plugged')
  " Themes
  Plug 'kooparse/vim-color-desert-night'
  Plug 'kooparse/boredom-colors'
  Plug 'arcticicestudio/nord-vim'
  Plug 'dracula/vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'cocopon/colorswatch.vim'
  " Simple status bar
  Plug 'itchyny/lightline.vim'
  " File directory manager
  Plug 'scrooloose/nerdtree'
  " Vim defaults
  Plug 'tpope/vim-sensible'
  " Showing marks
  Plug 'kshenoy/vim-signature'
  " Searh & replace through quickfix
  Plug 'wincent/ferret'
  " Make the yanked region apparent
  Plug 'machakann/vim-highlightedyank'
  " Helpers UNIX
  Plug 'tpope/vim-eunuch'
  " Enable repeating supported plugins maps
  Plug 'tpope/vim-repeat'
  " Quoting made simple
  Plug 'tpope/vim-surround'
  " Comment stuff out
  Plug 'tpope/vim-commentary'
  " Language pack
  Plug 'sheerun/vim-polyglot'
  " Linter
  " Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  " Git stuff inside vim
  Plug 'tpope/vim-fugitive'
  " A git commit browser
  Plug 'junegunn/gv.vim'
  " Zen mode
  Plug 'junegunn/goyo.vim'
  " Auto-completer + LSP
  " Plug 'neovim/nvim-lsp'
  " Fuzzy finder
  Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
call plug#end()

" Setup syntax highlights
set termguicolors
set background=dark
" Contrast + Colorscheme
colo custom

" Colorize lightline + add relative path
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }

" Everybody do that
set nocompatible
" Scrolling offset
set scrolloff=3
" Turn on auto indent
set autoindent
" Disable swap files
set noswapfile
" No backup file while editing
set nowritebackup
" Auto save the file when closing
set autowrite
" Hide buffer when unsaved
set hidden
" Highlight current line
set cursorline
" Hide lines number
set number
" Show existing tabs with 2 spaces
set tabstop=2
" When indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tabs, insert 2 spaces
set expandtab
" Mode in status bar
set noshowmode
" Browse files in same dir as open file
set browsedir=buffer
" Better split characters
set fillchars=vert:\ ,stl:\ ,stlnc:\
" Highlight search matches
set hlsearch
set incsearch
set ignorecase
set smartcase
" Global flag for search by default
set gdefault
" Format completeopt list
set completeopt=noinsert,menuone,noselect
set previewheight=10
" Always draw the signcolumn
set signcolumn=yes
" Mouse support
set mouse=a
" Open new vertical split to the right by default
set splitright
set splitbelow
set switchbuf="useopen, vsplit"
" Bind vim grep to ripgrep
set grepprg=rg\ --no-heading\ --vimgrep
set grepformat=%f:%l:%c:%m
" Search
set wildmenu
set wildmode=list:full
set wildignore+=*/node_modules/*
" Undodir
set undodir=~/.config/vim/tmp/undo//
set undofile

" Leader key
let mapleader = "\<Space>"
" NerdTree
let NERDTreeShowHidden = 1
map <C-n> :NERDTreeToggle<CR>

" Bindings.
nmap <Leader>b :Clap buffers<CR>
nmap <Leader>f :Clap files<CR>
nmap <Leader>s :Clap grep2<CR>
let g:clap_use_pure_python = 1

" Coc LSP.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" nmap <leader>j <Plug>(coc-diagnostic-prev)
" nmap <leader>k <Plug>(coc-diagnostic-next)
nmap <leader>q <Plug>(coc-format)

nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call <SID>show_documentation()<CR>
set updatetime=300

" lua require'nvim_lsp'.rust_analyzer.setup({})
" nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
" set omnifunc=v:lua.vim.lsp.omnifunc


" Fuzzy search theme.
let g:clap_insert_mode_only = 1
let g:clap_theme = 'material_design_dark'

" Jump to quickfix
let g:FerretAutojump=1
" Mapping to populate the quickfix
nmap <leader>g <Plug>(FerretAck)
" Mapping to replace the quickfix
nmap <leader>r <Plug>(FerretAcks)

" Copy & paste to system clipboard
nmap <leader>p "+p
vmap <leader>y "+y
" open vimrc file
nmap <leader>ev :e ~/.vimrc<CR>
nmap <leader>es :e ~/.vim/lua/custom.lua<CR>
" Toggles between buffers
nmap <leader><leader> <c-^>
" Focus next pane
nmap <leader>w <C-w><C-w>
" Search current buffer siblings
nmap <leader>n :e %:h/
" Search current buffer siblings and throw it in a right pane
nmap <leader>N :vsp \| drop %:h/
" Replace the word under the cursor
nmap <leader>x *``cgn
" Vertical focus split
nmap <leader>v <C-w>v<C-w>l

" Compile/run and check programs for C.
autocmd BufEnter *.c,*h nmap <leader>c :!make compile<CR>
autocmd BufEnter *.c,*h nmap <leader>C :!make run<CR>
" Compile/run and check programs for C++.
autocmd BufEnter *.cpp,*hpp nmap <leader>c :!make compile<CR>
autocmd BufEnter *.cpp,*hpp nmap <leader>C :!make run<CR>
" Compile/run and check programs for Rust.
autocmd BufEnter *.rs,*.toml nmap <leader>c :!cargo check<CR>
autocmd BufEnter *.rs,*.toml nmap <leader>C :!cargo run --release<CR>
" Compile/run and check programs for Zig.
autocmd BufEnter *.zig nmap <leader>c :!zig build-exe src/main.zig<CR>
autocmd BufEnter *.zig nmap <leader>C :!zig run src/main.zig<CR>

" Better split navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
" nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>
" Swap current line
nmap ]e :m+<CR>
nmap [e :m-2<CR>
" Add newlines before and after the cursor line
nmap <leader>k O<Esc>j
nmap <leader>j o<Esc>k
" Open folder for current project
nmap <leader>o :!open .<CR>
" Break line on cursor position
nmap <C-cr> i<CR><Esc>
" Search results centered please
nmap <silent> n nzz
nmap <silent> N Nzz
nmap <silent> * *zz
nmap <silent> # #zz
nmap <silent> g* g*zz
nmap <leader>m :call SynStack()<CR>

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Auto source/reload vimrc on save
augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END
