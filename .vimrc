"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'Blackrush/vim-gocode'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-scripts/Tabmerge'
Plugin 'wting/rust.vim'

if version >= 703
    Plugin 'Lokaltog/vim-easymotion'
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set indents
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set line numbers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
if has('gui_running')
    if has('gui_macvim')
        set guifont=Menlo:h12
    else
        set guifont=DejaVu\ Sans\ Mono\ Book\ 12
    endif
else 
    set t_Co=256
    try
        colorscheme jellybeans
    catch /^Vim\%((\a\+)\)\=:E185/
        " deal with it
    endtry
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabpagemax=20

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Solarized for gvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    syntax enable
    set background=dark
    colorscheme solarized
    call togglebg#map("")
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 80 character highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if version >= 703
    let &colorcolumn=join(range(81,81),",")
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set modeline, the inline vim edits.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set modeline

autocmd FileType ocaml setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType php setlocal shiftwidth=2 tabstop=2
autocmd FileType tex setlocal shiftwidth=2 tabstop=2
autocmd FileType go setlocal noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash tab completion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmode=longest,list

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
set splitright

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Supertab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "<c-n>" " tab from top to bottom

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if version >= 703
    map  / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)

    " These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
    " Without these mappings, `n` & `N` works fine. (These mappings just provide
    " different highlight method and have some other features )
    map  n <Plug>(easymotion-next)
    map  N <Plug>(easymotion-prev)
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['ipy'] }
autocmd BufNewFile,BufRead *.ipy set filetype=ipy
autocmd FileType ipy setlocal syntax=python
au BufRead,BufNewFile *.md set filetype=markdown
