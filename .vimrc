filetype plugin on

" Plug settings.
call plug#begin('~/.vim/plugged')
  " Themes
  Plug 'arcticicestudio/nord-vim'
  " C# and Unity
  Plug 'OmniSharp/omnisharp-vim'
  " File directory manager
  Plug 'scrooloose/nerdtree'
  " Vim defaults
  Plug 'tpope/vim-sensible'
  " Showing marks
  Plug 'kshenoy/vim-signature'
  " Snippets
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Language Server with deoplate
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  " Prettier formating for JS files
  Plug 'prettier/vim-prettier', { 'do': 'npm install' }
  " Searh & replace through quickfix
  Plug 'wincent/ferret'
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
  " A git commit browser
  Plug 'junegunn/gv.vim'
  " Zen mode
  Plug 'junegunn/goyo.vim'
  " Fuzzy file/buffer finder
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  " Quoting/parenthesizing made simple
  Plug 'tpope/vim-surround'
call plug#end()

" Setup syntax highlights
set termguicolors
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
" Highlight current line
set cursorline
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
" Format completeopt list
set completeopt=longest,menuone
set previewheight=10
" Enable backups for Gundo
set backup
" Save the file
set undofile
" Remove all trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Status line
let g:current_mode = {
      \ 'n'  : 'Normal',
      \ 'no' : 'Operator Pending',
      \ 'v'  : 'Visual',
      \ 'V'  : 'Visual Line',
      \ '^V' : 'Visual Block',
      \ 's'  : 'Select',
      \ 'S'  : 'Select Line',
      \ '^S' : 'Select Block',
      \ 'i'  : 'Insert',
      \ 'R'  : 'Replace',
      \ 'Rv' : 'Visual Replace ',
      \ 'c'  : 'Command',
      \ 'cv' : 'Vim Ex',
      \ 'ce' : 'Ex',
      \ 'r'  : 'Prompt',
      \ 'rm' : 'More',
      \ 'r?' : 'Confirm',
      \ '!'  : 'Shell',
      \ 't'  : 'Terminal',
      \ }

set statusline=
set statusline+=\ ‹‹
set statusline+=\ %{g:current_mode[mode()]}
set statusline+=\ ››
set statusline+=\ %*
set statusline+=\ %m
set statusline+=\ %f\ %*
set statusline+=\ %=
set statusline+=\ %l
set statusline+=\ ::
set statusline+=\ %c
set statusline+=\ %*

" Leader key
let mapleader = "\<Space>"
inoremap jk <Esc>

" Nord theme
let g:nord_italic = 1
let g:nord_underline = 1

" NerdTree
map <C-n> :NERDTreeToggle<CR>
" Close vim if only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" No ext for jsx files
let g:jsx_ext_required = 0

" Ale configuration
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_linters = {
  \ 'cs': ['OmniSharp']
  \ }
" Binding for moving through errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" FZF configuration (with Rg)
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND= 'rg --files --hidden -g "!.git/*"'
let g:fzf_history_dir = '~/.local/share/fzf-history'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --color=always '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:40%'),
  \   <bang>0)
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>s :Rg<CR>
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Completion and snippets
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ }
nmap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nmap <silent> gr :call LanguageClient#textDocument_rename()<CR>

" Omnisharp configuration
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_server_use_mono = 1
autocmd FileType cs nmap <Leader>1 :OmniSharpCodeFormat<CR>
call deoplete#custom#option('sources', { 'cs': ['omnisharp'] })

" Format current buffer
nmap <silent> <leader>1 :call LanguageClient#textDocument_formatting()<CR>
" Mapping for snippets
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" Select deoplate results with tab
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
"
" Format JS files
let g:prettier#autoformat = 0
autocmd FileType *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.json,*.md nmap <Leader>1 <Plug>(Prettier)

" Mapping to populate the quickfix
nmap <leader>g <Plug>(FerretAck)
" Mapping to replace the quickfix
nmap <leader>r <Plug>(FerretAcks)
" Jump to quickfix
let g:FerretAutojump=1

" Replace the word under the cursor
nmap <leader>x *``cgn
" Remove buffer without break the layout
nmap <leader>: :bp\|bd #<CR>
" Switch to previous buffer
nmap <leader><tab> :b#<CR>
" Vertical focus split
nmap <leader>v <C-w>v<C-w>l
" Swap buffers
nmap <leader>esw <ctrl-w><ctrl-x>
" Open a new terminal buffer
nmap <leader>t :vsp\|term<CR>

" In terminal mode, use esc to swith back
" to normal mode
tnoremap <esc> <c-\><c-n>

if has('nvim')
  aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  aug END
  tnoremap <c-w><c-w> <c-\><c-n><c-w><c-w>
end

" Clear Reg with command
command! WipeReg for i in range(35,122) | silent! call setreg(nr2char(i), []) | endfor

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
