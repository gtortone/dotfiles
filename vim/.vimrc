
so ~/.vim/plugins.vim

set termguicolors
let ayucolor="dark"
colorscheme ayu

" vim-airline/vim-airline plugin
let g:airline_powerline_fonts = 1
let g:airline_theme='term'

" preservim/nerdtree plugin
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

" tabs navigation
map <C-k> :tabn<CR>
map <C-j> :tabp<CR>
map <C-n> :tabnew<CR>

" disable default bar and info
set noshowmode       " to get rid of thing like --INSERT--
set noshowcmd        " to get rid of display of last command
set shortmess+=F     " to get rid of the file name displayed in the command line bar

" change cursor between modes
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

" toggle hybrid line numbers
set number relativenumber

" disable arrow keys
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

set tabstop=3
set shiftwidth=3
set expandtab
set wildmenu
set hidden

" in insert mode, move normally by using Ctrl
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

