" Config file for gvim
" This is applied in addition to vimrc

" hack to start gvim maximized
set lines=999 columns=159

" visibility of gui elements
set guioptions-=m " turn off menu bar
set guioptions-=T " turn off toolbar
set guioptions-=L " turn off left scrollbar
set guioptions-=r " turn off right scrollbar

" copy selection to primary clipboard (paste with middle-mouse/S-insert)
set guioptions+=a

" align font with what we use in the terminal
set guifont=Dejavu\ Sans\ Mono\ 16

" colorscheme overrides (to match with urxvt profile)
"hi Normal guifg=#323232 guibg=#f0f0f0
