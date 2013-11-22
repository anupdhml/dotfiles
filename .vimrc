" my vimrc file

"==============================================================================
" One liners
"==============================================================================

" enable all features
set nocompatible    

" pathogen
call pathogen#infect()

" text options
syntax on   " syntax highlight
"set wrap    " Wrap too long lines
"set nowrap    " do not Wrap too long lines
"set textwidth=80   " text width
"set textwidth=0   " don't wrap words

" indent options
filetype plugin indent on   " auto-detect the filetype
set tabstop=4   " Tabs are 4 characters
"set tabstop=2   " Tabs are 2 characters
"setlocal softtabstop=4
set shiftwidth=4    " (Auto)indent uses 4 characters
"set shiftwidth=2    " (Auto)indent uses 2 characters
set expandtab   " spaces instead of tabs
set smarttab
set autoindent   " guess indentation
set smartindent  " smart autoindenting when starting a new line 

" searching
set hlsearch    " highlight the searchterms
set incsearch   " jump to the matches while typing
set ignorecase    " ignore case while searching
set smartcase      " case sensitive when using capitals in search phrase

" wildmode enhancements
set wildchar=<Tab>    " Expand the command line using tab
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions                                                                                            
set wildmenu                    " command-line completion
set wildmode=list:longest,full  " command-lne completion, greates wild mode

" set some vars
set history=1000    " history
set undolevels=1000   " 1000 undo levels
set completeopt=menuone,longest " Always show the menu, insert longest match
set backspace=indent,eol,start    " powerful backspaces
set browsedir=current   " use current dir for explorer    
set lcs=tab:>-,eol:$,nbsp:X,trail:#    " strings to use in 'list' mode
"set popt=left:8pc,right:3pc     " print options
"set foldmethod=marker   " Fold using markers {{{ like this }}}
"set foldmethod=manual

" other options
set autowrite " write before hiding a buffer
"set noru
set ruler   " show the cursor position all the time
set showcmd   " show partial commands
set showmatch   " show matching braces
set esckeys "map missed escape sequences (enables keypad keys)
set magic   " change the way backslashes are used in search patterns
"set showmode   " show the current mode
"set visualbell                  " visual bell instead of beeping
set hidden " allows hidden buffers to stay unsaved
"set backup     " keep a backup file
set mouse=a " enable mouse
"set mouse=v " enable mouse only in visual mode
set shm+=I  " hide intro message
"set shortmess=at
"set cmdheight=1 
"set cmdwinheight=7
"set columns=9999

" printing
"set printexpr=system('gtklp'\ .\ '\ '\ .\ v:fname_in)\ .\ delete(v:fname_in)\ +\ v:shell_error
"set pdev=pdf
"set printoptions=paper:A4,syntax:y,wrap:y,duplex:long
set printoptions=left:10mm,right:10mm,top:10mm,bottom:10mm,paper:A4,header:2,syntax:y
"set printfont=Times\ New\ Roman\ 16
set printfont=monospace:h10
"set printfont=courier_new:h9

"==============================================================================
" Mappings and shortcuts
"==============================================================================

" With a map leader it's possible to do extra key combinations like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"----------
" templates
"----------
"autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e
function! LoadTemplate()
  silent! 0r ~/.vim/skel/tmpl.%:e
  " Highlight %VAR% placeholders with the Todo colour group
  syn match Todo "%\u\+%" containedIn=ALL
endfunction
autocmd! BufNewFile * call LoadTemplate()
"Jump between %VAR% placeholders in Normal mode with
" <Ctrl-p>
"nnoremap <c-p> /%\u.\{-1,}%<cr>c/%/e<cr>
"Jump between %VAR% placeholders in Insert mode with
" <Ctrl-p>
"inoremap <c-p> <ESC>/%\u.\{-1,}%<cr>c/%/e<cr>

" for black and white printing
"map <C-S-p> :color print_bw<CR>:hardcopy<CR>:color print_bw<CR>:syn on<CR>
"map <C-p> :color print_bw<CR>:hardcopy<CR>:color mycolors<CR>:syn on<CR>

"-------------
" indentations
"-------------
" [l and ]l jump to the previous or the next line with the same indentation level as the current line.
" [L and ]L jump to the previous or the next line with an indentation level lower than the current line
"
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction
" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>

" -------------
" function keys
" -------------
" F1   -  (help, standard)
"
" F2   - control the statusline
" Key mapping to toggle the display of status line for the last window
nmap <silent> <F2> :if &laststatus == 1<bar>
                 \set laststatus=2<bar>
                 \set noshowmode<bar>
                 \echo<bar>
               \else<bar>
                 \set laststatus=1<bar>
                 \set showmode<bar>
               \endif<CR>
"noremap <silent> <F2> <Esc>:set laststatus=2<CR>
"noremap <silent> <S-F2> <Esc>:set laststatus=1<CR>
"noremap <silent> <C-F2> <Esc>:set laststatus=0<CR>
"
" F3  -  toggle linenumbers, and highlight states
map   <silent> <F3>       :set nonumber!<CR>
imap  <silent> <F3>  <Esc>:set nonumber!<CR>
nnoremap <S-F3>           :set cursorcolumn!<CR>
nnoremap <C-F3>           :set cursorline!<CR>
nnoremap <A-F3>           :call HighlightNearCursor()<CR>
"
" F4   -  call file explorer Ex. Or nerdtree.
"map   <silent> <F4>        :Explore<CR>
"imap  <silent> <F4>   <Esc>:Explore<CR>
map   <silent> <F4>        :NERDTreeToggle<CR>
imap  <silent> <F4>   <Esc>:NERDTreeToggle<CR>
" old taglist
"noremap <silent>  <F4>       <Esc>:Tlist<CR>
"inoremap <silent> <F4>  <Esc><Esc>:Tlist<CR>
"
" F5   -  remove highlight, refresh syntax, refresh file
map   <silent> <F5>        :set hls!<bar>set hls?<CR>
map   <silent> <S-F5>      :syntax sync fromstart<CR>
map   <silent> <C-F5>      :e!<CR>
imap  <silent> <F5>   <Esc>:set hls!<bar>set hls?<CR>
imap  <silent> <S-F5> <Esc>:syntax sync fromstart<CR>
imap  <silent> <C-F5> <Esc>:e!<CR>
"
" F6   -  toggle showing hidden whitespace
nnoremap <silent> <F6> :set list!<CR>
" remove trailing spaces on the current line
nnoremap <silent> <S-F6> :silent s/\s\+$//<CR>
" remove trailing spaces on entire buffer without altering the cursor position
nnoremap <silent> <C-F6> :silent %s/\s\+$//<CR>
"
"F7    -  transliterate
"
" F8   -  toggle comment (nerd commenter) 
map   <silent> <F8>         ,c<Space>          
map   <silent> <S-F8>       ,ca          
"vmap   <silent> <F8>         ,c<Space>          
"vmap   <silent> <S-F8>       ,ca          
imap  <silent> <F8>    <Esc>,c<Space>          
imap  <silent> <S-F8>  <Esc>,ca          
" C-F8   - insert code snippets (C IDE))
map   <silent> <C-F8>       ,nr
imap  <silent> <C-F8>  <Esc>,nr
"
" F9  -  syntastic error window (alt, ctrl, shift - compile, csupport)
"nmap   <silent> <F9>      :Errors<CR>
" alternative for above
nmap <silent> <F9> :call ToggleList("Location List", 'l')<CR><c-w>j
"nmap <silent> <F9> :call ToggleList("Location List", 'l')<CR>
"inoremap <F9> <Esc>:make<CR>
"
" F10   -  syntastic display previous and next error
map   <F10>        :lnext<CR>
imap  <F10>   <Esc>:lnext<CR>
map   <S-F10>      :lprevious<CR>
imap  <S-F10> <Esc>:lprevious<CR>
"map   <silent> <F10>        :cp<CR>
"map   <silent> <S-F10>      :cn<CR>
"imap  <silent> <F10>   <Esc>:cp<CR>
"imap  <silent> <S-F10> <Esc>:cn<CR>
"
" F11    -  better folding 
nnoremap <silent> <F11> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <F11> zf
"
" open/close quickfix error window
"map   <silent> <F11>        :copen<CR>
"map   <silent> <S-F11>      :cclose<CR>
"imap  <silent> <F11>   <Esc>:copen<CR>
"imap  <silent> <S-F11> <Esc>:cclose<CR>
"
" F12   -  tagbar toggle
" S-F12 -  show tag under curser in the preview window (tagfile must exist!)
noremap <silent>  <F12>       <Esc>:TagbarToggle<CR>
inoremap <silent> <F12>  <Esc><Esc>:TagbarToggle<CR>
nmap  <silent> <S-F12>        :exe ":ptag ".expand("<cword>")<CR>
imap  <silent> <S-F12>   <Esc>:exe ":ptag ".expand("<cword>")<CR>

"----------------------------------------------
" autocomplete parenthesis, brackets and braces
"----------------------------------------------
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
"
vnoremap ( s()<Esc>P<Right>%
vnoremap [ s[]<Esc>P<Right>%
vnoremap { s{}<Esc>P<Right>%

"---------------------------------------------
" autocomplete quotes (visual and select mode)
"---------------------------------------------
xnoremap  '  s''<Esc>P<Right>
xnoremap  "  s""<Esc>P<Right>
xnoremap  `  s``<Esc>P<Right>

"---------------------------------
" comma always followed by a space
"---------------------------------
"inoremap  ,  ,<Space>
"

"--------
" buffers
"--------
" Fast switching between buffers
" The current buffer will be saved before switching to the next one.
" Choose :bprevious or :bnext
 noremap  <silent> <S-tab>       :if &modifiable && !&readonly && 
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
inoremap  <silent> <S-tab>  <C-C>:if &modifiable && !&readonly && 
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR> 

"--------
" pasting
"--------
"set paste insert mode toggle
"set pastetoggle=tp
" Map paste from system clipboard to S-p
"nnoremap <S-p> :r !xclip -o<CR>
"vnoremap <S-p> :r !xclip -o<CR>
" Map paste from system clipboard to c-p
nnoremap cp "+p<cr>
vnoremap cp "+p<cr>
" Map copy to system clipboard to S-y
nnoremap <S-y> "+yy<cr>
vnoremap <S-y> "+yy<cr>
" Map copy to system clipboard to cy. Follow with a motion movement
nnoremap cy "+y
vnoremap cy "+y
"
" Replace default keys
" Map copy to system clipboard to y. Replaces normal yank
"nnoremap y "+y
"vnoremap y "+y
" Map paste from system clipboard to p. Replaces normal paste
"nnoremap p "+p<cr>
"vnoremap p "+p<cr>

"--------------------------
" tabs, windows, and splits 
"--------------------------
" tab navigation (next tab) with alt left / alt right arrow keys
"nnoremap  <a-s-right>  gt
"nnoremap  <a-s-left>   gT
" Control tab for rotating between tabs
"map <C-Tab> :tabnext<CR> 
" windows navigation
nmap <a-left> <C-W>h
nmap <a-right> <C-W>l
nmap <a-down> <C-W>j
nmap <a-up> <C-W>k
"split
"map <c-s-i> :vsplit<CR>  " changes tab behaviour
"map <c-s-o> :split<CR>
"map <c-s-l> :vsplit<CR>
"map <c-s-h> :split<CR>
"map <c-l> :vsplit<CR> " choice
"map <c-h> :split<CR>

"-----------------------
" Awesome tab completion
"-----------------------
" InsertTabWrapper() {{{
" Tab completion of tags/keywords if not at the beginning of the
" line.  Very slick.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
" InsertTabWrapper() }}}
" Make tab perform keyword/tag completion if we're not following whitespace
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

"------
"others
"------
"scroll fast
"
noremap <C-Down> <C-D>
noremap <C-Up> <C-U>
"
" <space> scrollers
"map <Space> <PageDown>
"nmap <Space> <C-D>
"nnoremap <S-Space> <C-U>
"vnoremap <Space> <C-D>
"vnoremap <S-Space> <C-U>
"
" Capitalize inner word
"map <M-c> guiw~w
" UPPERCASE inner word
"map <M-u> gUiww
" lowercase inner word
"map <M-l> guiww
" just one space on the line, preserving indent
"map <M-Space> m`:s/\S\+\zs \+/ /g<CR>``:nohl<CR>
"
" various bindings to add blank lines.
nmap <Return> o<Esc>
"nnoremap <S-Return> i<Return><Esc>
"nmap <silent> o o<Esc>
"noremap <silent> <S-o> o
"
" typos
cmap Q q
cmap W w
"
" After shifting a visual block, select it again
vnoremap < <gv
vnoremap > >gv
"
" map incrementing numbers
nnoremap <C-n> <C-a>
"
" map Ctrl-A, Ctrl-E, and Ctrl-K in *all* modes. map! makes the mapping work in
" insert and commandline modes too.
map  <C-A> <Home>
map  <C-E> <End>
"map  <C-K> J
map! <C-A> <Home>
map! <C-E> <End>
"imap <C-K> <Esc>Ji
"
"Improve escape key. Do not move cursor when exiting from insert
"inoremap <Esc> <Esc>`^
"
"
"ctrl right and left issues
"nmap  <C-Right> w
"nmap  <C-Left> b
"
"
" For alternate plugin
noremap   <Leader>a        :A<CR>
inoremap   <Leader>a   <C-C>:A<CR>
noremap   <Leader>as        :AS<CR>
inoremap   <Leader>as   <C-C>:AS<CR>
noremap   <Leader>av        :AV<CR>
inoremap   <Leader>av   <C-C>:AV<CR>

"nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
"nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

"==============================================================================
" auto commands...
"==============================================================================

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" turn on spell check for these files
"autocmd FileType {txt,html} set spell
autocmd BufNewFile,BufRead *.txt,*.html,README set spell

" shiftwidth, softtabstop for html and xml files
au FileType {html,xml} setlocal sw=2 sts=2

" The current directory is the directory of the file in the current window.
autocmd BufEnter * :lchdir %:p:h

" most accurate but slowest result
autocmd BufEnter * :syntax sync fromstart
" faster way..
"autocmd BufEnter * :syntax sync minlines=200

"autocmd VimEnter * NERDTree
"autocmd BufEnter * NERDTreeMirror

"==============================================================================
" commands...
"==============================================================================

" When you forget sudo
"command! -bar -nargs=0 SudoW :silent exe “w !sudo tee %"
cmap w!! w !sudo tee % >/dev/null

" open help files in a vertical split
cnoremap help vert belowright help
"cnoremap h vert belowright help


"==============================================================================
" language, and plugin specific
"==============================================================================

" use ghc functionality for haskell files
au BufEnter *.hs compiler ghc
let g:ghc="/usr/bin/ghc"

" configure browser for haskell_doc.vim
let g:haddock_browser = "/usr/bin/midori"
let g:haddock_indexfiledir = "$HOME/.vim/"

" C syntax settings
let c_C99 = 1
"let c_comment_strings=1
let c_space_errors=1

" global vars for C IDE
let g:C_MapLeader = ','
let g:C_CCompiler = '$HOME/bin/gccmine-alt'
"let g:C_CCompiler = 'gcc -Wall -pedantic -std=c99'
" To suppress the creation of a new header file when switching from a source file
let g:alternateNoDefaultAlternate = 1

" taglist.vim : toggle the taglist window
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_Close_On_Select         = 1
"let Tlist_Inc_Winwidth = 0

" taglist.vim : define the title texts for make
"let tlist_make_settings  = 'make;m:makros;t:targets'
"let tlist_qmake_settings = 'qmake;t:SystemVariables'
" ----------  qmake : set filetype for *.pro  ----------
"autocmd BufNewFile,BufRead *.pro  set filetype=qmake

" for the transliterate plugin
let transliterateMode = 'xsampa'
let g:transliterateMode = 'xsampa'
"nmap <F7> <Plug>TransliterateApply
nmap <F7> <Plug>TransliterateApply<C-e>
imap <F7> <Esc><Plug>TransliterateApply<C-e><i>
vmap <F7> <Plug>TransliterateApply
"nmap <Leader>t <Plug>TransliterateApply
"vmap <Leader>t <Plug>TransliterateApply

" for ctrlp
let g:ctrlp_map = '<c-\>'
let g:ctrlp_cmd = 'CtrlP'

set noshowmode " now that we have powerline, no need for this

" old powerline
""let g:Powerline_symbols = 'fancy'
""let g:Powerline_stl_path_style = 'relative'
"let Powerline_stl_path_style = 'filename'
"let g:Powerline_stl_path_style = 'short'
"let g:Powerline_stl_path_style = 'full'
"let g:Powerline_colorscheme = 'skwp'
"call Pl#Theme#InsertSegment('currhigroup', 'before', 'fileformat')
"Shows a segment indicating that the current buffer has trailing white spaces.
""call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

" new powerline
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim

" Instantly leave insert mode when pressing <Esc> {{{
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!

        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
" }}}

" syntastic
"let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=2
"
" On by default, turn it off for html
"let g:syntastic_mode_map = { 'mode': 'active',
	"\ 'active_filetypes': [],
	"\ 'passive_filetypes': ['python'] }

" supertab
"let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabMappingForward = '<s-tab>'
let g:SuperTabMappingBackward = '<tab>'
"let g:SuperTabLongestHighlight=1
""let g:SuperTabCrMapping=1

" for markdown files. disable folding
"let g:vim_markdown_folding_disabled=1


"==============================================================================
" Interface enhancements
"==============================================================================

" 256 colors
"set t_Co=256
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm

if $TERM =~ '^xterm*'
        set t_Co=256 
elseif $TERM =~ '^rxvt*'
        set t_Co=256
elseif $TERM =~ '^linux'
        "set t_Co=16
        set t_Co=8
else
        set t_Co=16
endif

"skip csapprox for default
"let g:CSApprox_hook_default_pre = 'hi _FakeGroup ctermbg=257'
"let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

" fix screen italics
"if $TERM =~ 'screen'
    "" WARNING: ^[ must be entered as <c-v><c-[>

    "set t_so=^[[7m
    "set t_ZH=^[[3m
"endif

" background
"set bg=dark

" show line numbers
"set number

"----------
"Cursorline
"----------

" highlight current word
"nnoremap <Leader>w :call HighlightNearCursor()<CR>
function HighlightNearCursor()
  if !exists("s:highlightcursor")
    match Todo /\k*\%#\k*/
    let s:highlightcursor=1
  else
    match None
    unlet s:highlightcursor
  endif
endfunction

" by default, set the highlight for current line
set cursorline

" automatic highlighting
au WinLeave * set nocursorline
au WinEnter * set cursorline

"-----------
" Statusline
"-----------

" first, enable status line always
set laststatus=2

" Format the statusline
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ [FORMAT=%{&ff}]\ [TYPE=%Y]\ \ Line:\ %l/%L:%c\ \ 
"set statusline=%<[%02n]\ %F%(\ %m%h%w%y%r%)\ %a%=\ %8l,%c%V/%L\ (%P)\ [%08O:%02B]
"set statusline+=%{SyntaxItem()}
"set statusline=%<%f%h%m%r%=%{&ff}\ %l,%c%V\ %P
"set statusline+=%#warningmsg#
"
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
"set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%1*%F%m%r%h%w%=%(%c%V\ %l/%L\ %P%)
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=%{strftime(\"%c\",getftime(expand(\"%:p\")))}
if has('statusline')
  "set statusline=%#Question#                   " set highlighting
  set statusline+=%-2.2n\                      " buffer number
  "set statusline+=%#WarningMsg#                " set highlighting
  set statusline+=%f\                          " file name
  "set statusline+=%#Question#                  " set highlighting
  set statusline+=%h%m%r%w\                    " flags
  set statusline+=%{strlen(&ft)?&ft:'none'},   " file type
  set statusline+=%{(&fenc==\"\"?&enc:&fenc)}, " encoding
  set statusline+=%{((exists(\"+bomb\")\ &&\ &bomb)?\"B,\":\"\")} " BOM
  set statusline+=%{&fileformat}              " file format
  "set statusline+=%{&spelllang},               " language of spelling checker
  set statusline+=%=                           " ident to the right
  set statusline+=%{SyntaxItem()}\               " syntax highlight group under cursor
  "set statusline+=0x%-8B\                      " character code under cursor
  "set statusline+=%-7.(%l,%c%V%)\ %<%P         " cursor position/offset
  set statusline+=%-7.(\|%l/%L:%c\|%V%)\ %<%P         " cursor position/offset
endif
"
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction
"
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

"------------
" colorscheme
"------------

"if &t_Co < 256
    ""colorscheme miro8   " colourscheme for the 8 colour linux term
""else
    ""colorscheme miromiro
""endif

"function! Tmuxintty()
    "let shellcmd = 'w | grep tty1 | grep tmux'
    "let output=system(shellcmd)
    ""if !v:shell_error
    "if (output)
        "return 0
    "else
        "return 1
    "endif
"endfunction

"if ($TERM == "linux" && $TTY == "/dev/tty1")
if ($DISPLAY == "") " in tty
  if ( ($TTY == "/dev/tty1") || $TMUXINTTY == 1 ) " matrix in tty1, for tmux too
    "colorscheme matrixtty
    colorscheme matrixtty_mod
  "elseif ($TERM == "linux") " not for tmux
  else
    colorscheme mycolorstty
  endif
else " in urxvt and elsewhere
  colorscheme mycolors
endif


"==============================================================================
" functions
"==============================================================================

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction


" toggling location lists
function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction


"==============================================================================
"others
"==============================================================================

"lang support
set keymap+=greek_utf-8
set imi=0 ims=0 "start with a additional keymap
"set but inactive

"set clipboard=unnamedplus,autoselect " Use + register (X Window clipboard) as unnamed register

" Low priority filename suffixes for filename completion {{{
set suffixes-=.h        " Don't give .h low priority
set suffixes+=.aux
set suffixes+=.log
set wildignore+=*.dvi
set suffixes+=.bak
set suffixes+=~
set suffixes+=.swp
set suffixes+=.o
set suffixes+=.class
" }}}

"if &term =~ '^rxvt'
    "tmux will send xterm-style keys when xterm-keys is on
    "execute "set <xUp>=\e[1;*A"
    "execute "set <xDown>=\e[1;*B"
    "execute "set <xRight>=\e[1;*C"
    "execute "set <xLeft>=\e[1;*D"
"endif

" This fixes key codes in rxvt-unicode. Can be set in ~/.Xdefaults, but
" that did not translate to GNU Screen. By placing it in this file it needs less
" total code.
" press ctrl-v then the keys. (important!)
"map OA <C-Up>
"map OB <C-Down>
"map OC <C-Right>
"map OD <C-Left>
"map [5~] <C-PageUp>
"map [6~] <C-PageDown>
"map [7~] <C-Home>
"map [8~] <C-End>

" In insert mode, the below commands should be executed. <C-o> switches to
" command mode for a single command.
"
" If I could have written e.g.
" imap <C-Up> <C-o><C-Up>
" , then the code could have been substantially shortened, but it doesn't seem to
" work in GNU Screen or tmux.
"
" If mode() realiably could determine the current mode, all the logic could have
" been sorted in ScreenMovement()
"imap OA <C-o><C-Up>
"imap OB <C-o><C-Down>
"imap OC <C-o><C-Right>
"imap OD <C-o><C-Left>
"imap [7~] <C-o><C-Home>
"imap [8~] <C-o><C-End>

"map [a] <S-Up>
"map ^[[b <S-Down>
"map ^[[c <S-Right>
"map ^[[d <S-Left>
" Mappings must be given separately for insert mode, even if they do the same
" thing. I don't know why.
"imap ^[[a <S-Up>
"imap ^[[b <S-Down>
"imap ^[[c <S-Right>
"imap ^[[d <S-Left>

" Fixes key codes in tmux.
"if &term =~ "^screen"
    "map ^[[1;5A <C-Up>
    "map ^[[1;5B <C-Down>
    "map ^[[1;5C <C-Right>
    "map ^[[1;5D <C-Left>
    "map ^[[5;5~ <C-PageUp>
    "map ^[[6;5~ <C-PageDown>
    "map ^[[1;5H <C-Home>
    "map ^[[1;5F <C-End>
    "imap ^[[1;5A <C-o><C-Up>
    "imap ^[[1;5B <C-o><C-Down>
    "imap ^[[1;5C <C-o><C-Right>
    "imap ^[[1;5D <C-o><C-Left>
    "imap ^[[1;5H <C-o><C-Home>
    "imap ^[[1;5F <C-o><C-End>
    "" Shift is only sent if "xterm-keys on" is set in tmux.
    "map ^[[1;2A <S-Up>
    "map ^[[1;2B <S-Down>
    "map ^[[1;2C <S-Right>
    "map ^[[1;2D <S-Left>
    "imap ^[[1;2A <S-Up>
    "imap ^[[1;2B <S-Down>
    "imap ^[[1;2C <S-Right>
    "imap ^[[1;2D <S-Left>
"endif

" use cron job to remove the backup files...
"set backup         " use backup files
"set backupdir=~/.vim-backup    " collect backup files

" Persistent undo - new function in Vim 7.3.
" Create the directory manually.
" use cron job to remove the undo files...
"set undodir=~/.vim/undodir
"set undofile

" All on man
" clear the PAGER environment variable inside of Vim.
" This is to handle the case where you start Vim normally and want
" to use Vim's Man function
let $PAGER=''
"
" you now have a :Man command available
runtime ftplugin/man.vim
"
" K subbed to use the :Man command
nmap K :Man <cword><CR>

set dictionary+=/usr/share/dict/words

" useful for restore view plugin
set viewoptions=cursor,folds,slash,unix 
" let g:skipview_files = ['*\.vim'] ]

"-----------------------------------------------------------------------------
" to preserve view of the file (includes folds...)

if exists("g:loaded_restore_view")
    finish
endif
let g:loaded_restore_view = 1


if !exists("g:skipview_files")
    let g:skipview_files = []
endif

function! MakeViewCheck()
    if has('quickfix') && &buftype =~ 'nofile' | return 0 | endif
    if expand('%') =~ '\[.*\]' | return 0 | endif
    if empty(glob(expand('%:p'))) | return 0 | endif
    if &modifiable == 0 | return 0 | endif
    if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
    if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif

    let file_name = expand('%:p')
    for ifiles in g:skipview_files
        if file_name =~ ifiles
            return 0
        endif
    endfor

    return 1
endfunction

augroup AutoView
    autocmd!
    " Autosave & Load Views.
    autocmd BufWritePost,WinLeave,BufWinLeave ?* if MakeViewCheck() | mkview | endif
    autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
augroup END

"-----------------------------------------------------------------------------
