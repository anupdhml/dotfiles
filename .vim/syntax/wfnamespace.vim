"chtml.vim: html with conceal
set conceallevel=2

"syn region inBold concealends matchgroup=bTag start="<b>" end="</b>"
"syn match newLine "<br>" conceal cchar=}

syn region inBold concealends matchgroup=bTag start="@param \\WF\\" end=" $"
syn match newLine "<br>" conceal cchar=}

"hi inBold gui=bold
"hi bTag guifg=blue
"hi newLine guifg=green
