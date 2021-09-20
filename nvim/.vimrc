" TODO: * Add snippets plugin
"       * Switch to buffers instead of tabs
"       * Go through keybinds

set shell=/bin/bash

" Leader
let mapleader   = "\<space>"
let localleader = "\<space>"
let g:mapleader = "\<space>"
let maplocalleader = "\<space>"

" VIM enhancements
Plug 'ciaranm/securemodelines'          " Prevent insecure tab configuration
    let g:secure_modelines_allowed_items = [
        \ "textwidth",   "tw",
        \ "softtabstop", "sts",
        \ "tabstop",     "ts",
        \ "shiftwidth",  "sw",
        \ "expandtab",   "et",   "noexpandtab", "noet",
        \ "filetype",    "ft",
        \ "foldmethod",  "fdm",
        \ "readonly",    "ro",   "noreadonly", "noro",
        \ "rightleft",   "rl",   "norightleft", "norl",
        \ "colorcolumn"
        \ ]
Plug 'preservim/nerdcommenter'          " Commenting stuff
Plug 'editorconfig/editorconfig-vim'    " For standardising code-style via .editorconfig files
Plug 'justinmk/vim-sneak'               " Jump to any location specified by two characters
    let g:sneak#s_next = 1
    let g:sneak#label = 1               " Vimium-style navigation
Plug 'terryma/vim-expand-region'        " Select increasingly large regions of text
                                        " TODO: look at keybinds
    map K <Plug>(expand_region_expand)
    map J <Plug>(expand_region_shrink)

" tpope magic
Plug 'tpope/vim-surround'               " Make replacing quotes and such easier (cs)
Plug 'tpope/vim-repeat'                 " Repeat more actions
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-sensible'
"
Plug 'andymass/vim-matchup'             " Navigate between sets of matching texts (%)
Plug 'terryma/vim-smooth-scroll'        " Because it is fancy
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
    noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
    noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" Statusline/tabline
"Plug 'mengelbrecht/lightline-bufferline'
"Plug 'itchyny/lightline.vim'
    "let g:lightline = {
        "\ 'colorscheme': 'material',
        "\ 'active': {
        "\   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
        "\ },
        "\ 'tabline': {
        "\   'left': [ ['buffers'] ],
        "\   'right': [ ['close'] ]
        "\ },
        "\ 'component_expand': {
        "\   'buffers': 'lightline#bufferline#buffers'
        "\ },
        "\ 'component_type': {
        "\   'buffers': 'tabsel'
        "\ }
    "\ }


" Auto insert matching delimiters
" Plug 'Raimondi/delimitMate'
    " Disable auto-closing for tags to ensure closetag can do its thing
    "let delimitMate_matchpairs = "(:),[:],{:}"
    "autocmd! FileType html,xhtml,phtml,liquid let b:delimitMate_matchpairs = "(:),[:],{:}"

"" webdev (yuck)
"Plug 'alvan/vim-closetag'
    "let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.liquid'
    "let g:closetag_filetypes = '*.html,*.xhtml,*.phtml,*.liquid'

" ctag bar
" XXX: Might delete this and just use the quickfix bar instead
Plug 'majutsushi/tagbar'

" Undo trees
Plug 'sjl/gundo.vim'
    let g:gundo_prefer_python3 = 1

" Latex
Plug 'lervag/vimtex'
    let g:tex_flavor = 'latex'
    "let g:vimtex_fold_enabled = 1
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_compiler_progname = 'nvr'
    let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-shell-escape',
      \   '-xelatex',
      \   '-verbose',
      \   '-file-line-error',
      \   '-interaction=nonstopmode'
      \ ]}

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
    let g:mkdp_auto_start = 1
Plug 'mzlogin/vim-markdown-toc'

" Themes
"Plug 'skielbasa/vim-material-monokai'
    "let g:airline_theme='materialmonokai'
    "let g:materialmonokai_italic=1
    "let g:materialmonokai_subtle_spell=1
call plug#end()

""""""""""""""""""""""""""""
""""" General Settings """""
""""""""""""""""""""""""""""
set nocompatible
filetype plugin indent on
syntax on
set hidden
set updatetime=1000
" set signcolumn=yes
set noshowmode
set ttyfast
set visualbell
set number
set relativenumber
set wrap
set encoding=utf8
" set autoindent
""set colorcolumn=100

set list
set listchars=tab:\┊\ ,nbsp:¬,extends:»,precedes:«,trail:•

"tab:\┊\ ,eol:a,trail:·,extends:→,precedes:←

" File searching
"set path+=**
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Terminal colors
"set t_Co=256
set background=dark
set termguicolors
colorscheme monokai_material
hi Normal guibg=NONE ctermbg=NONE

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set laststatus=2

" To avoid supressing error messages
set shortmess-=F

" Enable cursorline
set cursorline

" Enable italics
hi Comment cterm=italic

" Clipboard
set clipboard=unnamedplus

" Enable tabline
set showtabline=2

" Tab settings
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab

set backspace=indent,eol,start
set guioptions-=T
set guioptions-=r
set guioptions-=L

if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
else
    set grepprg=grep\ -nH\ $*
endif

" Search settings
set hlsearch
set incsearch
set smartcase
set gdefault

" Search results centered
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Enable magic on search
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Enable folding
"set foldmethod=indent
"nnoremap <space> zc
"vnoremap <space> zo
"let g:SimpylFold_docstring_preview=1

" Scroloff
set scrolloff=4

" lower timeout length
set timeoutlen=1000 ttimeoutlen=0

" Persistent undo and backups
call mkdir($HOME . "/.vim/tmp", "p")
set backupdir=$HOME/.vim/tmp,/var/tmp,/tmp
set directory=$HOME/.vim/tmp,/var/tmp,/tmp

if has('persistent_undo')
    set undodir=$HOME/.vim/tmp
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" Python settings
" Bad whitespace
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" Python tab settings
"au BufNewFile,BufRead *.py
"    \ set textwidth=79
"    \ set fileformat=unix


""""""""""""""""""""
""""" Keybinds """""
""""""""""""""""""""
" Disable ex-mode
noremap Q <Nop>
" Disable F1 help
nnoremap <F1> <Nop>
inoremap <F1> <Nop>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Frequent actions
"nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>

" <leader><leader> toggles between last two buffers
nnoremap <leader><leader> <c-^>

" OpeA: Pyright is now an officially-supported Microsoft type checker for Python. It will continue to be developed and maintained as an open-source project under its original MIT license terms. The Pyright extension for VSCode is a reference implementation and is not guaranteed to be fully functional or maintained long-term.n new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Word delete in insert mode
inoremap <C-BS> <C-W>
vnoremap <C-BS> <C-W>

" Visual movement
" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open buffer navigation
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <C-W> :bd<CR>
nnoremap <leader>l :bprevious<CR>
nnoremap <leader>h :bnext<CR>

" Ctrl+h to stop search highlight
" vnoremap <C-h> :nohlsearch<cr>
" nnoremap <C-h> :nohlsearch<cr>

" Tag navigation
"nnoremap <C-]> :tag<CR>
nnoremap <C-[> :pop<CR>

" Gundo
nnoremap <C-g> :GundoToggle<CR>

" Toggle plugins
" nnoremap <C-o> :Files<CR>
nnoremap <C-t> :TagbarToggle<CR>

"""""""""""""""""
""""" Misc. """""
"""""""""""""""""
" Make .tex files run faster
" https://stackoverflow.com/questions/8300982/vim-running-slow-with-latex-files
au FileType tex setlocal nocursorline
au FileType tex :NoMatchParen
" https://github.com/vim/vim/issues/727
autocmd FileType tex set regexpengine=1

" Spell check
let b:lang=0
let g:langList=["nospell", "en_gb", "sv"]
function ToggleSpell()
    let b:lang=b:lang+1
    if b:lang>=len(g:langList) | let b:lang=0 | endif
    if b:lang==0
        setlocal nospell
    else
        execute "setlocal spell spelllang=".get(g:langList, b:lang)
    endif
    echo "Language: " g:langList[b:lang]
endfunction
nmap <silent> <F7> :call ToggleSpell()<CR>

" 'set wrap lbr' in all .tex files
autocmd BufNewFile,BufReadPost *.tex set wrap lbr
set wrap lbr

" Reload vimrc on write
augroup reload_vimrc
    autocmd!
    autocmd bufwritepost ~/.vimrc nested source ~/.vimrc
augroup END

" Jump to last known position on re-open
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Remove trailing whitespaces
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Figure out the system Python for Neovim to ensure has('python3') works in
" virtualenvs
" https://github.com/neovim/neovim/issues/1887
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

" Call the remove trailing whitespaces on write
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Templates
if has ("autocmd")
    augroup templates
        autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
        autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex
        autocmd BufNewFile *.bib 0r ~/.vim/templates/skeleton.bib
        autocmd BufNewFile *.html,*.liquid 0r ~/.vim/templates/skeleton.html
    augroup END
endif
