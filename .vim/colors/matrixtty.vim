" vim:set ts=8 sts=2 sw=2 tw=0:
"
" matrixtty.vim - MATRIX like colorscheme, for tty
"
" Maintainer: psimpalton@gmail.com
" Last Modified: 2012, April 26

" Exact copy of matrix.vim by MURAOKA Taro <koron@tka.att.ne.jp>

" For this color scheme to work properly, place these in your bashrc
" will replace the colors in the comment
  "c0=121212 #background black
  "c8=3b3b3b 
  "c1=113311 #string red
  "c9=387f38
  "c2=55ff55 #type green
  "cA=aaffaa 
  "c3=55ff55 #statement yellow
  "cB=aaffaa
  "c4=44cc44 #identifier blue
  "cC=97f097 
  "c5=44cc44 #special magenta
  "cD=97f097
  "c6=226622 #comment cyan
  "cE=61b961
  "c7=339933 #cursorline white
  "cF=7fda7f

"if [ "$TERM" = "linux" ] && [ $(tty) != /dev/tty6 ]; then
    "echo -en "\e]P0$c0" #black
    "echo -en "\e]P8$c8" #darkgrey
    "echo -en "\e]P1$c1" #darkred
    "echo -en "\e]P9$c9" #red
    "echo -en "\e]P2$c2" #darkgreen
    "echo -en "\e]PA$cA" #green
    "echo -en "\e]P3$c3" #brown
    "echo -en "\e]PB$cB" #yellow
    "echo -en "\e]P4$c4" #darkblue
    "echo -en "\e]PC$cC" #blue
    "echo -en "\e]P5$c5" #darkmagenta
    "echo -en "\e]PD$cD" #magenta
    "echo -en "\e]P6$c6" #darkcyan
    "echo -en "\e]PE$cE" #cyan
    "echo -en "\e]P7$c7" #lightgrey
    "echo -en "\e]PF$cF" #white
    "#clear # show in these colors now
"fi

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = 'matrixtty'

" the character under the cursor
hi Cursor	ctermfg=6 ctermbg=2
hi lCursor	ctermfg=6 ctermbg=2
" like Cursor, but used when in IME mode |CursorIM|
hi CursorIM	ctermfg=6 ctermbg=2
" directory names (and other special names in listings)
hi Directory	ctermfg=3 ctermbg=0
" diff mode: Added line |diff.txt|
hi DiffAdd	ctermfg=3 ctermbg=6 cterm=none
" diff mode: Changed line |diff.txt|
hi DiffChange	ctermfg=3 ctermbg=6 cterm=none
" diff mode: Deleted line |diff.txt|
hi DiffDelete	ctermfg=1 ctermbg=1 cterm=none
" diff mode: Changed text within a changed line |diff.txt|
hi DiffText	ctermfg=3 ctermbg=7 cterm=bold
" error messages on the command line
hi ErrorMsg	ctermfg=2 ctermbg=7
" the column separating vertically split windows
hi VertSplit	ctermfg=7 ctermbg=7
" line used for closed folds
hi Folded	ctermfg=4 ctermbg=1
" 'foldcolumn'
hi FoldColumn	ctermfg=4 ctermbg=6
" 'incsearch' highlighting; also used for the text replaced with
hi IncSearch	ctermfg=6 ctermbg=2 cterm=none
" line number for ":number" and ":#" commands, and when 'number'
hi LineNr	ctermfg=4 ctermbg=0
" 'showmode' message (e.g., "-- INSERT --")
hi ModeMsg	ctermfg=5 ctermbg=0
" |more-prompt|
hi MoreMsg	ctermfg=5 ctermbg=0
" '~' and '@' at the end of the window, characters from
hi NonText	ctermfg=5 ctermbg=1
" normal text
hi Normal	ctermfg=4 ctermbg=0
" |hit-enter| prompt and yes/no questions
hi Question	ctermfg=5 ctermbg=0
" Last search pattern highlighting (see 'hlsearch').
hi Search	ctermfg=1 ctermbg=5 cterm=none
" Meta and special keys listed with ":map", also for text used
hi SpecialKey	ctermfg=5 ctermbg=0
" status line of current window
hi StatusLine	ctermfg=2 ctermbg=7 cterm=none
" status lines of not-current windows
hi StatusLineNC	ctermfg=1 ctermbg=7 cterm=none
" titles for output from ":set all", ":autocmd" etc.
hi Title	ctermfg=2 ctermbg=1 cterm=bold
" Visual mode selection
hi Visual	ctermfg=2 ctermbg=7 cterm=none
" Visual mode selection when vim is "Not Owning the Selection".
hi VisualNOS	ctermfg=4 ctermbg=0
" warning messages
hi WarningMsg	ctermfg=3 ctermbg=0
" current match in 'wildmenu' completion
hi WildMenu	ctermfg=6 ctermbg=3

hi Comment	ctermfg=6 ctermbg=0
hi Constant	ctermfg=3 ctermbg=6
hi Special	ctermfg=5 ctermbg=6
hi Identifier	ctermfg=2 ctermbg=0
hi Statement	ctermfg=2 ctermbg=0 cterm=bold
hi PreProc	ctermfg=7 ctermbg=0
hi Type		ctermfg=2 ctermbg=0 cterm=bold
hi Underlined	ctermfg=3 ctermbg=0 cterm=underline
hi Error	ctermfg=3 ctermbg=7
hi Todo		ctermfg=1 ctermbg=4 cterm=none
