colorscheme torte
syntax on
set statusline=%F%m%r%h%w\ %=\ %{FugitiveStatusline()}\ FMT=%{&ff}\ TYPE=%Y\ ASCII=\%03.3b\ HEX=\%02.2B\ L:\%05l/%L\ C:\%03v\ %p%%\ LEN=%L
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
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set laststatus=2

let mapleader = ","
" 3s timeout for leader
set timeoutlen=3000

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:syntastic_docker_checkers = ['hadolint']
" let g:syntastic_markdown_checkers = ['proselint']
" let g:syntastic_puppet_checkers = ['puppet-lint']
" let g:syntastic_python_checkers = ['pylint']
" let g:syntastic_sh_checkers = ['shellcheck']
" " turn off vint because it crashes
" " let g:syntastic_vim_checkers = ['vint']
" let g:syntastic_yaml_checkers = ['yamllint']
" 
" " let b:togglestc=1
" let b:togglestc=1
" function ToggleSTC()
"   if togglestc
"       :SyntasticCheck
"       let b:togglestc=0
"   else
"       :SyntasticReset
"       let b:togglestc=1
"   endif
" endfunction
" 
" nnoremap <F4> :call ToggleSTC()<CR>

" fix shift-insert for gvim
" inoremap <S-Insert> <C-R>*

" make all tabs spaces (Ctrl-v Tab for a real tab)
set tabstop=4 shiftwidth=4 expandtab

" cursor no blinky
set guicursor+=a:blinkon0

" preferred font
set guifont=Edlo:h13

" show tab numbers
set guitablabel=%N:%M%t 

" don't show the toolbar in the GUI (only the menu)
set guioptions-=T

" don't show tear-off menus
set guioptions-=t

" show dates/times in listing
let g:netrw_liststyle = 1

" make a cleaner vertical split divider
set fillchars+=vert:\ 

" make macvim work right in visual mode
:highlight Visual cterm=reverse ctermbg=NONE

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
set number!
set relativenumber!

noremap <F3> :IndentLinesToggle<CR>

" no default mapping to create a new blank vsplit
nmap <C-w>V :vnew<CR>

" turn off auto comment for everything
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" toggle paste.  affects auto-indent.
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" make the vim clipboard use the system clipboard
set clipboard=unnamed

" "Zoom" a split window into a tab and/or close it
nmap <Leader>zo :tabnew %<CR>
nmap <Leader>zc :tabclose<CR>

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tmhedberg/SimpylFold'
Plug 'mileszs/ack.vim'
Plug 'Yggdroot/indentLine'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'mustache/vim-mustache-handlebars'
Plug 'sheerun/vim-polyglot'
Plug 'jez/vim-superman'
Plug 'jpalardy/vim-slime'
" Plug 'vim-syntastic/syntastic'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" devicons should always be loaded last
Plug 'ryanoasis/vim-devicons'
call plug#end()

" fzf things
let $FZF_DEFAULT_COMMAND='find .'
nmap <Leader>F :Files<CR>
nmap <Leader>f :GFiles<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>H :Helptags!<CR>

" slime things
let g:slime_target = "vimterminal"
let g:slime_vimterminal_cmd = "ipython"
let g:slime_vimterminal_config = {"term_finish": "close"}
let g:slime_python_ipython = 1

" coc things
nmap <Leader>e :CocCommand explorer<CR>
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" use <tab> and <shift><tab> to naviate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
