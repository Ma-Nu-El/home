" If everything works fine, then this .vimrc should never been
" more than a hand rolled config. If you'd like a framework, then
" you have Doom Emacs.
"  :set number relativenumber
"  :augroup numbertoggle
"  :  autocmd!
"  :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"  :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"  :augroup END

:set hlsearch
:set incsearch
:set scrolloff=5
:set splitright
:set listchars=tab:→\ ,eol:↲

" disable back ups
:set nobackup

"https://vi.stackexchange.com/questions/574/keeping-lines-to-less-than-80-characters
:set colorcolumn=80
