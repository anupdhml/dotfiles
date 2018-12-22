" text options
syntax on   " syntax highlight
set wrap    " Wrap too long lines
"set nowrap    " do not Wrap too long lines
"set textwidth=200   " text width
"set textwidth=0   " don't wrap words

" indent options
filetype plugin indent on   " auto-detect the filetype
"set tabstop=4   " Tabs are 4 characters
set tabstop=2   " Tabs are 2 characters
"setlocal softtabstop=4
"set softtabstop=2
"set shiftwidth=4    " (Auto)indent uses 4 characters
set shiftwidth=2    " (Auto)indent uses 2 characters
set expandtab   " spaces instead of tabs
set smarttab
set autoindent   " guess indentation
set smartindent  " smart autoindenting when starting a new line

"----------------------------------------------------------------------------

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Initialize plugin system
call plug#end()

"----------------------------------------------------------------------------

"if !has('gui_running')
"  set t_Co=256
"endif

" enable status bar
set laststatus=2

" this needs to be set before intializing colorschemes
set background=light

if $TERM == "rxvt-unicode-256color"
  colorscheme default_improved
else
  "set termguicolors
  "set background=light
  "colorscheme solarized8
  colorscheme flattened_light

  " italiicize comments, except on terminals that don't support it
  if $TERM == "linux"
    highlight Comment cterm=none ctermfg=darkgrey
  else
    highlight Comment cterm=italic
  endif
endif

let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ }

let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'powerline'
let g:tmuxline_preset = 'minimal'

"----------------------------------------------------------------------------

" Fast switching between buffers
" The current buffer will be saved before switching to the next one.
" Choose :bprevious or :bnext
 noremap  <silent> <S-tab>       :if &modifiable && !&readonly &&
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
inoremap  <silent> <S-tab>  <C-C>:if &modifiable && !&readonly &&
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
