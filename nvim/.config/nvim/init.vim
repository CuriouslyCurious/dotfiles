" NVIM General Settings (differs from .vimrc)
set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim
set signcolumn=yes

" Highlight yanked region
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

" Make folding be based on treesitter
" Sexy Folds by u/Rafat913
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldtext=getline(v:foldstart).'...'.trim(getline(v:foldend))
set fillchars=fold:\\
set foldnestmax=3
set foldminlines=1
set foldlevel=99
set indentexpr=nvim_treesitter#indent()

" TODO: Statusline indicator
" echo nvim_treesitter#statusline(90)
" module->expression_statement->call->identifier

set shell=/bin/bash

" Leader
let mapleader   = "\<space>"
let localleader = "\<space>"
let g:mapleader = "\<space>"
let maplocalleader = "\<space>"

""
" General Settings
""
set nocompatible
filetype plugin indent on
syntax on
set hidden
" 250ms delay to trigger certain actions
set updatetime=250
" Don't redraw while executing untyped commands
set lazyredraw
" Sign gutter
set signcolumn=yes:1
set noshowmode
set ttyfast
set visualbell
set number
set relativenumber
set wrap
set encoding=utf8
set mouse=a
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
"nnoremap ? ?\v
"nnoremap / /\v
"cnoremap %s/ %sm/

" Enable folding
"set foldmethod=indent
"nnoremap <space> zc
"vnoremap <space> zo
"let g:SimpylFold_docstring_preview=1

" Scroloff
set scrolloff=4

" lower timeout length
set timeoutlen=1000 ttimeoutlen=50

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

""
" Keybinds
""
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
nnoremap <leader>w :w<CR>
nnoremap <leader>q :cope<CR>

" <leader><leader> toggles between last two buffers
"nnoremap <leader><leader> <c-^>

" OpeA: Pyright is now an officially-supported Microsoft type checker for Python. It will continue to be developed and maintained as an open-source project under its original MIT license terms. The Pyright extension for VSCode is a reference implementation and is not guaranteed to be fully functional or maintained long-term.n new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Word delete in insert mode
"inoremap <C-BS> <C-W>
"vnoremap <C-BS> <C-W>
inoremap  <C-W>
vnoremap  <C-W>

" Visual movement
" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
"jnnoremap <expr> k v:count == 0 ? 'gk' : 'k'
"jnnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" Map key chord `jk` to <Esc>.
" https://www.reddit.com/r/vim/comments/ufgrl8/journey_to_the_ultimate_imap_jk_esc/
let g:esc_j_lasttime = 0
let g:esc_k_lasttime = 0
function! JKescape(key)
	if a:key=='j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
	if a:key=='k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
    let l:timediff = abs(g:esc_j_lasttime - g:esc_k_lasttime)
	return (l:timediff <= 0.10 && l:timediff >=0.001) ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open buffer navigation
nnoremap <C-W> :bd<CR>
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <leader>l :bprevious<CR>
nnoremap <leader>h :bnext<CR>

" Ctrl+h to stop search highlight
" vnoremap <C-h> :nohlsearch<cr>
" nnoremap <C-h> :nohlsearch<cr>

" Tag navigation
"nnoremap <C-]> :tag<CR>
" nnoremap <C-[> :pop<CR>

" Gundo
nnoremap <C-g> :GundoToggle<CR>

""
" Misc.
""
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

" https://vim.fandom.com/wiki/Improved_hex_editing
" nnoremap <C-H> :Hexmode<CR>
" inoremap <C-H> <Esc>:Hexmode<CR>

" ex command for toggling hex mode - define mapping if desired
" command -bar Hexmode call ToggleHex()

" TODO: Fix this hexmode shit
" helper function to toggle hex mode
"function ToggleHex()
"    " hex mode should be considered a read-only operation
"    " save values for modified and read-only for restoration later,
"    " and clear the read-only flag for now
"    let l:modified=&mod
"    let l:oldreadonly=&readonly
"    let &readonly=0
"    let l:oldmodifiable=&modifiable
"    let &modifiable=1
"    if !exists("b:editHex") || !b:editHex
"        " save old options
"        let b:oldft=&ft
"        let b:oldbin=&bin
"        " set new options
"        setlocal binary " make sure it overrides any textwidth, etc.
"        silent :e " this will reload the file without trickeries
"        "(DOS line endings will be shown entirely )
"        let &ft="xxd"
"        " set status
"        let b:editHex=1
"        " switch to hex editor
"        %!xxd
"    else
"        " restore old options
"        let &ft=b:oldft
"        if !b:oldbin
"            setlocal nobinary
"        endif
"        " set status
"        let b:editHex=0
"        " return to normal editing
"        %!xxd -r
"    endif
"    " restore values for modified and read only state
"    let &mod=l:modified
"    let &readonly=l:oldreadonly
"    let &modifiable=l:oldmodifiable
"endfunction
"
"" autocmds to automatically enter hex mode and handle file writes properly
"if has("autocmd")
"  " vim -b : edit binary using xxd-format!
"    augroup Binary
"        au!
"
"        " set binary option for all binary files before reading them
"        au BufReadPre *.bin,*.hex setlocal binary
"
"        " if on a fresh read the buffer variable is already set, it's wrong
"        au BufReadPost *
"              \ if exists('b:editHex') && b:editHex |
"              \   let b:editHex = 0 |
"              \ endif
"
"        " convert to hex on startup for binary files automatically
"        au BufReadPost *
"              \ if &binary | Hexmode | endif
"
"        " When the text is freed, the next time the buffer is made active it will
"        " re-read the text and thus not match the correct mode, we will need to
"        " convert it again if the buffer is again loaded.
"        au BufUnload *
"              \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
"              \   call setbufvar(expand("<afile>"), 'editHex', 0) |
"              \ endif
"
"        " before writing a file when editing in hex mode, convert back to non-hex
"        au BufWritePre *
"              \ if exists("b:editHex") && b:editHex && &binary |
"              \  let oldro=&ro | let &ro=0 |
"              \  let oldma=&ma | let &ma=1 |
"              \  silent exe "%!xxd -r" |
"              \  let &ma=oldma | let &ro=oldro |
"              \  unlet oldma | unlet oldro |
"              \ endif
"
"        " after writing a binary file, if we're in hex mode, restore hex mode
"        au BufWritePost *
"              \ if exists("b:editHex") && b:editHex && &binary |
"              \  let oldro=&ro | let &ro=0 |
"              \  let oldma=&ma | let &ma=1 |
"              \  silent exe "%!xxd" |
"              \  exe "set nomod" |
"              \  let &ma=oldma | let &ro=oldro |
"              \  unlet oldma | unlet oldro |
"              \ endif
"    augroup END
"endif

" Templates
if has ("autocmd")
    augroup templates
        autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
        autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex
        autocmd BufNewFile *.bib 0r ~/.vim/templates/skeleton.bib
        autocmd BufNewFile *.html,*.liquid 0r ~/.vim/templates/skeleton.html
    augroup END
endif

" Auto-format"
if has ("autocomd")
    augroup formats
        autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
    augroup END
endif

lua <<EOF
require('plugins')
require('lsp')
require('plugin-setup')
EOF

colorscheme material-monokai
