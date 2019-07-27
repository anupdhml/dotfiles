" Config file for vim

" enable all vim features
set nocompatible

" enable filetype detection as well as type-specific plugin/indentation
filetype plugin indent on

" text options
syntax on " syntax highlight
set wrap " wrap long lines
"set textwidth=100 " text width

" indent options
"set tabstop=4    " Tabs are 4 characters
"set shiftwidth=4 " (Auto)indent uses 4 characters
set tabstop=2    " Tabs are 2 characters
set shiftwidth=2 " (Auto)indent uses 2 characters
set expandtab    " spaces instead of tabs
set smarttab     " smart tab
set autoindent   " guess indentation
set smartindent  " smart autoindenting when starting a new line

" searching
set hlsearch   " highlight the search terms
set incsearch  " jump to the matches while typing
set ignorecase " ignore case for searches
set smartcase  " case sensitive when using capitals in search phrase

" commandline completion
set wildmenu                        " command-line completion
set wildmode=list:longest,list:full " set mode of completion
set wildchar=<Tab>                  " expand the command line using tab
set wildignore=*.o,*.e,*~           " ignore these extensions for completion

" completion menu
set completeopt=menuone,longest " always show the menu, insert longest match

" turn on omnicomplete
set omnifunc=syntaxcomplete#Complete

" enhancements over vi
set showcmd   " show (partial) command in status line
set showmatch " show matching brackets
set autowrite " automatically save before commands like :next and :make
set hidden    " hide buffers when they are abandoned
set mouse=a   " enable mouse usage (all modes)

" other options
set ttyfast " speed up scrolling in Vim
set autochdir " change directory for each file opened

" directly use system clipboard for yank/paste operations
"set clipboard=unnamedplus

" plugins ---------------------------------------------------------------------

" specify a directory for plugins
" avoid using standard Vim directory names like 'plugin'
"for the dotfiles repo, the plugins are present as git submodules
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'

Plug 'tpope/vim-obsession'
Plug 'scrooloose/nerdcommenter'
Plug 'ajh17/VimCompletesMe'

" TODO configure options here
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'rodjek/vim-puppet'

Plug 'w0rp/ale'               " asynchronous lint engine
Plug 'maximbaz/lightline-ale' " ALE indicator for lightline

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'

" TODO decide on this
Plug 'srstevenson/vim-picker'

Plug 'hashivim/vim-terraform'

" wf specific plugins
if !empty($WF_GIT_DOMAIN)
  " TODO adjust tremor-vim for better vim-plug support
  "Plug 'git@'.$WF_GIT_DOMAIN.':tremor/tremor-vim.git'

  Plug 'git@'.$WF_GIT_DOMAIN.':tremor/tremor-vim.git', { 'branch': 'fixes', 'do': 'ln -sf bundle/tremor.vim/* .' }
endif

" on-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" initialize plugin system
call plug#end()

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" active ale linters/fixers
let g:ale_linters = {
\   'puppet': ['puppetlint'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'puppet': ['puppetlint'],
\}

" ale settings
" TODO play with completion, go to definiton, hovering etc
" https://github.com/w0rp/ale#2-usage
let g:ale_linters_explicit = 1           " only run linters named in ale_linters settings.
let g:ale_lint_on_text_changed = 'never' " linting runs only on file save/open now
"let g:ale_fix_on_save = 1                " auto-fix files on save
"let g:ale_sign_column_always = 1         " always show the gutter

" ale indicators (aligned with indicators used in lightline-ale)
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'

" fugitive gitlab
let g:fugitive_gitlab_domains = ['https://git.csnzoo.com']

" vim picker
let g:picker_find_executable = 'fd'
let g:picker_find_flags = '--type file --follow --hidden --exclude .git'

" theme -----------------------------------------------------------------------

"if !has('gui_running')
"  set t_Co=256
"endif

" this needs to be set before intializing colorschemes
set background=light

if $TERM == "rxvt-unicode-256color" && !has('gui_running')
  " only on terminal vim
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

" update colors for ale indicators on the sidebar
" TODO change sidebar color
highlight link ALEWarningSign Keyword
highlight link ALEErrorSign String

" for generating tmux status bar config from vim (aligning tmux appearance with vim ligttline)
let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'powerline'
let g:tmuxline_preset = 'minimal'

" lightline configuration
let g:lightline = {}

" aligned with tmuxline theme
let g:lightline.colorscheme = 'powerline'

" for showing git branch info. depends on vim-fugitive
let g:lightline.component_function = {
    \   'fugitive': 'fugitive#head',
    \ }

" for showing linter errrors/warnings. depends on lightline-ale
let g:lightline.component_expand = {
    \  'linter_checking': 'lightline#ale#checking',
    \  'linter_warnings': 'lightline#ale#warnings',
    \  'linter_errors': 'lightline#ale#errors',
    \  'linter_ok': 'lightline#ale#ok',
    \ }
let g:lightline.component_type = {
    \  'linter_checking': 'left',
    \  'linter_warnings': 'warning',
    \  'linter_errors': 'error',
    \  'linter_ok': 'left',
    \ }
let g:lightline#ale#indicator_checking = ''
let g:lightline#ale#indicator_warnings = '▲'
let g:lightline#ale#indicator_errors = '✗'
let g:lightline#ale#indicator_ok = '✓'

" configure lightline components
let g:lightline.active = {
    \   'left':  [ ['mode', 'paste'],
    \              ['fugitive', 'readonly', 'filename', 'modified'] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ],
    \              ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
    \ }

" these settings work well with statuslines like lightline
set laststatus=2 " always display the statusline in all windows
set noshowmode   " hide the default mode text (e.g. -- INSERT -- below the statusline)

" instantly leave insert mode when pressing <Esc>
" useful to have with statuslines like lightline
set ttimeoutlen=10
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END

" command maps -----------------------------------------------------------------

command S Obsession

" key bindings -----------------------------------------------------------------

" With a map leader it's possible to do extra key combinations like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" fast switching between buffers with shift-tab. The current buffer will be
" saved before switching to the next one.
noremap <silent> <S-tab> :if &modifiable && !&readonly && &modified
    \ <CR> :write<CR> :endif<CR>:bprevious<CR>
inoremap <silent> <S-tab>  <C-C>:if &modifiable && !&readonly && &modified
    \ <CR> :write<CR> :endif<CR>:bprevious<CR>

" ctrl-A, ctrl-E for beginning and end of line, similar to emacs-style commandline defaults
" map! makes the mapping work in insert and commandline modes too
map  <C-A> <Home>
map  <C-E> <End>
map! <C-A> <Home>
map! <C-E> <End>

" after shifting a visual block, select it again
vnoremap < <gv
vnoremap > >gv

" add blank line on enter
nmap <Return> o<Esc>

" F8 - toggle comment (via nerd commenter)
map   <silent> <F8>         ,c<Space>
map   <silent> <S-F8>       ,cs
map   <silent> <C-F8>       ,cm
imap  <silent> <F8>    <Esc>,c<Space>
imap  <silent> <S-F8>  <Esc>,cs
imap  <silent> <C-F8>  <Esc>,cm

" toggle paste mode
set pastetoggle=<leader>P

" copy to system clipboard with cy (follow with a motion movement)
nnoremap cy "+y
vnoremap cy "+y

" paste from system clipboard with cp
nnoremap cp "+p<cr>
vnoremap cp "+p<cr>

" move between ale warnings and errors quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" fzy integration (when opening files from vim)
function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction
" TODO close picker window on escape
"nnoremap <leader>fe :call FzyCommand("fd --type file --follow --hidden --exclude .git . $(git rev-parse --show-toplevel 2>/dev/null)", ":e")<cr>
nnoremap <leader>fe :call FzyCommand("fd --type file --follow --hidden --exclude .git", ":e")<cr>
nnoremap <leader>fg :call FzyCommand("git ls-files $(git rev-parse --show-toplevel)", ":e")<cr>

" for vim-picker
nmap <unique> <leader>pe <Plug>PickerEdit
nmap <unique> <leader>ps <Plug>PickerSplit
nmap <unique> <leader>pv <Plug>PickerVsplit
nmap <unique> <leader>pt <Plug>PickerTabedit
nmap <unique> <leader>pb <Plug>PickerBuffer
nmap <unique> <leader>p] <Plug>PickerTag
nmap <unique> <leader>pw <Plug>PickerStag
nmap <unique> <leader>po <Plug>PickerBufferTag
nmap <unique> <leader>ph <Plug>PickerHelp

" TODO is this needed anymore?
"if exists(':tnoremap') == 2
"  tnoremap <buffer> <silent> <Esc> <C-\><C-n>:quit<CR>
"endif

" run previous command on the first window (and first pane) of the current tmux session
" works well only if history is in-sync across all panes
"nmap \r :!tmux send-keys -t "$(tmux display-message -p '\#S'):1.1" C-p C-j <CR><CR>

" for running git commands on current file
" TODO make it work as a :Git command. or as :Gblame...
fun! GitCommand(command)
	silent! !clear
	exec "!git " . a:command . " %"
endfun
map <leader>gb :call GitCommand("blame") <CR><CR>
map <leader>gd :call GitCommand("diff") <CR><CR>
map <leader>gl :call GitCommand("log -p") <CR><CR>

" autocmd ----------------------------------------------------------------------

" have vim jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" remove trailing whitespaces (for certain filetypes) automatically on file save
autocmd FileType
    \ awk,c,calendar,changelog,conf,config,cpp,css,desktop,dircolors,dockerfile,eruby,erlang,git,go,grub,haskell,html,java,javascript,jproperties,json,lua,make,man,markdown,perl,php,puppet,python,readline,ruby,scala,sh,sql,sshconfig,sudoers,systemd,terraform,tremor,tmux,vim,xdefaults,xml,yaml
    \ autocmd BufWritePre <buffer> :%s/\s\+$//e

" override iskeword set from vim-puppet/ftplugin/puppet.vim, to ingnore ':'
" (so that we can do things like word matches on module variable's word parts
autocmd FileType puppet setl iskeyword=-,@,48-57,_,192-255

" open help files in a vertical split
autocmd FileType help wincmd L
