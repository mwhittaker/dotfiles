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
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'def-lkb/vimbufsync'
Plugin 'ervandew/supertab'
Plugin 'flazz/vim-colorschemes'
Plugin 'gabrielelana/vim-markdown'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'mkitt/tabline.vim'
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'the-lambda-church/coquille'
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
" Basic Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leader
let mapleader = "\<Space>"
set notimeout

" prevent pinky fatigue
noremap <C-c> <Esc>

" line numbering
set number

" tabs and indents
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" easier command line navigation
cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" easier tab navigation
set tabpagemax=20
nnoremap <tab> gt
nnoremap <s-tab> gT
nnoremap <leader>1 1gt<cr>
nnoremap <leader>2 2gt<cr>
nnoremap <leader>3 3gt<cr>
nnoremap <leader>4 4gt<cr>
nnoremap <leader>5 5gt<cr>
nnoremap <leader>6 6gt<cr>
nnoremap <leader>7 7gt<cr>
nnoremap <leader>8 8gt<cr>
nnoremap <leader>9 9gt<cr>

" easier window navigation
set splitbelow
set splitright
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" enable vim modelines
set modeline

" bash-like tab completion
set wildmode=longest,list

" Improved history
set history=1000

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Advanced Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set font
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

" use solarized for gvim
if has('gui_running')
    syntax enable
    set background=dark
    colorscheme solarized
    call togglebg#map("")
endif

" highlight 80-character column
if version >= 703
    let &colorcolumn=join(range(81,81),",")
endif

" remove trailing whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" URL Shortener
vnoremap <leader>su :!xargs shurl<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Programming Languages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OCaml
autocmd FileType ocaml setlocal shiftwidth=2 tabstop=2
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" SQL
let g:omni_sql_no_default_maps = 1

" Coq
let g:coquille_auto_move = 'true'
map <silent> <leader>cl :CoqLaunch<cr>
map <silent> <leader>cc :CoqToCursor<cr>
map <silent> <leader>cn :CoqNext<cr>
map <silent> <leader>cu :CoqUndo<cr>
map <silent> <leader>ck :CoqKill<cr>

" html
autocmd FileType html setlocal shiftwidth=2 tabstop=2

" php
autocmd FileType php setlocal shiftwidth=2 tabstop=2

" tex
autocmd FileType tex setlocal shiftwidth=2 tabstop=2
autocmd FileType tex setlocal spell
autocmd Syntax tex syn region texZone start="\\begin{pycode}" end="\\end{pycode}"

" verilog
autocmd FileType verilog setlocal shiftwidth=2 tabstop=2

" go
autocmd FileType go setlocal noexpandtab

" text
autocmd FileType text setlocal spell

" markdown
autocmd FileType markdown setlocal spell


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
let g:syntastic_ocaml_checkers = ["merlin"]
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['ipy', 'tex'] }
let g:syntastic_python_pylint_args = "--errors-only"
autocmd BufNewFile,BufRead *.ipy set filetype=ipy
autocmd BufRead,BufNewFile *.md  set filetype=markdown
autocmd FileType ipy setlocal syntax=python

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gundo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>u :GundoToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDCommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reset some of NERDCommenter's default comment delimiters. See
" https://github.com/scrooloose/nerdcommenter/issues/33 for more information.
let g:NERDCustomDelimiters = {
    \ 'c':          { 'left': '// ', 'right': '',      'leftAlt': '/* ', 'rightAlt': ' */' },
    \ 'cpp':        { 'left': '// ',                   'leftAlt': '/* ', 'rightAlt': ' */' },
    \ 'haskell':    { 'left': '-- ',                   'leftAlt': '{- ', 'rightAlt': ' -}' },
    \ 'java':       { 'left': '// ',                   'leftAlt': '/* ', 'rightAlt': ' */' },
    \ 'javascript': { 'left': '// ',                   'leftAlt': '/* ', 'rightAlt': ' */' },
    \ 'matlab':     { 'left': '% '                                                         },
    \ 'ocaml':      { 'left': '(* ', 'right': ' *)'                                        },
    \ 'python':     { 'left': '# '                                                         },
    \ 'sh':         { 'left': '# '                                                         },
    \ 'tex':        { 'left': '% '                                                         },
    \ 'tmux':       { 'left': '# '                                                         },
\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Multiple Cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_quit_key='<C-c>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 'c'
