setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal smarttab
setlocal softtabstop=4

setlocal textwidth=80
set nosmartindent

" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

"let g:pydoc_open_cmd = 'vsplit' 
let g:pydoc_open_cmd = 'rightbelow vnew' 

 let g:pydiction_location = '~/.vim/pydiction/complete-dict'
"let g:SuperTabDefaultCompletionType = "<c-x><c-k>"
"set dictionary=~/.vim/pydiction/complete-dict

"let g:syntastic_python_checker = 'pyflakes'
"let g:syntastic_python_checker = 'flake8'
let g:syntastic_python_checker = 'pylint'


" Adapted from sonteks post on Vim as Python IDE
" http://blog.sontek.net/2008/05/11/python-with-a-modular-ide-vim/

python << EOF
import vim

def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)sfrom ipdb import set_trace;set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

vim.command( 'map <f11> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine.lstrip()[:38] == 'from ipdb import set_trace;set_trace()':
            nLines.append( nLine)
            print nLine
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( 'normal %dG' % nLine)
        vim.command( 'normal dd')
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( 'normal %dG' % nCurrentLine)

vim.command( 'map <s-f11> :py RemoveBreakpoints()<cr>')
EOF

