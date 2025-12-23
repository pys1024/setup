syntax on
" line number
set nu
" autoindent
set ai
" smartindent
"set si
" expandtab: tab => space
set et
" smarttab
set sta
" shiftwidth
set sw=4
" softtabstop
set sts=4
" tabstop
set ts=4
" hlsearch: highlight search
set hls
" ignorecase
set ic
" smartcase
set scs
" clipboard: sync with system clipboard
set cb=unnamedplus

filetype plugin indent on

function! Setup_ExecNDisplay()
    execute "w"
    execute "silent !chmod +x %:p"
    let n=expand('%:t')
    execute "silent !%:p 2>&1 | tee ~/.vim/output_".n
    " I prefer vsplit
    execute "split ~/.vim/output_".n
    "execute "vsplit ~/.vim/output_".n
    execute "redraw!"
    set autoread
endfunction

:nmap <F5> :call Setup_ExecNDisplay()<CR>
