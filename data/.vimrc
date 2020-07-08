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
set completeopt=menuone,longest,popup " always show the menu, insert longest match, use popup window for extra info
"set completepopup=border:off          " remove the border from the completion popup window

" turn on omnicomplete. we set this based on ale plugin later
"set omnifunc=syntaxcomplete#Complete " vim default

" enhancements over vi
set showcmd   " show (partial) command in status line
set showmatch " show matching brackets
set autowrite " automatically save before commands like :next and :make
set hidden    " hide buffers when they are abandoned
set mouse=a   " enable mouse usage (all modes)

" config for directory explorer (simulating nerdtree)
let g:netrw_banner = 0    "do not display info on the top of window
let g:netrw_liststyle = 3 " tree view
let g:netrw_winsize = 25  " width of netrw window

" other options
set ttyfast " speed up scrolling in Vim
set autochdir " change directory for each file opened
set splitbelow " show preview window at the bottom

" directly use system clipboard for yank/paste operations
"set clipboard=unnamedplus

" plugins ---------------------------------------------------------------------

" specify a directory for plugins, for installaion via vim-plug
" avoid using standard Vim directory names like 'plugin'
" for the dotfiles repo, the plugins are present as git submodules
call plug#begin('~/.vim/plugged')

" appearance
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'maximbaz/lightline-ale'

" essentials
"Plug 'dense-analysis/ale' " enable after the fork branch is merged upstream
Plug 'anupdhml/ale', { 'branch': 'tremor_integration' }
Plug 'scrooloose/nerdcommenter'
Plug 'ajh17/VimCompletesMe'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'liuchengxu/vista.vim'
Plug 'ludovicchabant/vim-gutentags'

" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" utilities
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'szw/vim-maximizer'
Plug 'Valloric/ListToggle'

" language support
Plug 'rodjek/vim-puppet'
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " TODO configure options here
Plug 'rust-lang/rust.vim'
Plug 'wayfair-tremor/tremor-vim'
Plug 'junegunn/vader.vim'

" wf specific plugins
"if !empty($WF_GIT_DOMAIN)
"  "Plug 'git@'.$WF_GIT_DOMAIN.':tremor/tremor-vim.git', { 'branch': 'fixes', 'do': 'ln -sf bundle/tremor.vim/* .' }
"endif

" initialize plugin system
call plug#end()

" lightline -------------------------------------------------------------------

" for generating tmux status bar config from vim (aligning tmux appearance with vim lightline)
let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'powerline'
let g:tmuxline_preset = 'minimal'

" lightline configuration
let g:lightline = {}

" aligned with tmuxline theme
let g:lightline.colorscheme = 'powerline'

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" for showing following extra info on the statusline:
"   * git branch: depends on vim-fugitive
"   * nearest method: gdepends on vista.vim
let g:lightline.component_function = {
    \   'fugitive': 'fugitive#head',
    \   'method': 'NearestMethodOrFunction',
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
    \              ['fugitive', 'readonly', 'filename', 'modified', 'method'] ],
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

" ale -------------------------------------------------------------------------

" TODO play with completion, go to definiton, hovering etc
" https://github.com/w0rp/ale#2-usage

" turn on omnicomplete based on ale
set omnifunc=ale#completion#OmniFunc

" enable ale completion (as you type), where available
"let g:ale_completion_enabled = 1

" completion menu options in case ale completion gives issues
" TODO remove
"set completeopt=menu,menuone,preview,noselect,noinsert

" show hover information on mouse over (vim mouse support should be turned on)
" xterm2 makes hover work with tmux as well
let g:ale_set_balloons = 1
set ttymouse=xterm2

" only run linters named in ale_linters settings
let g:ale_linters_explicit = 1

" when to run linting/fixing
"let g:ale_fix_on_save = 1
"let g:ale_lint_on_text_changed = 'always'
"let g:ale_lint_on_enter = 1
"let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0

" ale indicators (aligned with indicators used in lightline-ale)
" 2 chars to cover the full sign width
let g:ale_sign_warning = '▲▲'
let g:ale_sign_error = '✗✗'

" appearance settings
"let g:ale_sign_column_always = 1      " always show the gutter
"let g:ale_open_list = 1               " show window for error list
"let g:ale_list_window_size = 10       " height of the window for error list
"let g:ale_close_preview_on_insert = 1 " close preview window automatically

" active linters
let g:ale_linters = {
\   'puppet': ['puppetlint'],
\   'rust': ['analyzer'],
\   'tremor': ['tremor-language-server'],
\   'trickle': ['tremor-language-server'],
\}

" active fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'puppet': ['puppetlint'],
\   'rust': ['rustfmt'],
\   'go': ['gofmt'],
\}

" ale rust settings, applicable when using rls as the ale linter
" for avaialble params to rust language server, see: https://github.com/rust-lang/rls#configuration
"let g:ale_rust_rls_config = {
"\   'rust': {
"\     'clippy_preference': 'on',
"\   }
"\}

" ale rust settings, applicable when using cargo as the ale linter
"let g:ale_rust_cargo_check_tests = 1                         " lint rust tests too
"let g:ale_rust_cargo_check_examples = 1                      " list rust examples too
"let g:ale_rust_cargo_use_clippy = executable('cargo-clippy') " use cargo clippy for lints if present
"let g:ale_rust_cargo_clippy_options = ''                     " options for cargo clippy

" other plugin settings -------------------------------------------------------

" for rust files, run rustfmt on buffer save
" since ale can't fix on :wq, we choose rust.vim's functionality here:
" https://github.com/w0rp/ale/issues/2014#issuecomment-493559554
let g:rustfmt_autosave = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" list toggle
let g:lt_height = 10

" enable fenced code block syntax highlighting in markdown files for these languages
let g:markdown_fenced_languages = ['tremor', 'trickle']

" override default vista executive (ctags) for these filetypes
"let g:vista_executive_for = {
"  \ 'rust': 'ale',
"  \ }

" for vim-clap (with rg). via `:h clap-grep-options`
let g:clap_provider_grep_opts = '--with-filename --no-heading --vimgrep --smart-case --hidden'
" does not work as expected so disabled
"let g:clap_provider_grep_opts = '--with-filename --no-heading --vimgrep --smart-case --hidden --glob "!.git/"'

" enable rainbow parentheses
" more options at: https://github.com/luochen1990/rainbow#configure
let g:rainbow_active = 1
" choosing colors appropritate for light colorscheme
let g:rainbow_conf = {
\	'ctermfgs': ['darkblue', 'darkyellow', 'darkcyan', 'darkmagenta'],
\}

" theme -----------------------------------------------------------------------

"if !has('gui_running')
"  set t_Co=256
"endif

" this needs to be set before intializing colorschemes
set background=light

if $TERM == "rxvt-unicode-256color" && !has('gui_running')
  " only on terminal vim
  colorscheme default_improved

  " for vim-clap
  "
  " TODO show icons for urxvt
  "let g:clap_enable_icon = 1
  "let g:clap_provider_grep_enable_icon = 1
  "
  " TODO support spinner symbol rendering in urxvt. can then use it in the prompt
  "let g:clap_prompt_format = '%spinner%%forerunner_status%%provider_id%:' "default
  let g:clap_prompt_format = '%forerunner_status%%provider_id%:'
  "
  " colors for fuzzy matches on places like `:Clap files`
  let g:clap_fuzzy_match_hl_groups = [
      \ [24, 'darkblue'],
      \ [4, 'blue'],
      \]
  " cursor char on clap prompt
  let g:clap_popup_cursor_shape = '|'

  " for vista.vim
  " TODO show icons for urxvt
  let g:vista#renderer#enable_icon = 0
else
  "set termguicolors
  "set background=light
  "colorscheme solarized8
  colorscheme flattened_light

  " italicize comments, except on terminals that don't support it
  if $TERM == "linux"
    highlight Comment cterm=none ctermfg=darkgrey
  else
    highlight Comment cterm=italic
  endif

  " for vim-clap
  " icons work well in gvim and xfce4-terminal (as long as nerd fonts are
  " installed), so enable it too
  let g:clap_enable_icon = 1
  let g:clap_provider_grep_enable_icon = 1
  let g:clap_theme = 'solarized_light'
endif

" command maps -----------------------------------------------------------------

command S Obsession

" key bindings -----------------------------------------------------------------

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

" copy to system clipboard with cy (follow with a motion movement)
nnoremap cy "+y
vnoremap cy "+y

" paste from system clipboard with cp
nnoremap cp "+p<cr>
vnoremap cp "+p<cr>

" run previous command on the first window (and first pane) of the current tmux session
" works well only if history is in-sync across all panes
"nmap \r :!tmux send-keys -t "$(tmux display-message -p '\#S'):1.1" C-p C-j <CR><CR>

" auto-closing pairs in insert mode
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
" these are disabled because they can be annoying with auto-indents
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O

" key bindings (function keys) ------------------------------------------------

" F1 - open file picker
"map  <silent> <F1> ,fe
map  <silent> <F1> :Clap files --hidden<CR>
map  <silent> ,<F1> :Clap filer<CR>

" F2 - open grep picker
map  <silent> <F2> :Clap grep<CR>

" F3 - open buffer picker
map  <silent> <F3> :Clap buffers<CR>

" F4 - toggle file explorer
map  <silent> <F4> :Lexplore<CR>

" F5 - toggle vista view window
map  <silent> <F5> :Vista!!<CR>
map  <silent> ,<F5> :Clap proj_tags<CR>
"map  <silent> ,<F5> :Clap tags<CR>

" F6 - toggle linenumbers
map <silent> <F6> :set nonumber!<CR>

" F7 - toggle cursor line/column
map <silent> <F7> :set cursorline!<CR>
map <silent> <S-F7> :set cursorcolumn!<CR>

" F8 - toggle comment (depends on nerdcommenter)
map  <silent> <F8>         ,c<Space>
map  <silent> <S-F8>       ,cs
map  <silent> <C-F8>       ,cm
imap <silent> <F8>    <Esc>,c<Space>
imap <silent> <S-F8>  <Esc>,cs
imap <silent> <C-F8>  <Esc>,cm

" F9 - TODO

" F10 - toggle the statusline
map <silent> <F10> :if &laststatus == 1<bar>
                      \set laststatus=2<bar>
                      \set noshowmode<bar>
                      \echo<bar>
                    \else<bar>
                      \set laststatus=1<bar>
                      \set showmode<bar>
                    \endif<CR>

" F11 - maximize window (depends on vim-maximizer)
let g:maximizer_default_mapping_key = '<F11>'

" F12 - toggle location list/quicklist (depends on listtoggle)
let g:lt_location_list_toggle_map = '<F12>'
let g:lt_quickfix_list_toggle_map = '<S-F12>'

" key bindings (leader based) -------------------------------------------------

" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

" toggle paste mode
set pastetoggle=<leader>P

" for ale
nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>/ <Plug>(ale_hover)
nmap <silent> <leader>? <Plug>(ale_detail)
nmap <silent> <leader>] <Plug>(ale_go_to_definition)
nmap <silent> <leader># <Plug>(ale_find_references)

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
nnoremap <leader>fe :call FzyCommand("fdfind --type file --follow --hidden --exclude .git . $(git rev-parse --show-toplevel 2>/dev/null)", ":e")<cr>
"nnoremap <leader>fe :call FzyCommand("fdfind --type file --follow --hidden --exclude .git", ":e")<cr>
nnoremap <leader>fg :call FzyCommand("git ls-files $(git rev-parse --show-toplevel)", ":e")<cr>

" for running git commands on current file
" TODO make it work as a :Git command. or as :Gblame...
fun! GitCommand(command)
	silent! !clear
	exec "!git " . a:command . " %"
endfun
map <leader>gb :call GitCommand("blame") <CR><CR>
map <leader>gd :call GitCommand("diff") <CR><CR>
map <leader>gl :call GitCommand("log -p") <CR><CR>

" for quickly retrieving the syntax highlight group active under the cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction
map <leader>sg :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" autocmd ----------------------------------------------------------------------

" needed to show the nearest function in statusline automatically (via vista.vim)
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" have vim jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" override <CR> mapping defined earlier in the file, for quickfix/loclist
" window (since <CR> is used to jump to the error under the cursor there)
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" remove trailing whitespaces (for certain filetypes) automatically on file save
autocmd FileType
    \ awk,c,calendar,changelog,coffee,conf,config,cpp,css,desktop,dircolors,dockerfile,eruby,erlang,git,go,grub,haskell,html,java,javascript,jproperties,json,lua,make,man,markdown,perl,php,puppet,python,readline,ruby,scala,sh,sql,sshconfig,sudoers,systemd,terraform,tremor-script,tremor-query,tmux,vader,vim,xdefaults,xml,yaml
    \ autocmd BufWritePre <buffer> :%s/\s\+$//e

" open help files in a vertical split
autocmd FileType help wincmd L

" override iskeword set from vim-puppet/ftplugin/puppet.vim, to ingnore ':'
" (so that we can do things like word matches on module variable's word parts
autocmd FileType puppet setl iskeyword=-,@,48-57,_,192-255
