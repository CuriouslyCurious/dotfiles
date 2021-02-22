call plug#begin('~/.config/nvim/plugged')

" VIM enhancements
Plug 'ciaranm/securemodelines'
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
Plug 'preservim/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-sneak'
    let g:sneak#s_next = 1
Plug 'terryma/vim-expand-region'
    map K <Plug>(expand_region_expand)
    map J <Plug>(expand_region_shrink)
Plug 'godlygeek/tabular'
" tpope magic
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-sensible'
"
" VIM GUI
Plug 'machakann/vim-highlightedyank'
Plug 'itchyny/lightline.vim'
    let g:lightline = {
        \ 'colorscheme': 'material',
    \}
Plug 'andymass/vim-matchup'

" Auto insert matching delimiters
"Plug 'Raimondi/delimitMate'
    "" Disable auto-closing for tags to ensure closetag can do its thing
    "let delimitMate_matchpairs = "(:),[:],{:}"
    "autocmd! FileType html,xhtml,phtml,liquid let b:delimitMate_matchpairs = "(:),[:],{:}"

"" webdev (yuck)
"Plug 'alvan/vim-closetag'
    "let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.liquid'
    "let g:closetag_filetypes = '*.html,*.xhtml,*.phtml,*.liquid'

" nerdtree
"Plug 'scrooloose/nerdtree'
    "" Exit Vim if NERDTree is the only window left.
    "autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
        "\ quit | endif
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'ryanoasis/vim-devicons'

" ctag handling
Plug 'majutsushi/tagbar'

" Undo trees
Plug 'sjl/gundo.vim'
    let g:gundo_prefer_python3 = 1

" gitgutter
Plug 'airblade/vim-gitgutter'

" fzf (starting at root)
Plug 'airblade/vim-rooter'
" post-hook update for fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Auto-completion / linting
Plug 'ncm2/ncm2'
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set shortmess+=c
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'roxma/nvim-yarp'

" LSP (LanguageClient)
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
    let g:LanguageClient_serverCommands = {
        \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }
Plug 'Shougo/echodoc.vim'

"Plug 'natebosch/vim-lsc'
"    let g:lsc_server_commands = {
"        \'rust': 'rust-analyzer',
"        \'python': 'pyls',
"    \}
"    let g:lsc_auto_map = { 'defaults': v:true,
"        \  'GoToDefinition': 'gd',
"        \  'ShowHover': 'K',
"        \  'Completion': 'completefunc',
"    \}
"    let g:lsc_enable_autocomplete  = v:true
"    let g:lsc_enable_diagnostics   = v:true
"    let g:lsc_reference_highlights = v:true
"    let g:lsc_trace_level          = 'off'
"
"    "highlight lscDiagnosticError cterm=bold
"    hi lscDiagnosticWarning cterm=none
"    "hi lscDiagonsticInfo cterm=bold
"    "hi lscDiagnosticHint cterm=bold
"    "hi lscCurrentParameter cterm=bold
"    "hi lscReference cterm=bold
"
"    " Auto-close scratch preview window upon a complete or leaving insert
"    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"Plug 'ajh17/VimCompletesMe'


" Code-folding
"Plug 'tmhedberg/SimpylFold'
"Plug 'Konfekt/FastFold'

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

" Syntax
Plug 'dense-analysis/ale'
Plug 'cespare/vim-toml'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rust-lang/rust.vim'
    let g:rustfmt_autosave = 1
    let g:rustfmt_emit_files = 1
    let g:rustfmt_fail_silently = 0
    let g:rust_clip_command = 'xclip -selection clipboard'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'beyondmarc/opengl.vim'
Plug 'tikhomirov/vim-glsl'
    autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl
Plug 'dag/vim-fish'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
    let g:mkdp_auto_start = 1
Plug 'mzlogin/vim-markdown-toc'

" Themes
"Plug 'vim-airline/vim-airline'
    "let g:airline#extensions#tabline#enabled=1
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
set hidden
set updatetime=300
" TODO NOT IMPLEMENTED YET, wait for neovim 0.5
"set signcolumn=number
set signcolumn=yes
set noshowmode
set ttyfast
set visualbell
set number
set relativenumber
set wrap
set encoding=utf8
set autoindent
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
colorscheme material-monokai
hi Normal guibg=NONE ctermbg=NONE

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" To avoid supressing error messages
set shortmess-=F

set laststatus=2

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

" Clipboard
set clipboard=unnamedplus

" Tab settings
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab
set noexpandtab

set backspace=2
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
"set foldlevel=99
"nnoremap <space> zc
"vnoremap <space> zo
"let g:SimpylFold_docstring_preview=1

" Scroloff
set scrolloff=4

" lower timeout length
set timeoutlen=1000 ttimeoutlen=0

" Persistent undo and backups
call mkdir($HOME . "/.vim/tmp", "p")
set backupdir=~/.vim/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,/var/tmp,/tmp

if has('persistent_undo')
	set undodir=~/.vim/tmp
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
nnoremap Q <Nop>
" Disable F1 help
nnoremap F1 <nop>

" Leader
let mapleader   = "\<space>"
let localleader = "\<space>"
let g:mapleader = "\<space>"
let maplocalleader = "\<space>"

" Jump to start and end of line using the home row keys
map H ^
map L $

" Frequent actions
"nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>

" <leader><leader> toggles between last two buffers
nnoremap <leader><leader> <c-^>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

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
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>l :bnext<CR>

" Ctrl+h to stop search highlight
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Tag navigation
"nnoremap <C-]> :tag<CR>
nnoremap <C-[> :pop<CR>

" Completion
set completeopt=menuone,noinsert,noselect
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"

" LanguageClient bindings
nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)

" Gundo
nnoremap <C-g> :GundoToggle<CR>

" Toggle plugins
nnoremap <C-o> :Files<CR>
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
