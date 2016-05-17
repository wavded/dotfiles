let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

call plug#begin('~/.config/nvim/plugged')
" plugins
Plug 'tpope/vim-surround'           " enable change around
Plug 'tpope/vim-repeat'             " repeating for change around
Plug 'bling/vim-airline'            " status line
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ivalkeen/nerdtree-execute', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'tomtom/tcomment_vim'
Plug 'moll/vim-node'
Plug 'benekastah/neomake'
Plug 'majutsushi/tagbar'
Plug 'heavenshell/vim-jsdoc'
Plug 'kewah/vim-stylefmt'
Plug 'Raimondi/delimitMate'

" ft
Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'chrisbra/Colorizer'
Plug 'tpope/vim-markdown'
Plug 'digitaltoad/vim-jade'
Plug 'fatih/vim-go', { 'tag': 'v1.6' }
Plug 'millermedeiros/vim-esformatter'
Plug 'moorereason/vim-markdownfmt'
Plug 'rodjek/vim-puppet'
Plug 'pearofducks/ansible-vim'

" autocomplete
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'carlitux/deoplete-ternjs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" color
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'fatih/molokai'
Plug 'mkarmona/colorsbox'
Plug 'mhartington/oceanic-next'
call plug#end()

let mapleader = "\<Space>"

set autoread
set nobackup
set nohlsearch
set nowritebackup
set noswapfile
set autowrite                       " save files automatically in most cases
set showcmd                         " show typed commands
set wildignore+=*.o,.git,.svn
set ignorecase                      " case insensitive search...
set smartcase                       " ...unless capitals are used
set shiftwidth=2                    " set tab width
set softtabstop=2
set tabstop=2
set expandtab                       " use spaces, not tabs
set hidden                          " allow background buffers w/out writing
set list                            " show hidden characters
set listchars=tab:\ \ ,trail:·      " show · for trailing space, \ \ for trailing tab
set colorcolumn=100                 " show a right margin column
set textwidth=100
set scrolloff=3                     " show next 3 lines while scrolling
set sidescrolloff=5                 " show next 5 columns while side-scrolling
set splitbelow                      " more natural splits
set splitright
set clipboard=unnamedplus           " yanks put in clipboard
set completeopt+=noinsert
set completeopt+=noselect
set completeopt-=preview

colo OceanicNext " terminal theme
set background=dark

let g:python3_host_prog  = '/usr/local/bin/python3'
let g:python3_host_skip_check = 1

" ADDITIONAL KEY MAPPINGS

" fast saving
nmap <leader>w :up<cr>

" fast escaping
imap jk <esc>

" clear highlight
nnoremap <leader>h :noh<cr>

" map Y to match C and D behavior
nnoremap Y y$

" yank entire file (global yank)
nmap gy ggVGy

" ignore lines when going up or down
nnoremap j gj
nnoremap k gk

" auto complete {} indent and position the cursor in the middle line
let delimitMate_expand_cr = 1
" inoremap {<CR>  {<CR>}<Esc>O
" inoremap (<CR>  (<>)<Esc>O
" inoremap [<CR>  [<CR>]<Esc>O

" cycle between buffers
nmap <leader>. :b#<cr>
nmap <leader>[ :bp<cr>
nmap <leader>] :bn<cr>

" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv

" pull word under cursor into lhs of a substitute (for quick search and replace)
nmap <leader>r :%s#\<<C-r>=expand("<cword>")<CR>\>#

" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//e<cr>:let @/=''<CR>

" insert path of current file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" fast editing of the .vimrc
nmap <silent> <leader>v :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" allow saving when you forgot sudo
cmap w!! w !sudo tee % >/dev/null

" turn on spell checking
map <leader>sc :setlocal spell!<cr>

" spell checking shortcuts
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" gitup integration
nmap <silent> <leader>c :!gitup commit<cr><cr>

" neovim terminal bindings
tnoremap <c-[> <c-\><c-n>
map <leader>ts :20split \| term<cr>
map <leader>tv :vsplit \| term<cr>

"" ADDITIONAL AUTOCOMMANDS

" close scratch when selection is made in OmniCompletion
au CursorMovedI * if pumvisible() == 0|pclose|endif
au InsertLeave * if pumvisible() == 0|pclose|endif

" saving when focus lost (after tabbing away or switching buffers)
au FocusLost,BufLeave,WinLeave,TabLeave * silent! up

" open in last edit place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
au QuickFixCmdPost *grep* cwindow

"" ABBREVIATIONS
source $HOME/.config/nvim/autocorrect.vim

"" PLUGIN SETTINGS
let g:netrw_liststyle = 3  " use tree style for netrw

" CTRLP
let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore .git --ignore node_modules --ignore bower_components --ignore vendor --hidden -g ""'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 0

nnoremap <leader>o :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>

" Ag
let g:ag_prg = 'ag --vimgrep --ignore .git --ignore node_modules --ignore bower_components --ignore vendor --hidden'
nnoremap <leader>f :Ag<space>
nnoremap K :Ag "\b<c-r><c-w>\b"<cr>

" Neomake
let g:neomake_open_list = 2
let g:neomake_list_height = 2
autocmd! BufRead,BufWritePost * Neomake
map <leader>e :NeomakeSh open %<cr>

" Airline
let g:airline_powerline_fonts = 1
let g:airline_section_warning = airline#section#create(['%{go#jobcontrol#Statusline()}'])
let g:airline_theme = 'oceanicnext'

" NERDTree
set shortmess=at
map <silent> <leader>n :NERDTreeToggle<cr>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeRespectWildIgnore = 1

" Tagbar
let g:tagbar_singleclick = 1
map <silent> <leader>t :TagbarToggle<cr>

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 15
let g:deoplete#auto_completion_start_length = 1

let g:tern_request_timeout = 5

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"" LANGUAGE SPECIFIC
au BufRead,BufNewFile .eslintrc set filetype=json
au BufRead,BufNewFile .babelrc set filetype=json
au BufRead,BufNewFile .tern-project set filetype=json

" Python
au FileType python set noexpandtab

" Markdown
au FileType markdown setlocal spell
au FileType markdown set wrap
let g:markdownfmt_autosave = 1

" JSX
let g:jsx_ext_required = 0

" Go
let g:go_snippet_engine = "ultisnips"
let g:go_fmt_command = "goimports"
au FileType go map <leader>d :GoDef<cr>
au FileType go map <leader>r :GoRename<cr>
au FileType go map <leader>i :GoImport<space>
au FileType go map <leader>a :GoAlternate<cr>

" CSS / Less
" autocmd BufWritePre *.css :Stylefmt
" autocmd BufWritePre *.less :Stylefmt

" JavaScript
let g:jsdoc_allow_input_prompt = 0
au FileType javascript map <leader>e :200split \| term NODE_ENV=test babel-node %<cr>
" au FileType javascript map <leader>d :TernDef<cr>
" au FileType javascript map <leader>r :TernRename<cr>
au Filetype javascript nmap <silent> <C-l> ?function<cr>:noh<cr><Plug>(jsdoc)
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1
au FileType javascript setlocal omnifunc=tern#Complete
au BufWritePre *.js :Esformatter
au BufWritePre *.jsx :Esformatter
