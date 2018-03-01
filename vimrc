set nocompatible
" Leader - ( Spacebar )
let mapleader = " "
" set t_Co = 256
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
"set showcmd       " display incomplete command
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set autoread      " Reload files changed outside vim
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !
"Set default font in mac vim and gvim
"set guifont=Inconsolata\ for\ Powerline:h24
set cursorline    " highlight the current line
set visualbell    " stop that ANNOYING beeping
set wildmenu
set wildmode=list:longest,full
set wildignorecase


"Allow usage of mouse in iTerm
set ttyfast
set mouse=a
" set ttymouse=xterm2

" Make searching better
set gdefault      " Never have to type /g at the end of search / replace again
set ignorecase    " case insensitive searching (unless specified)
set smartcase
set hlsearch
nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching
set incsearch
set showmatch

" Softtabs, 2 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
" set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Make it obvious where 100 characters is
"set textwidth=100
" set formatoptions=cq
set formatoptions=qrn1
set wrapmargin=0
set colorcolumn=+1

" Numbers
set number
set numberwidth=5
" Open new split panes to right and bottom, which feels more natural
" set splitbelow
set splitright

" Auto resize Vim splits to active split
set winwidth=104
set winheight=5
set winminheight=5
set winheight=999

"HTML Editing
set matchpairs+=<:>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
set cindent "enable c indentation
set cinoptions=g-1
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

set path+=**

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

"Use enter to create new lines w/o entering insert mode
nnoremap <CR> o<Esc>
"Below is to fix issues with the ABOVE mappings in quickfix window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

autocmd BufWritePre * %s/\s\+$//e

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" <c-h> is interpreted as <bs> in neovim
" This is a bandaid fix until the team decides how
" they want to handle fixing it...(https://github.com/neovim/neovim/issues/2048)
nnoremap <silent> <bs> :TmuxNavigateLeft<cr>

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
vnoremap <tab> %
" Always use vertical diffs
set diffopt+=vertical

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

""" MORE AWESOME HOTKEYS
"
"
" Run the q macro
nnoremap <leader>q @q

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
" Ag will search from project root
let g:ag_working_path_mode="r"

"Map Ctrl + S to save in any mode
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
" Also map leader + s
map <leader>s <C-S>

" Quickly close windows
nnoremap <leader>x :x<cr>
nnoremap <leader>X :q!<cr>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

"inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" AUTOCOMMANDS - Do stuff

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

"update dir to current file
autocmd BufEnter * silent! cd %:p:h

augroup vimrcEx
  autocmd!


  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " autocmd BufRead *.jsx set ft=jsx.html
  " autocmd BufNewFile *.jsx set ft=jsx.html


  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 100 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=100

  " Automatically wrap at 100 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=100
  autocmd FileType gitcommit setlocal spell
  autocmd FileType latex setlocal spell
  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass,less setlocal iskeyword+=-
augroup END


" TODO: Don't think I need this anymore? Pretty sure supertab handles it
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<tab>"
"     else
"         return "\<c-p>"
"     endif
" endfunction
" Color scheme
syntax enable
" let g:solarized_termcolors=16
"let g:colarized_termtrans = 1
"let g:solarized_termcolors=256
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"

colorscheme molokai
"colorscheme VisualStudioDark
"set background=dark
" Allow powerline symbols to show up
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
set statusline=%t

map <silent> <C-n> :NERDTreeToggle<cr>
nnoremap <C-t> :call ToggleRelativeOn()<cr>
" Close vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" [3]
" Allow moving around between Tmux windows
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
"
"Open a tmux pane with Node
nnoremap <leader>node :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'node'}<cr>

" [4]
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag i               trlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  "let g:ctrlp_working_path_mode = 'r'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0

  "let g:ctrlp_extensions = ['line']
endif

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['javascript'], 'passive_filetypes': [] }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : ['standard']
" these 2 lines check to see if eslint is installed via local npm and runs that before going global
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" " Allow highlighting of HTML within Javascript (for React)
let g:javascript_enable_domhtmlcss = 1
let g:jsx_ext_required = 0

" [6] Key mapping for Cosco.vim - space + ; to add semicolon or comma in Javascript or CSS
" autocmd FileType javascript,css nnoremap <silent> <Leader>; :call cosco#commaOrSemiColon()<CR>
" autocmd FileType javascript,css inoremap <silent> <Leader>; <c-o>:call cosco#commaOrSemiColon()<CR>

inoremap <silent><leader>; <Esc>A;<Esc>
nnoremap <silent><leader>; A;<Esc>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"


let g:SuperTabDefaultCompletionType = '<C-n>'

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

":w | %bd | e#
