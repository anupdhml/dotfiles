"----------------------------------------------------------------------------

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Initialize plugin system
call plug#end()

"----------------------------------------------------------------------------

if $TERM == "rxvt-unicode-256color"
  colorscheme default_improved
else
  "set termguicolors
  "set background=light
  "colorscheme solarized8
  colorscheme flattened_light

  highlight Comment cterm=italic
endif

"----------------------------------------------------------------------------
