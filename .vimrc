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
  Plug 'w0rp/ale'
  " Git stuff inside vim
  Plug 'tpope/vim-fugitive'
  " A git commit browser
  Plug 'junegunn/gv.vim'
  " Zen mode
  Plug 'junegunn/goyo.vim'
  " Auto-completer + LSP
  " Plug 'neovim/nvim-lsp'
  " Fuzzy finder
  Plug 'liuchengxu/vim-clap', { 'do': function('clap#helper#build_all') }
call plug#end()

" Setup syntax highlights
set termguicolors
set background=dark
" Contrast + Colorscheme
colo desert-night
hi Normal guifg=#d4b07b guibg=#042327 guisp=NONE gui=NONE cterm=NONE
hi VertSplit guifg=#473f31 guibg=#042327 guisp=NONE gui=NONE cterm=NONE

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
map <C-n> :NERDTreeToggle<CR>

" LSP configuration.
" With Ale and soon LSP built-in.
let g:ale_linters = {
      \ 'rust': ['rls'],
      \ }

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'cs': ['uncrustify'],
      \ 'rust': ['rustfmt'],
      \ 'html': ['prettier'],
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'typescriptreact': ['prettier'],
      \ 'css': ['prettier'],
      \ 'markdown': ['prettier'],
      \ 'go': ['gofmt']
      \ }
" Javascript Ale rules
let g:jsx_ext_required = 0

" Autocomplete Omnifunc.
let g:ale_set_balloons = 1
let g:ale_completion_enabled = 1
" Native way...
" set omnifunc=lsp#omnifunc
" autocmd CompleteDone * pclose

" Bindings.
nmap <leader>q <Plug>(ale_fix)
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gh  :ALEHover<CR>
" nmap <silent> <C-k> <Plug>(ale_previous_wra)
" nmap <silent> <C-j> <Plug>(ale_next)

" Native way...
" nmap <silent> gd :call lsp#text_document_definition()<CR>
" nmap <silent> gh  :call lsp#text_document_hover()<CR>

nmap <Leader>b :Clap buffers<CR>
nmap <Leader>f :Clap files<CR>
nmap <Leader>s :Clap grep<CR>

hi ClapInput guibg=#031b1f
hi ClapSpinner gui=bold guibg=#031b1f
hi ClapMatches gui=bold guifg=#99b05f guibg=#303a1a
hi ClapCurrentSelection gui=bold guibg=#031b1f
hi ClapDisplay guibg=#031b1f
hi ClapPreview guibg=#042327


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
" Compile and check programs (Rust)
nmap <leader>c :!cargo check<CR>
" Compile and run programs (Rust)
nmap <leader>C :!cargo run --release<CR>
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

" call lsp#add_filetype_config({
"       \ 'filetype': 'rust',
"       \ 'name': 'rls',
"       \ 'cmd': 'rls',
"       \ 'capabilities': {
"       \   'clippy_preference': 'on',
"       \   'all_targets': v:false,
"       \   'build_on_save': v:true,
"       \   'wait_to_build': 0
"       \ }})

" Auto source/reload vimrc on save
augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END
