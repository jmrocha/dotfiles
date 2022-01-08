call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree'
  Plug 'sheerun/vim-polyglot'
  Plug 'vim-python/python-syntax'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'pangloss/vim-javascript'
  Plug 'craigemery/vim-autotag'
  Plug 'chrisbra/Colorizer'
call plug#end()
