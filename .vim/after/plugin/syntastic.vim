"sign define SyntasticError text=⮀ texthl=error
"sign define SyntasticWarning text=⮁ texthl=Pl58870000d0ff8700b
"sign define SyntasticStyleError text=⮀ texthl=error
"sign define SyntasticStyleWarning text=⮁ texthl=tPl58870000d0ff8700b

" custom highlight groups
"highlight MySyntasticError term=bold cterm=NONE ctermfg=9 ctermbg=7 guifg=red guibg=#D3D7CF
"highlight MySyntasticWarning term=bold cterm=NONE ctermfg=11 ctermbg=7 guifg=yellow guibg=#D3D7CF
"
highlight MySyntasticError ctermfg=0 ctermbg=9 guifg=black guibg=red
highlight MySyntasticWarning ctermfg=214 ctermbg=7 guifg=yellow guibg=#D3D7CF
"highlight MySyntasticWarning ctermfg=11 ctermbg=7 guifg=yellow guibg=#D3D7CF

sign define SyntasticError text=⮀ texthl=MySyntasticError
sign define SyntasticWarning text=⮀ texthl=MySyntasticWarning
sign define SyntasticStyleError text=⮁ texthl=MySyntasticError
sign define SyntasticStyleWarning text=⮁ texthl=MySyntasticWarning

