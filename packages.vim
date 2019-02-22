
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
call minpac#add('tomtom/tcomment_vim')
" call minpac#add('python-mode/python-mode')
call minpac#add('lervag/vimtex')
call minpac#add('taketwo/vim-ros')
call minpac#add('vim-syntastic/syntastic')
" call minpac#add('davidhalter/jedi-vim')
call minpac#add('Valloric/YouCompleteMe')
call minpac#add('romainl/Apprentice')
call minpac#add('NeumannM89/Molokai')
call minpac#add('chase/focuspoint-vim')
call minpac#add('nightsense/carbonized')
