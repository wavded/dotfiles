call plug#begin('~/.config/nvim/plugged')

Plug 'itchyny/lightline.vim'           " status line
Plug 'ctrlpvim/ctrlp.vim'              " goto file/buffer/mru/etc
Plug 'scrooloose/nerdtree'             " file explorer
Plug 'ivalkeen/nerdtree-execute'       " file explorer OS integration
Plug 'tpope/vim-surround'              " enable change around
Plug 'tpope/vim-repeat'                " repeating for change around
Plug 'tpope/vim-commentary'            " gcc and gc for comments
Plug 'SirVer/ultisnips'                " snippet support
Plug 'mhinz/vim-grepper'               " search across files
Plug 'w0rp/ale', { 'tag': '*' }        " lint on edit, fix on save
Plug 'godlygeek/tabular'               " re indentation
Plug 'wavded/cobalt2.vim'              " color theme
Plug 'terryma/vim-multiple-cursors'    " multiple cursor support
Plug 'eapache/auto-pairs'              " autoclose matching pairs

Plug 'Shougo/deoplete.nvim'            " auto complete
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'carlitux/deoplete-ternjs'
Plug 'mhartington/deoplete-typescript'
Plug 'racer-rust/vim-racer'
" Plug 'sebastianmarkow/deoplete-rust'

" filetype-specific plugins
Plug 'ternjs/tern_for_vim', { 'for': 'javascript.jsx' }
Plug 'moll/vim-node', { 'for': 'javascript.jsx' }
Plug 'pangloss/vim-javascript', { 'for': ['javascript.jsx', 'markdown'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript.jsx', 'markdown'] }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'reedes/vim-wordy', { 'for': 'markdown' }
Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'saltstack/salt-vim', { 'for': 'sls' }
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
Plug 'kylef/apiblueprint.vim', { 'for': 'apiblueprint' }
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'digitaltoad/vim-pug', { 'for': ['pug', 'jade'] }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }
Plug 'cespare/vim-toml', { 'for': 'toml' }

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
set updatetime=500                  " millis before cursorhold event, useful for tern
set noshowmode                      " hide show mode status

" hide everywhere
set wildignore+=*.o,.git,.svn,node_modules,vendor,bower_components,__jsdocs,coverage

set termguicolors                   " hicolor support and theme
colo cobalt2

au FileType python set noet

au BufRead,BufNewFile doc.go setlocal spell
au BufRead,BufNewFile .eslintrc setf json
au BufRead,BufNewFile Jenkinsfile setf groovy
au BufRead,BufNewFile .babelrc setf json
au BufRead,BufNewFile .tern-project setf json
au BufRead,BufNewFile *.jsdoc setf javascript.jsx
au FileType gitcommit setlocal spell
" au FileType apiblueprint setlocal tw=4 sw=4 ts=4

" auto save when focus lost (after tabbing away or switching buffers)
au FocusLost,BufLeave,WinLeave,TabLeave * silent! update

" open files where last edits took place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
" au BufWritePost *.pu silent! Neomake!

" let g:python3_host_prog = '/usr/local/bin/python3'
" let g:python3_host_skip_check = 1

"===================== MAPPINGS ======================
let mapleader = ","
let maplocalleader = ","

" wrap around support for :cnext/:cprevious and :lnext/:lprevious
function! WrapCommand(direction, prefix)
  if a:direction == "up"
    try
      execute a:prefix . "previous"
    catch /^Vim\%((\a\+)\)\=:E553/
      execute a:prefix . "last"
    catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
    endtry
  elseif a:direction == "down"
    try
      execute a:prefix . "next"
    catch /^Vim\%((\a\+)\)\=:E553/
      execute a:prefix . "first"
    catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
    endtry
  endif
endfunction

" fast quickfix window
nnoremap <silent> <c-h> :call WrapCommand('up', 'c')<cr>
nnoremap <silent> <c-l>  :call WrapCommand('down', 'c')<cr>

" fast location window
nnoremap <silent> <c-p> :call WrapCommand('up', 'l')<cr>
nnoremap <silent> <c-n>  :call WrapCommand('down', 'l')<cr>

" fast close qf/loc windows
nnoremap <leader>a :cclose<cr>:lclose<cr>

" fast open current file in default application
nnoremap <silent> <leader>o :!open %<cr>

" fast save/quit
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :qa!<cr>

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

" allow saving when you forgot sudo
cmap w!! w !sudo tee % >/dev/null

" quick make
nmap <leader>m :make<cr>

" gitup integration
nmap <silent> <leader>` :!gitup commit<cr><cr>

" show syntax highlighting groups for word under cursor
nmap <leader>z :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"===================== PLUGINS======================

"===================== CtrlP ======================
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_map = ''                  " disable <c-p> shortcut
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'      " jump to a file if it's open already
let g:ctrlp_mruf_max = 450            " number of recently opened files
let g:ctrlp_max_files = 0             " do not limit the number of searchable files
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'rg --files --hidden %s'

nnoremap <leader>g :CtrlPCurWD<cr>
nnoremap <leader>b :CtrlPBuffer<cr>


"===================== auto-pairs ======================
let g:AutoPairsUseInsertedCount = 1

"===================== grepper ======================
" use rg for fast searches
let g:ackprg = 'rg --vimgrep --hidden'

runtime autoload/grepper.vim
" let g:grepper.simple_prompt = 1
" let g:grepper.rg.grepprg .= ' --smart-case'

nnoremap <leader>f :Grepper -tool rg<cr>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

"===================== multiple-cursors ======================

let g:multi_cursor_next_key='<C-j>'
let g:multi_cursor_prev_key='<C-k>'

"===================== ale ======================
let g:ale_sign_column_always = 0
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '?'
highlight clear ALEErrorSign
highlight clear ALEWarningSign

let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_fix_on_save = 1
let g:ale_linters = {}
let g:ale_linters.go = ['gometalinter']
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

"===================== neomake ======================
" let g:neomake_open_list = 2
" let g:neomake_list_height = 2
" au! BufReadPost,BufWritePost * Neomake

" let g:neomake_typescript_eslint_maker = {
"       \ 'args': ['-f', 'compact'],
"       \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
"       \ '%W%f: line %l\, col %c\, Warning - %m'
"       \ }
" let g:neomake_typescript_enabled_makers = ['eslint', 'tsc']
" let g:neomake_go_enabled_makers = ['go', 'golint', 'govet']

" map <leader>e :NeomakeSh open %<cr>

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
let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1
" let g:deoplete#sources#rust#racer_binary = 'racer'
" let g:deoplete#sources#rust#rust_source_path = '$RUST_SRC_PATH'

"===================== tern_for_vim ======================
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:tern_show_argument_hints = 'on_hold'

au FileType javascript.jsx nmap gd :TernDef<cr>
au FileType javascript.jsx nmap <leader>r :TernRename<cr>

"===================== UltiSnips ======================
" enable supertab-like behavior
let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

"===================== markdown ======================
au FileType markdown setlocal spell
au FileType markdown setlocal colorcolumn=

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_fenced_languages = ['js=javascript', 'bash=sh']

"===================== vim-javascript ======================
" es6 test for javascript
au FileType javascript.jsx map <leader>e :100split \| term NODE_ENV=test babel-node %<cr>
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

au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')

"==================== vim-racer / rust =====================
let g:rustfmt_autosave = 1
let g:racer_cmd = "racer"
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap <leader>e :RustRun<cr>

"===================== plantuml-syntax ======================
" java -splash:no -Djava.awt.headless=true needs to be added to run in background
let g:plantuml_executable_script = 'plantuml -tsvg -quiet $@'

"===================== postgresql ======================
let g:sql_type_default = 'pgsql'

"===================== FUNCTIONS ======================

function! JsEchoError(msg)
  redraw | echon "js: " | echohl ErrorMsg | echon a:msg | echohl None
endfunction

" Swapping between test file and main file.
function! JsSwitch(bang, cmd)
  let file = expand('%')
  if empty(file)
    call JsEchoError("no buffer name")
    return
  elseif file =~# '^\f\+_test\.js$'
    let l:root = split(file, '_test.js$')[0]
    let l:alt_file = l:root . ".js"
  elseif file =~# '^\f\+\.js$'
    let l:root = split(file, ".js$")[0]
    let l:alt_file = l:root . '_test.js'
  else
    call JsEchoError("not a js file")
    return
  endif
  if empty(a:cmd)
    execute ":edit " . alt_file
  else
    execute ":" . a:cmd . " " . alt_file
  endif
endfunction

au Filetype javascript command! -bang A call JsSwitch(<bang>0, '')

" Format Markdown files.
function! MarkdownFormat()
   let save_pos = getpos(".")
   let query = getreg('/')
   execute ":0,$!tidy-markdown"
   call setpos(".", save_pos)
   call setreg('/', query)
endfunction

au BufWritePre *.md :call MarkdownFormat()
