colorscheme ron
syntax on
set statusline=%F%m%r%h%w\ %=\ FMT=%{&ff}\ TYPE=%Y\ ASCII=\%03.3b\ HEX=\%02.2B\ L:\%05l/%L\ C:\%03v\ %p%%\ LEN=%L
" set statusline=%F%m%r%h%w
" set statusline+=%=
" set statusline+=TYPE:%Y 
" set statusline+=FMT:%{&ff} 
" set statusline+=ASCII:\%03.3b 
" set statusline+=HEX:\%02.2B 
" set statusline+=L:%05l/%L 
" set statusline+=C:%03v 
" set statusline+=%p%%
"set statusline+=LEN=%L
set laststatus=2

" fix shift-insert for gvim
" inoremap <S-Insert> <C-R>*

" make all tabs spaces (Ctrl-v Tab for a real tab)
set tabstop=4 shiftwidth=4 expandtab

" cursor no blinky
set guicursor+=a:blinkon0

:autocmd Filetype ruby set softtabstop=2
:autocmd Filetype ruby set sw=2
:autocmd Filetype ruby set ts=2
:autocmd Filetype shell set softtabstop=2
:autocmd Filetype shell set sw=2
:autocmd Filetype shell set ts=2
:autocmd Filetype python set softtabstop=2
:autocmd Filetype python set sw=2
:autocmd Filetype python set ts=2

map <F12> :nohlsearch<CR>:echo "Highlights Cleared!"<CR>
:autocmd FileType mail :nmap <F8> :w<CR>:!aspell -e -c %<CR>:e<CR>
au BufRead sup.* set ft=mail

noremap <F5> :buffers<CR>:buffer<Space>

noremap <F10> :set number! relativenumber!<CR>
