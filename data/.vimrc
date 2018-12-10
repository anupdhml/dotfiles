"----------------------------------------------------------------------------

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Initialize plugin system
call plug#end()

"----------------------------------------------------------------------------

"colorscheme flattened_light

"set termguicolors
"let g:solarized_use16 = 1
"set background=light
"colorscheme solarized8

"highlight Comment cterm=italic

colorscheme default_improved
