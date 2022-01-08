set number 
set relativenumber 
set expandtab 
set autoindent
set wrap!
set ruler
set ic
set hls is
set shiftwidth=2
set softtabstop=2 
"set colorcolumn=80
set rtp+=/usr/local/opt/fzf
set dir=~/.vim/tmp

"hi Search guibg=blue guifg=red
"highlight Search ctermbg=blue ctermfg=black
"highlight ColorColumn ctermbg=0 ctermfg=lightgrey
highlight Comment cterm=italic

imap jj <ESC>
imap zz <ESC>:update<cr>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap zz :update<CR>
nnoremap <space> za


" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'vim-python/python-syntax'
Plug 'christoomey/vim-tmux-navigator'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Colorscheme
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'craigemery/vim-autotag'
Plug 'chrisbra/Colorizer'

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'dense-analysis/ale'

"Plug 'fisadev/vim-isort'
"Plug 'tmhedberg/SimpylFold'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" colorscheme configuration
"highlight clear
"if exists('syntax_on')
"  syntax reset
"endif
"let g:colors_name = 'material'
"let g:material_theme_style = get(g:, 'material_theme_style', 'default')
let g:material_terminal_italics = get(g:, 'material_terminal_italics', 1)
let g:material_theme_style = 'ocean'

colorscheme material

let g:vim_jsx_pretty_colorful_config = 1
let NERDTreeShowLineNumbers=1

let g:airline#extensions#ale#enabled = 1
let g:ale_completion_autoimport = 1
