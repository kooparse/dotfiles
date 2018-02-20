filetype off
" Setup syntax highlights
set background=dark

colorscheme nord
" Everybody do that
set nocompatible
" Disable swap files
set noswapfile
" No backup file while editing
set nowritebackup
" Auto save the file when closing
set autowrite
" Hide buffer when unsaved
set hidden
" Show lines number
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
set backupcopy=yes
" Highlight search matches
set hlsearch
" Plug settings.
call plug#begin('~/.vim/plugged')
  Plug 'arcticicestudio/nord-vim'
  Plug 'racer-rust/vim-racer'
  Plug 'tpope/vim-sensible'
  Plug 'mhinz/vim-startify'
  " Better folder tree
  Plug 'scrooloose/nerdtree'
  " For search & replace
  Plug 'mileszs/ack.vim'
  " Helpers UNIX
  Plug 'tpope/vim-eunuch'
  " Pairs of handu brackets mappings
  Plug 'tpope/vim-unimpaired'
  " Enable repeating supported plugins maps
  Plug 'tpope/vim-repeat'
  " Quoting made simple
  Plug 'tpope/vim-surround'
  " Comment stuff out
  Plug 'tpope/vim-commentary'
  " Status line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Editor-config listenner
  Plug 'editorconfig/editorconfig-vim'
  " Language pack
  Plug 'sheerun/vim-polyglot'
  " Browse git url from repo
  Plug 'tpope/vim-rhubarb'
  " Linter
  Plug 'w0rp/ale'
  " Git stuff inside vim
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  " Zen mode
  Plug 'junegunn/goyo.vim'
  " Git changes in marge
  Plug 'airblade/vim-gitgutter'
  " Fuzzy file/buffer finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " Format Rust code
  Plug 'rust-lang/rust.vim'
  " JS formater
  Plug 'prettier/vim-prettier'
  " Quoting/parenthesizing made simple
  Plug 'tpope/vim-surround'

call plug#end()

" Airline configurastion
let g:airline_theme='zenburn'
let g:airline#extensions#ale#enabled = 1
let g:airline_section_y = ''
let g:airline_section_c = ''
let g:airline_section_x = ''
let g:airline_section_z = '%f'

" Gutter configuration
let g:gitgutter_override_sign_column_highlight = 0

" Ale configuration
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_javascript_prettier_use_global = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" FZF configuration (with Ag)
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND= 'ag --hidden --ignore .git -g ""'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_colors =
  \ { 'fg':    ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif
" No ext for jsx files
let g:jsx_ext_required = 0

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:40%'),
  \   <bang>0)

" Prettier configuration
let g:prettier#config#semi = 'false'
let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#singleQuote = 'true'

let mapleader = ","
inoremap jk <Esc>
nmap <Leader>b :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>s :Rg<CR>

" Remove all trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Undodir
set undodir=~/.config/vim/tmp/undo//
" Backupdir
set backupdir=~/.config/vim/tmp/backup//
" Swapfile
set directory=~/.config/vim/tmp/swap//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
 call mkdir(expand(&directory), "p")
endif

" Enable backups for Gundo
set backup
" Save the file
set undofile

let g:racer_cmd = '/Users/kooparse/.cargo/bin/racer'
let g:racer_experimental_completer = 1
let g:rustfmt_command = "rustup run nightly rustfmt"
let g:rustfmt_fail_silently = 1

au FileType rust nmap gd <Plug>(rust-def)


map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

au filetype javascript,javascript.jsx,typescript,less,scss,css,json,graphql map <leader>f :PrettierAsync<CR>
au filetype rust map <leader>f :RustFmt<CR>

" Send keys func to tmux
"
" Clear output
nmap ;l :!tmux send-keys -t right C-c C-l C-m <CR><CR>
" Compilation
au filetype rust nmap ;c :!tmux send-keys -t right C-c "cargo run" C-m <CR><CR>

" Remain compatible with earlier versions
if has ('autocmd')
  " Source vim configuration upon save
  augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif