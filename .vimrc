"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'davidhalter/jedi-vim'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'altercation/vim-colors-solarized'
Bundle 'godlygeek/tabular'

filetype plugin indent on     " required!

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
    set guifont=DejaVu\ Sans\ Mono\ Book\ 10
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
let &colorcolumn=join(range(81,999),",")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set modeline, the inline vim edits.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set modeline

autocmd FileType ocaml setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType php setlocal shiftwidth=2 tabstop=2
autocmd FileType tex setlocal shiftwidth=2 tabstop=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Conceal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set cole=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash tab completion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmode=longest,list

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Supertab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "<c-n>" " tab from top to bottom

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_include_dirs = [ '../src', '/usr/include/flycapture' ]
let g:syntastic_c_include_dirs = [ '/usr/lib/gcc/msp430/4.5.3/../../../../msp430/include', '/usr/include/flycapture' ]
let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'passive_filetypes': ['ipy'] }
autocmd BufNewFile,BufRead *.ipy set filetype=ipy
autocmd FileType ipy setlocal syntax=python
au BufRead,BufNewFile *.md set filetype=markdown
