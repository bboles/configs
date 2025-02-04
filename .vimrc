colorscheme torte
hi Pmenu guibg=NavyBlue
syntax on
set statusline=%F%m%r%h%w\ %=\ %{FugitiveStatusline()}\ FMT=%{&ff}\ TYPE=%Y\ ASCII=\%03.3b\ HEX=\%02.2B\ L:\%05l/%L\ C:\%03v\ %p%%\ LEN=%L
set statusline+=%#warningmsg#
set statusline+=%*
set laststatus=2

let mapleader = ","
" 3s timeout for leader
set timeoutlen=3000

" make all tabs spaces (Ctrl-v Tab for a real tab)
set tabstop=2 shiftwidth=2 expandtab

" cursor no blinky
set guicursor+=a:blinkon0

" preferred font
set guifont=EdloNerdFont-:h12

" show tab numbers
set guitablabel=%N:%M%t 

" don't show the toolbar in the GUI (only the menu)
set guioptions-=T

" don't show tear-off menus
set guioptions-=t

" keep tab bar removal and other gui things from resizing the window
set guioptions+=k

" show dates/times in listing
let g:netrw_liststyle = 1

" make a cleaner vertical split divider
set fillchars+=vert:\ 

" number of commands to keep
set history=10000

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
:autocmd Filetype yaml set softtabstop=2
:autocmd Filetype yaml set sw=2
:autocmd Filetype yaml set ts=2

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
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'mustache/vim-mustache-handlebars'
Plug 'sheerun/vim-polyglot'
Plug 'jez/vim-superman'
Plug 'jpalardy/vim-slime'
Plug 'sodapopcan/vim-twiggy'
" devicons should always be loaded last
Plug 'ryanoasis/vim-devicons'
call plug#end()

" indentLine things
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" fzf things
let $FZF_DEFAULT_COMMAND='find .'
nmap <Leader>F :Files<CR>
nmap <Leader>f :Rg<CR>
nmap <Leader>G :GFiles<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>H :Helptags!<CR>
nmap <Leader>hh :History<CR>
nmap <Leader>h: :History:<CR>
nmap <Leader>h/ :History/<CR>

" Use a preview window for rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


" slime things
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_python_ipython = 1
let g:slime_bracketed_paste = 1
" let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

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

" automatically highlight column 80 if textwidth is 0 otherwise use the
" setting for textwidth
function! s:SetColorColumn()
  if &textwidth == 0
    setlocal colorcolumn=80
  else
    setlocal colorcolumn=+0
  endif
endfunction

augroup colorcolumn
  autocmd!
  autocmd OptionSet textwidth call s:SetColorColumn()
  autocmd BufEnter * call s:SetColorColumn()
augroup end

hi ColorColumn ctermbg=darkblue guibg=darkblue


nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
