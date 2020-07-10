" Vim color file
" Maintainer: psimpalton@gmail.com
" Last Change:	2012 September 29

" imroved from the default scheme

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "default_improved"

" vim: sw=2

"==============================================================================

" current line
"hi CursorLine cterm=NONE ctermbg=darkgrey ctermfg=white guibg=darkgrey guifg=white
"hi CursorLine cterm=NONE ctermbg=254 guibg=#DEDEDE
"hi CursorLine cterm=NONE ctermbg=lightgreen guibg=lightblue
"hi CursorLine cterm=bold
hi CursorLine cterm=NONE ctermbg=lightgrey guibg=lightgrey

" current column
"hi CursorColumn cterm=bold
hi CursorColumn cterm=NONE ctermbg=lightgrey guibg=lightgrey

" line no
"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
"highlight LineNr term=bold cterm=NONE ctermfg=8 ctermbg=none
highlight LineNr term=bold cterm=NONE ctermfg=8 ctermbg=7 guifg=#6C6C6C guibg=#D3D7CF

" vertsplit line
"hi VertSplit ctermfg=lightgrey ctermbg=lightgrey cterm=NONE guifg=lightgrey guibg=lightgrey
hi VertSplit ctermfg=black ctermbg=black cterm=NONE guifg=black guibg=black

" status line
"hi statusline ctermfg=darkgrey ctermbg=white
"hi StatusLine ctermfg=black ctermbg=lightgrey cterm=bold,italic guifg=black guibg=lightgrey gui=bold,italic
"hi StatusLineNC ctermfg=black ctermbg=lightgrey cterm=italic guifg=black guibg=lightgrey gui=italic
"hi StatusLine ctermfg=lightgrey ctermbg=black cterm=bold,italic guifg=lightgrey guibg=black gui=bold,italic
"hi StatusLineNC ctermfg=lightgrey ctermbg=black cterm=italic guifg=lightgrey guibg=black gui=italic
" choice
hi StatusLine ctermfg=lightgrey ctermbg=black cterm=italic guifg=lightgrey guibg=black gui=italic
hi StatusLineNC ctermfg=darkgrey ctermbg=black cterm=italic guifg=darkgrey guibg=black gui=italic

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
"hi Folded term=standout ctermfg=4 ctermbg=248 guifg=DarkBlue guibg=LighGrey
hi Folded term=standout cterm=italic ctermfg=8 ctermbg=7 guifg=#6C6C6C gui=italic
"hi Folded term=standout cterm=italic ctermfg=4 ctermbg=7 gui=italic

" for completion menus
hi Pmenu ctermbg=7 guibg=lightgrey
hi PmenuSel ctermbg=248 guibg=grey

" for vim-clap popups
" search bar. matches PmenuSel, with term adjustments mainly
hi ClapInput term=reverse ctermbg=248 guibg=grey
hi ClapSearchText cterm=bold ctermbg=248 gui=bold guibg=grey
hi ClapSpinner cterm=bold ctermfg=24 gui=bold ctermbg=248 guifg=darkblue guibg=grey
" entry selection. matches PmenuSel
hi ClapCurrentSelection ctermbg=248 guibg=grey
hi ClapCurrentSelectionSign ctermbg=248 guibg=grey
hi ClapSelected ctermbg=248 guibg=grey
hi ClapSelectedSign ctermbg=248 guibg=grey
" results for `:Clap files`. matches Pmenu
hi ClapFile ctermbg=7 guibg=lightgrey
" cursor at the search bar. matches terminal (urxvt) cursor color
hi ClapPopupCursor cterm=bold ctermfg=8 gui=bold guifg=black

" better highlighting for selection in quickfix/location list
hi QuickFixLine ctermbg=lightgrey

" for plugins like syntastic/ale
hi SignColumn term=standout ctermfg=8 ctermbg=7 guifg=#6C6C6C guibg=#D3D7CF

" for vim-ale
" error/warn indicators on the sidebar
hi ALEWarningSign ctermbg=lightgrey ctermfg=darkyellow
hi ALEErrorSign ctermbg=lightgrey ctermfg=darkred
" error positions
hi ALEWarning term=reverse ctermbg=lightyellow gui=undercurl guisp=lightyellow
hi ALEError term=reverse ctermbg=lightred gui=undercurl guisp=red

" -------------------
"
" Syntax Highlighting
" -------------------

" comments
if $TERM == "rxvt-unicode-256color" || $TERM == "rxvt-unicode" || $TERM == "xterm-256color" || $TERM == "screen-it"
    highlight Comment cterm=italic ctermfg=8 guifg=#6C6C6C gui=italic
else
    highlight Comment cterm=none ctermfg=8 guifg=#6C6C6C gui=italic
endif

" identifier and functions
"highlight Function cterm=none ctermfg=0 guifg=black
"highlight Identifier cterm=none ctermfg=4 guifg=darkblue
highlight Identifier cterm=none ctermfg=24 guifg=darkblue

" types
highlight Type cterm=bold ctermfg=64 guifg=darkgreen
highlight Typedef cterm=bold ctermfg=64 guifg=darkgreen
highlight Structure cterm=bold ctermfg=64 guifg=darkgreen
highlight StorageClass cterm=bold ctermfg=64 guifg=darkgreen

" improvement on c syntax highlighting
highlight cFunction cterm=none ctermfg=0 guifg=black
""highlight cFunction cterm=none ctermfg=90 guifg=#870087
""highlight cFunction cterm=bold ctermfg=6  " Bold Cyan
""highlight cFunction cterm=none ctermfg=4  " Blue
"highlight cIdentifier cterm=none ctermfg=4 guifg=darkblue
"highlight cType cterm=bold ctermfg=64 guifg=darkgreen
"highlight cTypedef cterm=bold ctermfg=64 guifg=darkgreen
"highlight cStructure cterm=bold ctermfg=64 guifg=darkgreen
"highlight cStorageClass cterm=bold ctermfg=64 guifg=darkgreen
highlight cStructureType cterm=bold ctermfg=64 guifg=darkgreen
highlight cStorageClassError cterm=bold ctermfg=64 guifg=darkgreen
