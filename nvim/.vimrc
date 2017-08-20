set visualbell

let mapleader   = "\<space>"
let localleader = "\<space>"
let g:mapleader = "\<space>"
let maplocalleader = "\<space>"


" Vundle configuration
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'lervag/vimtex'

" Coding
Plugin 'Valloric/YouCompleteMe'

" Highlighting
Plugin 'tikhomirov/vim-glsl'
Plugin 'vim-syntastic/syntastic'

" Latex
"Plugin 'xuhdev/vim-latex-live-preview'
"Plugin 'nichtleiter/vim-live-latex-preview'

" Linting
Plugin 'nvie/vim-flake8'

" Themes
Plugin 'vim-airline/vim-airline'
Plugin 'tomasr/molokai'
Plugin 'nanotech/jellybeans.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/CycleColor'
call vundle#end()
filetype plugin indent on
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
set number
"set relativenumber
set wrap
set enc=utf8
set background=dark
set autoindent

" space-vim-dark Theme
let g:space_vim_dark_background=233
colorscheme space-vim-dark

" Molokai
"let g:molokai_original=1
" let g:rehash256=1
"highlight Normal ctermfg=#F1EBEB ctermbg=#272822

set t_Co=256

let g:airline#extensions#tabline#enabled=1
set laststatus=2

" Tab settings
set tabstop=4
set softtabstop=0
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

set clipboard=unnamed

" Backups
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" Automatic bracket settings


" Latex settings
let g:tex_flavor='latex'

autocmd FileType tex setl updatetime=1000
let g:livepreview_previewer='zathura'

" Spacebar as leader

"let no_tex_maps=1
"nmap <F12> :call LaunchMuPDF()<CR>
"nmap <F12> :call UpdatingToggle()<CR>
"let tex_preview_always_autosave = 1

"nmap <C-return> :<plug>(vimtex-compile)<CR>

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


" 'set wrap lbr' in all .tex files
autocmd BufNewFile,BufReadPost *.tex set wrap lbr
set wrap lbr
augroup reload_vimrc
    autocmd!
    autocmd bufwritepost ~/.vimrc nested source ~/.vimrc
augroup END


"au FileType tex set spell
"au BufWritePost *.tex silent call Tex_RunLaTeX()
"au BufWritePost *.tex silent !pkill -USR1 xdvi.bin
"
"augroup latexsettings
"    autocmd FileType tex set spell
"    autocmd BufWritePost *.tex xelatex
"augroup END

" Key maps

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

" vim-glsl
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

" Flake8
autocmd BufWritePost *.py call Flake8()
