
packadd minpac
call minpac#init({'verbose': 0})

" minpac must have {'type': 'opt'} so that it can be loaded with
" `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('jiangmiao/auto-pairs')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tomasr/molokai')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('python-mode/python-mode')
call minpac#add('adlawson/vim-sorcerer')
