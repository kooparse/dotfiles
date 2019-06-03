"
" I use some external libraries.
" On macOS, you should run `brew install fzf bat ripgrep` before using
" this vimrc.
"
filetype plugin on

" Plug settings.
call plug#begin('~/.vim/plugged')
  " Themes
  Plug 'chriskempson/base16-vim'
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
  " Helpers UNIX
  Plug 'tpope/vim-eunuch'
  " Make the yanked region apparent
  Plug 'machakann/vim-highlightedyank'
  " Enable repeating supported plugins maps
  Plug 'tpope/vim-repeat'
  " Quoting made simple
  Plug 'tpope/vim-surround'
  " Comment stuff out
  Plug 'tpope/vim-commentary'
  " Language pack
  Plug 'sheerun/vim-polyglot'
  " Typecript highlightss (polyglot is fucked)
  Plug 'HerringtonDarkholme/yats.vim'
  " Ron file
  Plug 'ron-rs/ron.vim'
  " Linter
  Plug 'w0rp/ale'
  " Git stuff inside vim
  Plug 'tpope/vim-fugitive'
  " A git commit browser
  Plug 'junegunn/gv.vim'
  " Browse git url from repo
  Plug 'tpope/vim-rhubarb'
  " Zen mode
  Plug 'junegunn/goyo.vim'
  " Fuzzy finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " C# and Unity
  " Plug 'OmniSharp/omnisharp-vim', { 'branch': 'type_highlighting' }
  "
  " Auto-completer + LSP
  " Plug 'zxqfl/tabnine-vim'
  " Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
call plug#end()

" Setup syntax highlights
set termguicolors
set background=dark
" Contrast + Colorscheme
colo base16-gruvbox-dark-hard
" No column bg and darker fg
highlight LineNr guibg=0 guifg=#665c54
highlight SignColumn guibg=0 guifg=#665c54

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
set gdefault
" Format completeopt list
set completeopt=noinsert,menuone,noselect
set previewheight=10
" Always draw the signcolumn
set signcolumn=yes
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

" Active completion with Ale
let g:ale_completion_enabled = 1
" Ale configuration
let g:ale_sign_column_always = 1
" Linting only when saving
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_linters = {
      \ 'cs': ['OmniSharp'],
      \ 'typescript': ['tsserver'],
      \ 'rust': ['rls'],
      \ 'go': ['gometalinter', 'gofmt']
      \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'cs': ['uncrustify'],
      \ 'rust': ['rustfmt'],
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'css': ['prettier'],
      \ 'go': ['gofmt']
      \ }

" Javascript Ale rules
let g:jsx_ext_required = 0
" Ale bindings
nmap <leader>q <Plug>(ale_fix)
" nmap <silent> gd :ALEGoToDefinition<CR>
" Binding for moving through errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Coc configuration
nmap <silent> gd <Plug>(coc-definition)

" Unity configuration
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_start_server = 0
let g:OmniSharp_port = 2000
autocmd FileType cs nmap <Leader>1 :OmniSharpCodeFormat<CR>

" FZF configuration (with Rg)
let $FZF_PREVIEW_COMMAND = 'bat --style=numbers --color=always --theme="1337" {}'
let $FZF_DEFAULT_COMMAND= 'rg --files --hidden -g "!{.git/*}"'
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_buffers_jump = 1
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --color=always '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:40%'),
  \   <bang>0)

" Bind Fuzzy search cmd
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>s :Rg<Space>

" Mapping to populate the quickfix
nmap <leader>g <Plug>(FerretAck)
" Mapping to replace the quickfix
nmap <leader>r <Plug>(FerretAcks)
" Jump to quickfix
let g:FerretAutojump=1
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
nmap <leader>C :!cargo run<CR>
" Better split navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
" nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>
" Swap current line
nmap ]e :m+<CR>
nmap [e :m-2<CR>
" Add newlines before and after the cursor line
nmap [<space> O<Esc>j
nmap ]<space> o<Esc>k
" Open folder for current project.
nmap <leader>o :!open .<CR>
" Break line on cursor position
nmap <C-cr> i<CR><Esc>
" Search results centered please
nmap <silent> n nzz
nmap <silent> N Nzz
nmap <silent> * *zz
nmap <silent> # #zz
nmap <silent> g* g*zz

" Auto source/reload vimrc on save
augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END
