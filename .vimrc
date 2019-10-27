" init vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug '/usr/local/opt/fzf' " load existing fzf
Plug 'junegunn/fzf.vim' 
Plug 'airblade/vim-gitgutter' 
Plug 'joshdick/onedark.vim' 
Plug 'sheerun/vim-polyglot' " syntax support for various languages
Plug 'w0rp/ale' " LSP client + linting
Plug 'tpope/vim-fugitive' " git integration
Plug 'Quramy/tsuquyomi' " typescript stuff
Plug 'alampros/vim-styled-jsx' " styled jsx syntax

call plug#end()


" not compatible with old vim
set nocompatible

" colors
colorscheme onedark
syntax on " enable syntax processing

" spaces and tabs
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number od spaces per tab when editing
set expandtab " tabs are spaces
set autoindent " automatic indenting for buffers not associated with a filetype

" ui config
set mouse=a
set showmode " show which mode vim is in
set number " show line number
"set relativenumber " show relative line number
set showcmd " show command in bottom bar
set cursorline " highlights current line
filetype plugin indent on " load filetype-specific files
set lazyredraw " avoid useless redraws
set showmatch " highligh matching brackets []
set ruler " shows the current line number at the bottom right
set nowrap " disable line wrap
set wildmenu "visual autocomplete for command menu
set wildmode=list:longest,list:full " show full list of matches
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__ 

" editing
set backspace=indent,eol,start " proper backspace behavior
set autoread " automatically read file that has changed on disk
set hidden " possibility to have more than one unsaved buffers
" remap autocomplete
inoremap <C-Space> <C-x><C-o> 
inoremap <C-@> <C-x><C-o>
" remap save
nnoremap <leader>w :w<CR>
" remap quit
nnoremap <leader>q :q<CR>

" searching
set incsearch " search as chars are entered
set hlsearch " highlight search matches
set ignorecase " case insensitive search
set smartcase " case sensitive when uppcase is used
" turn off search highlighs
nnoremap <esc><esc> :silent! nohls<cr>
" nnoremap <leader><space> :nohlsearch<CR> 

" folding
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " fold based on indent level

" movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" move to beginning/end of line
nnoremap B ^
nnoremap E $

" leader shortcuts
let mapleader=" " " leader is comma
" jk is escape
inoremap jk <esc>
" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp ~/.vimrc<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>
" set working directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" fuzzy file search with fzf. -m enables multi select with <tab>
nnoremap <leader>e :FZF -m<CR>
nnoremap <C-p> :FZF -m<CR>
" search with ripgrep
nnoremap <leader>f :Rg<CR>
" most recent files
nmap <C-y> :History<CR>
" command history through fzf
nmap <leader>y :History:<CR>
" force hover
nnoremap <C-q> :ALEHover<CR>

"" buffers
" navigate to next buffer
nnoremap <tab> :bnext<CR>
" navigate to prev buffer
nnoremap <S-tab> :bprev<CR>
" close buffer
" nnoremap <leader>bd :bd<CR>
nmap <leader>bd :bp\|bd #<CR>
" list buffers
nnoremap <leader>bl :Buffers<CR>
" save buffer
nnoremap <leader>s :w<CR>

"" tabs
" create new tab
nnoremap <leader>tn :tabnew<CR>
" close tab
nnoremap <leader>td :tabclose<CR>

"" windows
" open split windows below and on the right
set splitbelow
set splitright
" vertical and horizontal splitting
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>
" close window
nnoremap <leader>wd <C-W>q
" easier window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" aliases for common mispelled commands
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall


"" plugins config

" ale
let g:ale_fixers = ['prettier', 'eslint'] " enable linters
let g:ale_fix_on_save = 1 " autofix lint issues on save
let g:ale_completion_enabled = 1 " enable ale own autocompletion
set omnifunc=ale#completion#OmniFunc
" go to definition
nnoremap <leader>gd :ALEGoToDefinition<CR>
nnoremap <leader>fr :ALEFindReferences<CR>
nnoremap <leader>gtd :ALEGoToTypeDefinition<CR>

" fzf
" use rg for fzf file search
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

" tsuquyomi
let g:tsuquyomi_shortest_import_path = 1

