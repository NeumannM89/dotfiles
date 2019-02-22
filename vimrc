 "vim: nowrap fdm=marker
scriptencoding utf-8

syntax on
" filetype plugin indent on
filetype on
filetype plugin on
filetype indent on

if !has('nvim')
  unlet! skip_defaults_vim
  source $VIMRUNTIME/defaults.vim
endif

" Enable 256 colors
set t_Co=256
source ~/dotfiles/packages.vim

" let g:molokai_original = 1
colorscheme molokai

set showcmd       " display incomplete command

set nocompatible
set history=50
set nobackup
set nowritebackup
set noswapfile
set nojoinspaces
set complete-=t
set foldlevelstart=20

" Mark buffers ashidden without asking
set hidden
let python_highlight_all=1
"Allow usage of mouse in iTerm
set ttyfast
set mouse=a

" make command line one line high
set ch=1

" Make searching better
set gdefault      " Never have to type /g at the end of search / replace again
set ignorecase    " case insensitive searching (unless specified)
set smartcase
" set hlsearch
set nohlsearch
set incsearch
set showmatch

set visualbell    " stop that ANNOYING beeping
set wildmenu
set wildignore=*.o,*~,*.pyc,*.aux,*.gz,*.zip,*.pdf
set wildignorecase

set tabstop=4
set shiftwidth=4
set softtabstop=4

set number
set numberwidth=5

" current pos
set ruler

set autoread      " Reload files changed outside vim

" make tab as tab
set expandtab

set scrolloff=8         "Start scrolling when we're 8 lines away from margins

set pastetoggle=<F3>

set diffopt=filler,vertical

" indentation
set smartindent
set autoindent

" Leader - ( Spacebar )
let mapleader = ","
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
set statusline=%t

let g:ycm_global_ycm_extra_conf = '$HOME/.vim/pack/minpac/start/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_semantic_triggers = {
\   'roslaunch' : ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
\ }

nnoremap <silent> <leader>/ :noh<cr> " Stop highlight after searching

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Allow moving around between Tmux windows
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
let g:tmux_navigator_no_mappings = 1

"Map Ctrl + S to save in any mode
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <Esc>:update<CR>
" Also map leader + s
map <leader>s <C-S>
" Switch between the last two files
nnoremap <leader><leader> <c-^>

"Use enter to create new lines w/o entering insert mode
nnoremap <CR> o<Esc>

" Run the q macro
nnoremap <leader>q @q

" Quickly close windows
nnoremap <leader>x :x<cr>
nnoremap <leader>X :q!<cr>

inoremap <silent><leader>; <Esc>A;<Esc>
nnoremap <silent><leader>; A;<Esc>

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

"Below is to fix issues with the ABOVE mappings in quickfix window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

autocmd BufWritePre * %s/\s\+$//e

"Toggle relative numbering, and set to absolute on loss of focus or insert mode
set rnu
function! ToggleNumbersOn()
	set nu!
	set rnu
	endfunction
function! ToggleRelativeOn()
	set rnu!
	set nu
	endfunction
	autocmd FocusLost * call ToggleRelativeOn()
	autocmd FocusGained * call ToggleRelativeOn()
	autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()

" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !
" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" au BufNewFile,BufRead *.py
" 			\let g:pymode = 1

" autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
"     \set tabstop=4
"     \set softtabstop=4
"     \set shiftwidth=4
"     \set textwidth=79
"     \set expandtab
"     \set autoindent
"     \set fileformat=unix
"
" au BufNewFile,BufRead *.js, *.html, *.css
"     \set tabstop=2
"     \set softtabstop=2
"     \set shiftwidth=2
