call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color' 
Plug 'itchyny/lightline.vim'

" LSP clients
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jelera/vim-javascript-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'posva/vim-vue'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'rust-lang/rust.vim'

" GUI enhancements
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

" Theme
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

" Html close tag
Plug 'alvan/vim-closetag'

" Rust and Toml
Plug 'cespare/vim-toml' 

" telescope
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-lua/telescope.nvim'
call plug#end()

filetype plugin indent on
syntax on
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
set spell spelllang=en_us
set smartcase
set ignorecase
set tabstop=2
set shiftwidth=2
set expandtab
set wildmenu

set wildignore+=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js
set wildignore+=*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
set wildignore+=**/node_modules/**

set t_Co=256
set background=dark
set showmatch
set belloff=all
set scrolloff=6 

" requires Xsel installed
set clipboard+=unnamedplus
set mouse=a

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
" set list
" set lcs=tab:»,nbsp:¬,extends:»,precedes:«,trail:•
" set lcs=tab:»_,trail:•,eol:¬

if has("autocmd") 
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue'


" Permanent undo
set undodir=~/.vimdid
set undofile

colorscheme gruvbox
let &t_SI.="\<Esc>[5 q"

" netrw
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -r'

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1

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
set noerrorbells
set termguicolors

" I really don't need preview
let g:fzf_preview_window = []

" Open my config in a vertical split window
nnoremap <Leader><CR> :vs ~/.config/nvim/init.vim<CR>
noremap <silent> <C-p> :Files<CR>
noremap <silent> <C-g> :GFiles<CR>
noremap <silent> <leader>p :Files ~/devel<CR>
nnoremap <silent> <leader><leader> :Buffers<CR>
nnoremap <silent> <leader>m :Marks<CR>

nnoremap <silent> <leader>/ :Ag<CR>
nnoremap <silent> <leader>A :Ag!<C-R><C-W><CR>
nnoremap <silent> <leader>ll :Lines<CR> 
nnoremap <silent> <leader>lb :BLines<CR> 

nnoremap <silent> <leader>fc :Colors<CR>
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <leader>; :Commands<CR>
nnoremap <silent> <leader>h :Helptags<CR>
nnoremap <silent> <leader>f :PRg<CR>

nnoremap <PageUp> :bn<CR>
nnoremap <PageDown> :bp<CR>

" FZF.vim now supports this command out of the box
" so this code is no longer needed.
command! -bang -nargs=* RG
      \ call fzf#vim#grep(
      \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
      \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
      \   <bang>0)
nnoremap <C-g> :PRg<Cr>

command! -bang -nargs=* PRg
      \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)


" Terminal maps
:tnoremap <Esc> <C-\><C-n>


" nnoremap <C-p> :lua require'telescope.builtin'.find_files()<CR>
" nnoremap <C-P> :lua require'telescope.builtin'.find_files{ cwd = "~/devel" }<CR>
" nnoremap <C-g> :lua require'telescope.builtin'.git_files()<CR>
" nnoremap <leader>/ :lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({ winblend = 10 }))<CR>

" Use tab to focus to window
" My own implementation of open tab and set cursor position to actual buffer
" position
nnoremap <silent> <F1> :lua require'drocha'.open_tab()<CR>
nnoremap <F2> :tabclose<CR>

inoremap <C-c> <esc>

if executable('rg')
  let g:rg_derive_root='true'
endif

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

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


" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use to CocFix.
nmap <silent> gf <Plug>(coc-fix)

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

" Remap for format selected region
" vmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"
" if !exists('g:airline_powerline_fonts')
"   let g:airline#extensions#tabline#left_sep = ' '
"   let g:airline#extensions#tabline#left_alt_sep = '|'
"   let g:airline_left_sep          = '▶'
"   let g:airline_left_alt_sep      = '»'
"   let g:airline_right_sep         = '◀'
"   let g:airline_right_alt_sep     = '«'
"   let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
"   let g:airline#extensions#readonly#symbol   = '⊘'
"   let g:airline#extensions#linecolumn#prefix = '¶'
"   let g:airline#extensions#paste#symbol      = 'ρ'
" else
"   let g:airline#extensions#tabline#left_sep = ''
"   let g:airline#extensions#tabline#left_alt_sep = ''
" 
"   " powerline symbols
"   let g:airline_left_sep = ''
"   let g:airline_left_alt_sep = ''
"   let g:airline_right_sep = ''
"   let g:airline_right_alt_sep = ''
"   let g:airline_symbols.branch = ''
"   let g:airline_symbols.readonly = ''
"   let g:airline_symbols.linenr = ''
" endif

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

