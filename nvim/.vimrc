call plug#begin('~/.config/nvim/plugged')
" tpope magic
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'

" nerdtree
Plug 'scrooloose/nerdtree'
    " Exit Vim if NERDTree is the only window left.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
        \ quit | endif
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

" commenting
Plug 'preservim/nerdcommenter'

" ctag handling
Plug 'majutsushi/tagbar'

" webdev (yuck)
Plug 'alvan/vim-closetag'
    let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.liquid'
    let g:closetag_filetypes = '*.html,*.xhtml,*.phtml,*.liquid'

" gitgutter
Plug 'airblade/vim-gitgutter'

" LSP (auto-completion / linting)
Plug 'natebosch/vim-lsc'
    let g:lsc_server_commands = {
        \'rust': 'rust-analyzer',
        \'python': 'pyls',
    \}
    let g:lsc_auto_map = { 'defaults': v:true,
        \  'GoToDefinition': 'gd',
        \  'ShowHover': 'K',
        \  'Completion': 'completefunc',
    \}
    let g:lsc_enable_autocomplete  = v:true
    let g:lsc_enable_diagnostics   = v:true
    let g:lsc_reference_highlights = v:true
    let g:lsc_trace_level          = 'off'

    "highlight lscDiagnosticError cterm=bold
    hi lscDiagnosticWarning cterm=none
    "hi lscDiagonsticInfo cterm=bold
    "hi lscDiagnosticHint cterm=bold
    "hi lscCurrentParameter cterm=bold
    "hi lscReference cterm=bold

    set completeopt=menu,menuone,noinsert,noselect
    " Auto-close scratch preview window upon a complete or leaving insert
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
Plug 'ajh17/VimCompletesMe'

" Syntax highlighting
"Plug 'dense-analysis/ale'

Plug 'PotatoesMaster/i3-vim-syntax'

Plug 'beyondmarc/opengl.vim'
Plug 'tikhomirov/vim-glsl'
    autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

" Auto insert matching delimiters
Plug 'Raimondi/delimitMate'
    " Disable auto-closing for tags to ensure closetag can do its thing
    let delimitMate_matchpairs = "(:),[:],{:}"
    autocmd! FileType html,xhtml,phtml,liquid let b:delimitMate_matchpairs = "(:),[:],{:}"

" Code-folding
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'

" Latex
Plug 'lervag/vimtex'
    let g:tex_flavor = 'latex'
    let g:vimtex_fold_enabled = 1
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

" Undo trees
Plug 'sjl/gundo.vim'
    nnoremap <C-u> :GundoToggle<CR>
    let g:gundo_prefer_python3 = 1

" Rust
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'racer-rust/vim-racer'
    set hidden
    let g:racer_cmd = "$HOME/.cargo/bin/racer"
    let g:racer_experimental_completer = 1

" R Markdown
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
    let g:mkdp_auto_start = 1
Plug 'mzlogin/vim-markdown-toc'

" Themes
Plug 'vim-airline/vim-airline'
    let g:airline#extensions#tabline#enabled=1
Plug 'nanotech/jellybeans.vim'
Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/CycleColor'
"Plug 'liuchengxu/space-vim-dark'
"    let g:space_vim_dark_background=234
Plug 'skielbasa/vim-material-monokai'
    let g:airline_theme='materialmonokai'
    let g:materialmonokai_italic=1
    let g:materialmonokai_subtle_spell=1
call plug#end()


""""""""""""""""""""""""""""
""""" General Settings """""
""""""""""""""""""""""""""""
set nocompatible
filetype plugin indent on
syntax enable

set updatetime=300

set list
set listchars=tab:\┊\ ,eol:¬,trail:·,extends:→,precedes:←

" TODO NOT IMPLEMENTED YET, wait for neovim 0.5
"set signcolumn=number

" File searching
set path+=**
set wildmenu

" Terminal colors
"set t_Co=256
set background=dark
set termguicolors
colorscheme material-monokai
hi Normal guibg=NONE ctermbg=NONE

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" To avoid supressing error messages
set shortmess-=F

set laststatus=2

set visualbell
set number
set relativenumber
set wrap
set enc=utf8
set autoindent

" Enable cursorline
set cursorline

" Enable italics
hi Comment cterm=italic

" Make .tex files run faster
" https://stackoverflow.com/questions/8300982/vim-running-slow-with-latex-files
au FileType tex setlocal nocursorline
au FileType tex :NoMatchParen
" https://github.com/vim/vim/issues/727
autocmd FileType tex set regexpengine=1

" Tab settings
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab

set backspace=2
set guioptions-=T
set guioptions-=r
set guioptions-=L

set grepprg=grep\ -nH\ $*

" Search settings
set hlsearch
set incsearch

set clipboard=unnamedplus

" Backups "
set backupdir=~/.vim/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,/var/tmp,/tmp

" Scroloff
set so=6

" lower timeout length
set timeoutlen=1000 ttimeoutlen=0

" Persistent undo
if has('persistent_undo')
    if !isdirectory("/tmp/.vim-undo")
        call mkdir("/tmp/.vim-undo", "", 0700)
    endif
    set undodir=/tmp/vim-undo
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> zc
vnoremap <space> zo
let g:SimpylFold_docstring_preview=1

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
nnoremap Q <Nop>

" Leader
let mapleader   = "\<space>"
let localleader = "\<space>"
let g:mapleader = "\<space>"
let maplocalleader = "\<space>"

" Visual movement
" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open file navigation
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>l :bnext<CR>

" Tag navigation
"nnoremap <C-]> :tag<CR>
nnoremap <C-[> :pop<CR>

" plugins
nnoremap <C-f> :NERDTreeToggle<CR>
nnoremap <C-t> :TagbarToggle<CR>

"""""""""""""""""
""""" Misc. """""
"""""""""""""""""
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
