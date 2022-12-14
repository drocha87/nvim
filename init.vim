call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
" Plug 'jiangmiao/auto-pairs'
" Plug 'machakann/vim-sandwich'
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color' 
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'

" LSP clients
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jelera/vim-javascript-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'posva/vim-vue'
Plug 'prettier/vim-prettier'
" Plug 'leafOfTree/vim-vue-plugin'
Plug 'rust-lang/rust.vim'

" GUI enhancements
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

" Theme
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'cormacrelf/vim-colors-github'

" Html close tag
Plug 'alvan/vim-closetag'

" Rust and Toml
Plug 'cespare/vim-toml' 

Plug 'chriskempson/base16-vim'
" Vim treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } 

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

filetype plugin indent on
set nocompatible
set encoding=UTF-8
set number relativenumber
set nu rnu
set colorcolumn=81
set autoindent
set smartindent
set cursorline
set splitbelow splitright 
set nobackup nowritebackup
set laststatus=2 
set cmdheight=1
set backspace=indent,eol,start confirm
set autoread wildmode=longest,list,full
" set spell spelllang=en_us
set smartcase
set ignorecase
set gdefault
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set wildmenu
set path+=.,**
" highlight ActiveWindow ctermbg=00 
" highlight InactiveWindow ctermbg=226
" set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

set wildignore+=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js
set wildignore+=*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
set wildignore+=**/node_modules/**

" set t_Co=256
set showmatch
set belloff=all
set scrolloff=6 

set background=dark
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-gruvbox-dark-hard

syntax on
hi Normal ctermbg=NONE

" requires Xsel installed
set clipboard+=unnamedplus
set mouse=a

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/
nnoremap ; :

" TreeSitter
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"   },
" } 
" EOF

" Show those damn hidden characters
" Verbose: set listchars=nbsp:??,eol:??,extends:??,precedes:??,trail:???
" set list
" set lcs=tab:??,nbsp:??,extends:??,precedes:??,trail:???
" set lcs=tab:??_,trail:???,eol:??

if has("autocmd") 
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue'

" Permanent undo
set undodir=~/.vimdid
set undofile

" colorscheme gruvbox
let &t_SI.="\<Esc>[5 q"

" netrw
" let g:netrw_browse_split = 2
" let g:netrw_banner = 0
" let g:netrw_winsize = 25
" let g:netrw_localrmdir='rm -r'

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
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

" go_def_mapping_enabled
let g:go_def_mapping_enabled=0

let mapleader=" "
set incsearch
set hlsearch

set nohlsearch
" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

set noerrorbells
set termguicolors

" Resize window factor improved
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>> :vertical resize +10<CR>
nnoremap <silent> <Leader>< :vertical resize -10<CR>

" I really don't need preview
let g:fzf_preview_window = []

" As we remap terminal escape we need to fix this remap in fzf
" ass suggested in this issue https://github.com/junegunn/fzf/issues/1393
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

" Open my config in a vertical split window
nnoremap <silent> <leader><leader> :Telescope find_files<CR>
nnoremap <silent> <leader>bb :Telescope buffers<CR>
nnoremap <silent> <leader>sp :Telescope live_grep<CR>

nnoremap <Leader><CR> :vs ~/.config/nvim/init.vim<CR>
noremap <silent> <C-g> :Files<CR>
noremap <silent> <C-p> :GFiles<CR>
noremap <silent> <leader>p :Files ~/devel<CR>
nnoremap <silent> <leader>m :Marks<CR>

nmap <silent> <C-_> :Ag<CR>
nnoremap <silent> <leader>A :Ag!<C-R><C-W><CR>
nnoremap <silent> <leader>ll :Lines<CR> 
nnoremap <silent> <leader>lb :BLines<CR> 

nnoremap <silent> <leader>fc :Colors<CR>
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <leader>; :Commands<CR>
nnoremap <silent> <leader>h :Helptags<CR>
nnoremap <silent> <leader>f :PRg<CR>

nnoremap <PageUp> :tabn<CR>
nnoremap <PageDown> :tabp<CR>

" Terminal maps
tnoremap <Esc> <C-\><C-n>

" Vim fugitive
nnoremap <F12> :tab G<CR> 

" Use tab to focus to window
" My own implementation of open tab and set cursor position to actual buffer
" position
nnoremap <silent> <F1> :lua require'drocha'.open_tab()<CR>
nnoremap <F4> :tabclose<CR>

inoremap <C-c> <esc>

if executable('rg')
  let g:rg_derive_root='true'
endif

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" if hidden is not set, TextEdit might fail.
set hidden
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

let g:coc_global_extensions = [ 'coc-tsserver', 'coc-json', 'coc-html', 'coc-vetur', 'coc-prettier' ]


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" completion improvements
" set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use to CocFix.
" nmap <silent> gf <Plug>(coc-fix)

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ }

