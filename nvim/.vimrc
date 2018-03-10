call plug#begin('~/.config/nvim/plugged')
" tpope magic
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'

Plug 'scrooloose/nerdtree'

" gitgutter
Plug 'airblade/vim-gitgutter'

" Auto-completion
Plug 'Valloric/YouCompleteMe'
    let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
    let g:ycm_extra_conf_globlist=['~/.vim/*']
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_filetype_blacklist={
                \ 'vim' : 1,
                \ 'tagbar' : 1,
                \ 'qf' : 1,
                \ 'notes' : 1,
                \ 'markdown' : 1,
                \ 'md' : 1,
                \ 'unite' : 1,
                \ 'text' : 1,
                \ 'vimwiki' : 1,
                \ 'pandoc' : 1,
                \ 'infolog' : 1,
                \ 'objc' : 1,
                \ 'mail' : 1
    \}

Plug 'Raimondi/delimitMate'
" Code-folding
Plug 'tmhedberg/SimpylFold'

" Highlighting
Plug 'tikhomirov/vim-glsl'
    autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

Plug 'vim-syntastic/syntastic'
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_python_flake8_args='--ignore=E501,E225'   
    let g:syntastic_check_on_wq = 0

Plug 'PotatoesMaster/i3-vim-syntax'

" Latex
Plug 'lervag/vimtex'
    let g:vimtex_fold_enabled = 1
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-shell-escape',
      \   '-xelatex',
      \   '-verbose',
      \   '-file-line-error',
      \   '-interaction=nonstopmode'
      \ ]}

" Linting
"Plug 'nvie/vim-flake8'
"    autocmd BufWritePost *.py call Flake8()

" Undo trees
Plug 'sjl/gundo.vim'
    nnoremap <leader>u :GundoToggle<CR>
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

Plug 'suan/vim-instant-markdown'
Plug 'mzlogin/vim-markdown-toc'

" Themes
Plug 'vim-airline/vim-airline'
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
filetype plugin indent on
syntax enable


" Terminal colors
"set t_Co=256
set background=dark
set termguicolors
colorscheme material-monokai
hi Normal guibg=NONE ctermbg=NONE

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"


" Airline
let g:airline#extensions#tabline#enabled=1
set laststatus=2

set visualbell
set number
set relativenumber
set wrap
set enc=utf8
set autoindent

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

set clipboard+=unnamedplus

" Backups
set backupdir=~/.vim-tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,/var/tmp,/tmp

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

" NERDtree
map <C-n> :NERDTreeToggle<CR>

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

" Visual movement
" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Leader
let mapleader   = "\<space>"
let localleader = "\<space>"
let g:mapleader = "\<space>"
let maplocalleader = "\<space>"


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

" Templates
if has ("autocmd")
    augroup templates
        autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
        autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex
    augroup END
endif
