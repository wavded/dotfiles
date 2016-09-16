call plug#begin('~/.config/nvim/plugged')

Plug 'itchyny/lightline.vim'           " status line
Plug 'ctrlpvim/ctrlp.vim'              " goto file/buffer/mru/etc
Plug 'scrooloose/nerdtree'             " file explorer
Plug 'ivalkeen/nerdtree-execute'       " file explorer OS integration
Plug 'ConradIrwin/vim-bracketed-paste' " auto :set paste
Plug 'tpope/vim-surround'              " enable change around
Plug 'tpope/vim-repeat'                " repeating for change around
Plug 'tpope/vim-commentary'            " gcc and gc for comments
Plug 'tpope/vim-fugitive'              " git support
Plug 'SirVer/ultisnips'                " snippet support
Plug 'honza/vim-snippets'              " common snippets
Plug 'mileszs/ack.vim'                 " search across files
Plug 'benekastah/neomake'              " lint on save
Plug 'Raimondi/delimitMate'            " auto brackets
Plug 'fatih/molokai'                   " color theme
Plug 'wavded/cobalt2.vim'

Plug 'Shougo/deoplete.nvim'            " auto complete
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'carlitux/deoplete-ternjs'
Plug 'eagletmt/neco-ghc'

" filetype-specific plugins
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': 'javascript.jsx' }
Plug 'moll/vim-node', { 'for': 'javascript.jsx' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript.jsx' }
" Plug 'othree/yajs.vim', { 'for': 'javascript.jsx' }
Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx'}
Plug 'ruanyl/vim-fixmyjs', { 'for': 'javascript.jsx' }

Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'moorereason/vim-markdownfmt', { 'for': 'markdown' }

Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go' }
Plug 'kewah/vim-stylefmt', { 'for': ['less', 'css']}
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja2' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'kylef/apiblueprint.vim', { 'for': 'apiblueprint' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'lhaskell'] }

call plug#end()

" autocorrects for common misspellings
source $HOME/.config/nvim/autocorrect.vim

"===================== SETTINGS ======================
set autoread                        " auto reload file if changed externally
set nobackup                        " no ~backup files
set noswapfile                      " no swap files
set autowrite                       " save files automatically in most cases
set ignorecase                      " case insensitive search...
set smartcase                       " ...unless capitals are used
set hidden                          " allow background buffers w/out writing
set list                            " show hidden characters
set listchars=tab:\ \ ,trail:·      " show · for trailing space, \ \ for trailing tab
set scrolloff=3                     " show next 3 lines while scrolling
set sidescrolloff=5                 " show next 5 columns while side-scrolling
set splitbelow                      " more natural horizontal split
set splitright                      " more natural vertical split
set clipboard=unnamedplus           " yanks puts it on clipboard
set cursorline                      " highlight line of cursor
set colorcolumn=100                 " show a right margin column
set expandtab                       " use spaces, not tabs
set shiftwidth=2                    " set tab width
set softtabstop=2
set tabstop=2
set completeopt+=noinsert           " omnicompletion options
set completeopt+=noselect
set completeopt-=preview
set lazyredraw                      " wait to redraw
set pumheight=10                    " completion window max size
set wrap                            " wrap long lines
set linebreak                       " do not break wrap in the middle of words
set updatetime=500                  " millis before cursorhold event is fired, useful for tern
set noshowmode                      " hide show mode status

" hide everywhere
set wildignore+=*.o,.git,.svn,node_modules,vendor,bower_components

set termguicolors                   " hicolor support and theme
colo cobalt2

au FileType elm set sw=4 sts=4 ts=4
au FileType python set noet
au FileType markdown setlocal spell

au BufRead,BufNewFile doc.go setlocal spell
au BufRead,BufNewFile .eslintrc setf json
au BufRead,BufNewFile .babelrc setf json
au BufRead,BufNewFile .tern-project setf json
au BufRead,BufNewFile *.jsdoc setf javascript.jsx

" auto save when focus lost (after tabbing away or switching buffers)
au FocusLost,BufLeave,WinLeave,TabLeave * silent! up

" open files where last edits took place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
au BufWritePost *.pu silent! Neomake!

" let g:python3_host_prog = '/usr/local/bin/python3'
" let g:python3_host_skip_check = 1

"===================== MAPPINGS ======================
let mapleader = ","

" fast quickfix window
map <c-n> :cn<cr>
map <c-p> :cp<cr>
nnoremap <leader>a :cclose<cr>

" fast save/quit
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<cr>

" fast escaping
imap jk <esc>

" screen center
nnoremap <space> zz

" clear highlight
nnoremap <leader><space> :noh<cr>

" map Y to match C and D
nnoremap Y y$

" yank entire file (global yank)
nmap gy ggVGy

" ignore lines when going up or down
nnoremap j gj
nnoremap k gk

" center next and prev search results
nnoremap n nzzzv
nnoremap N Nzzzv

" center when moving up and down
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz

" center jumps
nnoremap '' ''zz

" fix common q: :q mistype
map q: :q

" cycle between buffers
nmap <leader>. :b#<cr>

" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv

" pull word under cursor into lhs of a substitute (for quick search and replace)
nmap <leader>r :%s#\<<c-r>=expand("<cword>")<cr>\>#

" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//e<cr>:let @/=''<cr>

" insert path of current file into a command
cmap <c-p> <c-r>=expand("%:p:h") . "/" <cr>

" fast editing of the .vimrc
nmap <silent> <leader>v :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" allow saving when you forgot sudo
cmap w!! w !sudo tee % >/dev/null

" quick make
nmap <leader>m :make<cr>

" turn on spell checking
map <leader>sc :setlocal spell!<cr>

" spell checking shortcuts
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" gitup integration
nmap <silent> <leader>` :!gitup commit<cr><cr>

"===================== PLUGINS======================

"===================== delimitMate ======================
let delimitMate_expand_cr = 1 " auto indent {}<enter>

"===================== CtrlP ======================
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_map = ''                  " disable <c-p> shortcut
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'      " jump to a file if it's open already
let g:ctrlp_mruf_max = 450            " number of recently opened files
let g:ctrlp_max_files = 0             " do not limit the number of searchable files
let g:ctrlp_use_caching = 0
" let g:ctrlp_clear_cache_on_exit = 1
" let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

nnoremap <leader>g :CtrlPCurWD<cr>
nnoremap <leader>b :CtrlPBuffer<cr>

"===================== Ack ======================
" use ag for fast searches
let g:ackprg = 'ag --vimgrep --hidden'

nnoremap <leader>f :Ack<space>

"===================== neomake ======================
let g:neomake_open_list = 2
let g:neomake_list_height = 2
au! BufRead,BufWritePost * Neomake

map <leader>e :NeomakeSh open %<cr>

"===================== NERDTree ======================
let g:NERDTreeQuitOnOpen = 1 " hide explorer after open
let g:NERDTreeShowHidden = 1 " always show hidden files
let g:NERDTreeRespectWildIgnore = 1 " ignore wildignore matches

map <silent> <leader>n :NERDTreeToggle<cr>

"===================== lightline ======================
let g:lightline = {
  \ 'colorscheme': 'PaperColor',
  \ }

map <silent> <leader>n :NERDTreeToggle<cr>

"===================== deoplete ======================
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1 " path files from current buffer
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag']

" filetype specific settings
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.elm = '\.'
let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

"===================== tern_for_vim ======================
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:tern_show_argument_hints = 'on_hold'

au FileType javascript.jsx nmap gd :TernDef<cr>
au FileType javascript.jsx nmap <leader>r :TernRename<cr>

"===================== UltiSnips ======================
" enable supertab-like behavior
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"===================== markdownfmt ======================
let g:markdownfmt_autosave = 1

"===================== vim-javascript ======================
let g:javascript_plugin_jsdoc = 1

"===================== vim-jsx ======================
let g:jsx_ext_required = 0

"===================== vim-go ======================
let g:go_snippet_engine = "ultisnips"
let g:go_fmt_command = "goimports"

au FileType go nmap <leader>r :GoRename<cr>
au FileType go nmap <leader>c :GoCoverageToggle<cr>
au FileType go nmap <leader>t :GoTest<cr>
au FileType go nmap <leader>d :GoDeclsDir<cr>

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')

"===================== stylefmt ======================
au BufWritePre *.css :Stylefmt
au BufWritePre *.less :Stylefmt

"===================== fixmyjs ======================
" es6 test for javascript
au FileType javascript map <leader>e :100split \| term NODE_ENV=test node %<cr>

au BufWritePre *.js :Fixmyjs
au BufWritePre *.jsx :Fixmyjs

"===================== elm-vim ======================
let g:elm_format_autosave = 1

"===================== plantuml-syntax ======================
" java -splash:no -Djava.awt.headless=true needs to be added to run in background
let g:plantuml_executable_script = 'plantuml -tsvg -quiet $@'
