call plug#begin('~/.config/nvim/plugged')

" general plugins
Plug 'ctrlpvim/ctrlp.vim'              " goto file/buffer/mru/etc
Plug 'tpope/vim-surround'              " enable change around
Plug 'tpope/vim-repeat'                " repeating for change around
Plug 'tpope/vim-commentary'            " gcc and gc for comments
" Plug 'adelarsq/vim-matchit'            " extended matching with %
" Plug 'mhinz/vim-grepper'               " search across files
Plug 'godlygeek/tabular'               " re indentation
Plug 'SirVer/ultisnips'                " snippet support
Plug 'neoclide/coc.nvim', {'branch': 'release'} " lsp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax
Plug 'nvim-treesitter/playground' " syntax

" filetype-specific plugins
" Plug 'yuezk/vim-js', { 'for': ['javascript','javascriptreact'] }
" Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript','typescriptreact'] }
" Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascriptreact','typescriptreact'] }
" Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'martinda/Jenkinsfile-vim-syntax', { 'for': 'Jenkinsfile' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'saltstack/salt-vim', { 'for': 'sls' }
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'digitaltoad/vim-pug', { 'for': ['pug', 'jade'] }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
" Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }
" Plug 'cespare/vim-toml', { 'for': 'toml' }

" theme and statusbar
" Plug 'marko-cerovac/material.nvim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'bluz71/vim-moonfly-statusline'

call plug#end()

" autocorrects for common misspellings
source $HOME/.config/nvim/autocorrect.vim

"===================== SETTINGS ======================
set autoread                        " auto reload file if changed externally
set nobackup                        " no ~backup files
set noswapfile                      " no swap files
set nowritebackup                   " no write backup
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
set colorcolumn=80                 " show a right margin column
set expandtab                       " use spaces, not tabs
set shiftwidth=2                    " set tab width
set softtabstop=2
set tabstop=2
set completeopt+=noinsert           " omnicompletion options
set completeopt+=noselect
set completeopt+=preview            " show further details of completion in preview window
set lazyredraw                      " wait to redraw
set pumheight=10                    " completion window max size
set wrap                            " wrap long lines
set linebreak                       " do not break wrap in the middle of words
set updatetime=300                  " millis before cursorhold event
set noshowmode                      " hide show mode status
set nocursorline                    " prevent cursorline (performance)
set shortmess+=c
set termguicolors                   " hicolor support and theme

" hide everywhere
set wildignore+=*.o,.git,.svn,node_modules,vendor,bower_components,__jsdocs,.nyc_output,coverage,target

colo nightfly
let g:moonflyWithCocIndicator = 1
let g:moonflyWithGitBranchCharacter = 1
let g:moonflyIgnoreDefaultColors = 1

set guicursor=
hi NonText guifg=bg
" hi link CocUnusedHighlight TSVariable

au FileType python set noet
au BufRead,BufNewFile doc.go setlocal spell
au BufRead,BufNewFile .eslintrc setf json
au BufRead,BufNewFile .prettierrc setf json
au BufRead,BufNewFile .babelrc setf json
au BufRead,BufNewFile *.jsdoc setf javascript
au FileType gitcommit setlocal spell
au BufRead,BufNewFile * setlocal signcolumn=yes:1
au FileType tagbar setlocal signcolumn=no

" auto save when focus lost (after tabbing away or switching buffers)
au FocusLost,BufLeave,WinLeave,TabLeave * silent! update

" open files where last edits took place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" restore terminal cursor on exit
au VimLeave * set guicursor=a:hor100-blinkon0

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
nnoremap <silent> <leader>o :!open %<cr><cr>

" fast save/quit
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :qa!<cr>

" fast escaping
imap <c> <esc>

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
" nmap <leader>r :%s#\<<c-r>=expand("<cword>")<cr>\>#

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
"
"===================== TreeSitter ======================
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- "all", "maintained" or a list of languages
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

"===================== CtrlP ======================
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_map = ''                  " disable <c-p> shortcut
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'      " jump to a file if it's open already
let g:ctrlp_mruf_max = 450            " number of recently opened files
let g:ctrlp_max_files = 0             " do not limit the number of searchable files
let g:ctrlp_use_caching = 0
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_user_command = 'fd -H -t f -c never "" %s'

nnoremap <leader>g :CtrlPCurWD<cr>
nnoremap <leader>b :CtrlPBuffer<cr>

"===================== grepper ======================
" use rg for fast searches
" let g:ackprg = 'rg --vimgrep --hidden --smart-case -F'

" " runtime autoload/grepper.vim
" let g:grepper = {}
" let g:grepper.simple_prompt = 1
" let g:grepper.side = 1
" let g:grepper.prompt_quote = 1

" nnoremap <leader>f :Grepper -tool rg -grepprg rg --vimgrep --smart-case --hidden -F<cr>

" set grepprg=rg\ --vimgrep\ --smart-case
" set grepformat=%f:%l:%c:%m,%f:%l:%m

nnoremap <leader>f :CocSearch 
" nnoremap gs :silent grep <c-r><c-w><cr>:copen<cr>

"===================== ultisnips  ===========================
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

"===================== markdown ======================
au FileType markdown setlocal spell
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_fenced_languages = ['js=javascript', 'bash=sh']

"==================== coc.nvim =====================
" adapted from https://github.com/neoclide/coc.nvim readme
let g:coc_global_extensions = ['coc-tsserver', 'coc-css', 'coc-json', 'coc-go', 'coc-rls', 'coc-phpls', 'coc-yaml', 'coc-prettier', 'coc-snippets', 'coc-eslint', 'coc-git', 'coc-explorer', 'coc-deno' ]

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)

vmap <leader>f  <Plug>(coc-format-selected)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <silent> ac <Plug>(coc-codeaction)
nmap <silent> qf <Plug>(coc-fix-current)

nmap <leader>rn <Plug>(coc-rename)

nmap <silent> <C-j> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-k> <Plug>(coc-diagnostic-next)
nmap <leader>p <Plug>(coc-refactor)
nmap <leader>c :<C-u>CocList commands<cr>
nmap <leader>d :<C-u>CocList diagnostics<cr>

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" add missing imports on save
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

map <silent> <leader>n :CocCommand explorer<cr>

"===================== vim-go ======================
" let g:go_snippet_engine = "ultisnips"
let g:go_fmt_autosave = 0
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_gopls_enabled = 0

"==================== rust =====================
let g:rustfmt_autosave = 0
au FileType rust nmap <leader>e :RustRun<cr>

"===================== plantuml-syntax ======================
" java -splash:no -Djava.awt.headless=true needs to be added to run in background
let g:plantuml_executable_script = 'PLANTUML_LIMIT_SIZE=8192 plantuml -tsvg -quiet $@'

"===================== postgresql ======================
let g:sql_type_default = 'pgsql'

"===================== FUNCTIONS ======================
au FileType javascript map <leader>e :100split \| term NODE_ENV=test nyc babel-node %<cr>
au FileType typescript map <leader>e :100split \| term NODE_ENV=test TS_NODE_FILES=true nyc ts-node %<cr>

function! TestEchoError(msg)
  redraw | echon "test: " | echohl ErrorMsg | echon a:msg | echohl None
endfunction

" Swapping between test file and main file.
function! TestSwitch(bang, cmd, ext)
  let file = expand('%')
  if empty(file)
    call TestEchoError("no buffer name")
    return
  elseif file =~# '^\f\+_test\.' . a:ext . '$'
    let l:root = split(file, '_test.' . a:ext . '$')[0]
    let l:alt_file = l:root . "." . a:ext
  elseif file =~# '^\f\+\.' . a:ext . '$'
    let l:root = split(file, "." . a:ext . "$")[0]
    let l:alt_file = l:root . '_test.' . a:ext
  else
    call TestEchoError("not a " . a:ext . " file")
    return
  endif
  if empty(a:cmd)
    execute ":edit " . alt_file
  else
    execute ":" . a:cmd . " " . alt_file
  endif
endfunction

au Filetype javascript command! -bang A call TestSwitch(<bang>0, '', 'js')
au Filetype typescript command! -bang A call TestSwitch(<bang>0, '', 'ts')
au Filetype javascriptreact command! -bang A call TestSwitch(<bang>0, '', 'jsx')
au Filetype typescriptreact command! -bang A call TestSwitch(<bang>0, '', 'tsx')
au Filetype go command! -bang A call TestSwitch(<bang>0, '', 'go')
