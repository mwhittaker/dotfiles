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
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'majutsushi/tagbar'
Plugin 'mkitt/tabline.vim'
Plugin 'mwhittaker/dedalus-vim'
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-surround'

" 'vim-textobj-user' has to be installed before 'vim-textobj-latex'.
Plugin 'kana/vim-textobj-user'
Plugin 'rbonvall/vim-textobj-latex'

" typescript plugins.
Plugin 'Quramy/tsuquyomi'
Plugin 'Shougo/vimproc.vim'
Plugin 'leafgarland/typescript-vim'

" markdown plugins.
Plugin 'tpope/vim-markdown'

" Seldom used plugins.
" Plugin 'Blackrush/vim-gocode'
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'def-lkb/vimbufsync'
" Plugin 'the-lambda-church/coquille'
" Plugin 'triglav/vim-visual-increment'
" Plugin 'vim-scripts/Tabmerge'
" Plugin 'wting/rust.vim'

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
" Map the leader to the space character.
let mapleader = "\<Space>"
set notimeout

" Alias escape to control-c; pressing control-c is significantly easier than
" pressing escape.
noremap <C-c> <Esc>

" Turn on line numbers.
set number

" Configure indentation and spaces over tabs.
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Configure tabs.
set tabpagemax=20
nnoremap <tab> gt
nnoremap <s-tab> gT

" Configure window splitting and navigation.
set splitbelow
set splitright
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Enable vim modelines.
set modeline

" Enable bash-like tab completion.
set wildmode=longest,list

" Increase history size.
set history=1000

" Highlight matching <>. https://goo.gl/R7JD7M
set matchpairs+=<:>

" Emulate bash's c-p, c-n, and c-k commands in command mode. Note that these
" are not set by 'tpope/vim-rsi'. See [1] for more info on the <c-k> mapping.
"
" [1]: https://github.com/tpope/vim-rsi/issues/15
cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <c-k> <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Advanced Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the font and color scheme. See [1] for details on setting the
" colorscheme. The jellybeans color scheme is provided by the
" 'flazz/vim-colorschemes' plugin.
"
" [1]: https://stackoverflow.com/a/5702498
syntax on
try
    colorscheme jellybeans
catch /^Vim\%((\a\+)\)\=:E185/
    " deal with it
endtry
if has('gui_running')
    set mouse=""
    if has('gui_macvim')
        set guifont=Menlo:h12
    else
        set guifont=DejaVu\ Sans\ Mono\ Book\ 12
    endif
else
    set t_Co=256
endif

" Highlight 80-character column and 100-character column.
if version >= 703
    set colorcolumn=81,101
endif

" Remove trailing whitespace on save.
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
augroup strip_trailing_whitespace_group
    autocmd!
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Programming Languages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" c++
augroup cpp_settings_group
    autocmd!
    autocmd FileType cpp setlocal shiftwidth=2 tabstop=2
    autocmd FileType cpp ClangFormatAutoEnable
augroup END

" coq
let g:coquille_auto_move = 'true'
nnoremap <silent> <leader>cl :CoqLaunch<cr>
nnoremap <silent> <leader>cc :CoqToCursor<cr>
nnoremap <silent> <leader>cn :CoqNext<cr>
nnoremap <silent> <leader>cu :CoqUndo<cr>
nnoremap <silent> <leader>ck :CoqKill<cr>

" css
augroup css_settings_group
    autocmd!
    autocmd FileType css setlocal shiftwidth=2 tabstop=2
augroup END

" go
augroup go_settings_group
    autocmd!
    autocmd FileType go setlocal noexpandtab
augroup END

" html
augroup html_settings_group
    autocmd!
    autocmd FileType html setlocal shiftwidth=2 tabstop=2
    autocmd FileType html setlocal cursorcolumn
augroup END

" ipython
augroup ipython_settings_group
    autocmd!
    autocmd BufNewFile,BufRead *.ipy set filetype=ipy
    autocmd FileType ipy setlocal syntax=python
augroup END

" javascript
augroup javascript_settings_group
    autocmd!
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
augroup END

" markdown
augroup markdown_settings_group
    autocmd!
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown let @i = "S_"
    autocmd FileType markdown let @b = "S_gvS_"
augroup END

" ocaml
augroup ocaml_settings_group
    autocmd!
    autocmd FileType ocaml setlocal shiftwidth=2 tabstop=2
augroup END
" If the opam executable is found, then we run these commands to set up
" merlin. If opam is not installed, then running these two commands will not
" work.
if executable("opam")
    let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
    execute "set rtp+=" . g:opamshare . "/merlin/vim"
endif

" php
augroup php_settings_group
    autocmd!
    autocmd FileType php setlocal shiftwidth=2 tabstop=2
augroup END

" protocol buffers
augroup proto_settings_group
    autocmd!
    autocmd FileType proto setlocal shiftwidth=2 tabstop=2
augroup END

" sql
let g:omni_sql_no_default_maps = 1

" tex
augroup tex_settings_group
    autocmd!
    autocmd FileType tex setlocal shiftwidth=2 tabstop=2
    autocmd FileType tex setlocal spell
augroup END

" typescript
augroup typescript_settings_group
    autocmd!
    autocmd BufNewFile,BufRead *.ts setlocal shiftwidth=2 tabstop=2
augroup END

" text
augroup text_settings_group
    autocmd!
    autocmd FileType text setlocal spell
augroup END

" verilog
augroup verilog_settings_group
    autocmd!
    autocmd FileType verilog setlocal shiftwidth=2 tabstop=2
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lokaltog/vim-easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_smartcase = 1
if version >= 703
    map  / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)

    " These `n` & `N` mappings are options. You do not have to map `n` & `N`
    " to EasyMotion. Without these mappings, `n` & `N` works fine. (These
    " mappings just provide different highlight method and have some other
    " features )
    map  n <Plug>(easymotion-next)
    map  N <Plug>(easymotion-prev)

    " https://github.com/easymotion/vim-easymotion#default-bindings
    " map <Leader> <Plug>(easymotion-prefix)
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quramy/tsuquyomi
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup tsuquyomi_group
    autocmd!
    autocmd FileType typescript nnoremap <buffer> <Leader>t :<C-u>echo tsuquyomi#hint()<CR>
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"bling/vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ervandew/supertab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:SuperTabDefaultCompletionType = 'context'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" kien/ctrlp.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 'c'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" majutsushi/tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :help tagbar-configuration
let g:tagbar_sort = 0

" http://vim.wikia.com/wiki/Single_tags_file_for_a_source_tree
set tags=tags;


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scrooloose/nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reset some of NERDCommenter's default comment delimiters. See
" https://github.com/scrooloose/nerdcommenter/issues/33 for more information.
let g:NERDCustomDelimiters = {
    \ 'c':          { 'left': '//', 'right': '', 'leftAlt': '/*', 'rightAlt': '*/' },
    \ 'cpp':        { 'left': '//',              'leftAlt': '/*', 'rightAlt': '*/' },
    \ 'haskell':    { 'left': '--',              'leftAlt': '{-', 'rightAlt': '-}' },
    \ 'java':       { 'left': '//',              'leftAlt': '/*', 'rightAlt': '*/' },
    \ 'javascript': { 'left': '//',              'leftAlt': '/*', 'rightAlt': '*/' },
    \ 'matlab':     { 'left': '%'                                                  },
    \ 'ocaml':      { 'left': '(*', 'right': '*)'                                  },
    \ 'python':     { 'left': '#'                                                  },
    \ 'sh':         { 'left': '#'                                                  },
    \ 'tex':        { 'left': '%'                                                  },
    \ 'tmux':       { 'left': '#'                                                  },
\ }
" Add spaces after comment delimiters by default.
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code
" indentation.
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scrooloose/syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic options. See :help syntastic-recommended.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1

" See :help syntastic-filetype-checkers.
" clang_tidy can take a *really* long time to run, so it makes sense to
" disable it. You can run :SyntasticCheck clang_tidy to run it.
let b:clang_enabled = 0
if b:clang_enabled
    let g:syntastic_cpp_checkers = ['gcc', 'clang_tidy']
endif
let g:syntastic_python_checkers = ["python", "pylint", "mypy"]
let g:syntastic_ocaml_checkers = ["merlin"]

" Typescript (see https://github.com/Quramy/tsuquyomi)
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']

" See :help syntastic-config-makeprg and :help g:syntastic_<lang>_<checker>.
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++14'
let g:syntastic_cpp_clang_tidy_args = '-checks=*'
let b:look_for_compile_commands = 1
if b:look_for_compile_commands
    " By default, clang-tidy includes the '--' flag which for some reason
    " stops clang_tidy from looking for the `compile_commands.json` file.
    " Setting this variable removes the '--' flag.
    let g:syntastic_cpp_clang_tidy_post_args = ''
endif

let g:syntastic_python_mypy_args = "--ignore-missing-imports"
let g:syntastic_python_pylint_args = "--errors-only"

" See :help syntastic-global-options.
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['ipy', 'tex'] }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sjl/gundo.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>u :GundoToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" terryma/vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_quit_key='<C-c>'
