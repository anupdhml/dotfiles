" Vim color file
" Maintainer: psimpalton@gmail.com	
" Last Change:	2012 September 29

" imroved from the default scheme, for tty

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" for tty, usually black
set bg=dark

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "mycolorstty"

" vim: sw=2

"==============================================================================

"if $TERM == "linux"

" current line
"hi CursorLine cterm=NONE ctermbg=lightgrey guibg=lightgrey
hi CursorLine cterm=none ctermbg=none
"hi CursorLine cterm=none ctermbg=2

" current column
"hi CursorColumn cterm=NONE ctermbg=lightgrey guibg=lightgrey
hi CursorColumn cterm=none ctermbg=none
"hi CursorColumn cterm=NONE ctermbg=2

" line no 
"highlight LineNr term=bold cterm=NONE ctermfg=8 ctermbg=7 guifg=#6C6C6C guibg=#D3D7CF
highlight LineNr term=bold cterm=bold ctermfg=0 ctermbg=8
"highlight LineNr cterm=none ctermfg=0 ctermbg=2

" vertsplit line
"hi VertSplit ctermfg=black ctermbg=black cterm=NONE guifg=black guibg=black
hi VertSplit ctermfg=7 ctermbg=7 cterm=NONE
"hi VertSplit ctermfg=2 ctermbg=2 cterm=NONE

" status line
"hi StatusLine ctermfg=lightgrey ctermbg=black cterm=italic guifg=lightgrey guibg=black gui=italic 
"hi StatusLineNC ctermfg=darkgrey ctermbg=black cterm=italic guifg=darkgrey guibg=black gui=italic 
hi StatusLine ctermfg=0 ctermbg=7 cterm=none
hi StatusLineNC ctermfg=0 ctermbg=7 cterm=bold
"hi StatusLine ctermfg=0 ctermbg=2 cterm=none
"hi StatusLineNC ctermfg=7 ctermbg=2 cterm=none

" keep consistent color when changing windows
"au WinLeave * hi statusline ctermfg=darkgrey ctermbg=white
"au WinEnter * hi statusline ctermfg=darkgrey ctermbg=white

" Highlight status line based on the mode
"if version >= 700
  "au InsertEnter * hi StatusLine ctermfg=blue ctermbg=white
  "au InsertLeave * hi StatusLine ctermfg=darkgrey ctermbg=white
  ""au InsertLeave * hi StatusLine ctermfg=darkgrey ctermbg=white
"endif

" for folds
hi Folded term=standout ctermfg=8 ctermbg=7

" -------------------
" Syntax Highlighting
" -------------------

" comments
highlight Comment cterm=bold ctermfg=0 

" identifier and functions
"highlight Function cterm=none ctermfg=2
"highlight Identifier cterm=bold ctermfg=none
highlight Identifier cterm=none ctermfg=4

" types
highlight Type cterm=bold ctermfg=2
highlight Typedef cterm=bold ctermfg=2
highlight Structure cterm=bold ctermfg=2
highlight StorageClass cterm=bold ctermfg=2

" improvement on c syntax highlighting
highlight cFunction cterm=none ctermfg=7
highlight cStructureType cterm=bold ctermfg=2
highlight cStorageClassError cterm=bold ctermfg=2

"endif
