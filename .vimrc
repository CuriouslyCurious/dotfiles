set visualbell

" Vundle configuration
set nocompatible
filetype off

" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" Plugin 'VundleVim/Vundle.vim'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'tpope/vim-fugitive'
" Plugin 'lervag/vimtex'
" Plugin 'tomasr/molokai'
" Plugin 'nanotech/jellybeans.vim'
" call vundle#end()
" :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

filetype plugin indent on
syntax on
set number
"set relativenumber
set wrap
set enc=utf8
set background=dark

" Theme
colorscheme molokai
let g:molokai_original=1
" let g:rehash256=1
"highlight Normal ctermfg=#F1EBEB ctermbg=#272822

highlight ColorColumn ctermbg=7
highlight ColorColumn guibg=Gray
set t_Co=256

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

" Automatic bracket settings


" Latex settings
let g:tex_flavor='latex'
set spelllang=en
augroup latexsettings
    autocmd FileType tex set spell
    autocmd BufWritePost *.tex latexmk
augroup END

