" ----------------------------------------------------------
"  General Settings
" ----------------------------------------------------------

set number
set encoding=UTF-8
set hidden
set clipboard=unnamedplus
set mouse=a
set scrolloff=8
set sidescrolloff=8


" ----------------------------------------------------------
" Key maps 
" ----------------------------------------------------------

let mapleader = "\<space>"

command! W :w
command! Q :q
command! WQ :wq
command! Wq :wq


" ----------------------------------------------------------
" Plugins
" ----------------------------------------------------------

call plug#begin()
	Plug 'jiangmiao/auto-pairs'
	Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
	Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'preservim/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'alvan/vim-closetag'
	Plug 'PhilRunninger/nerdtree-visual-selection'
	Plug 'voldikss/vim-floaterm'
	Plug 'tpope/vim-commentary'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	"Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" ----------------------------------------------------------
"  Plugins settings
" ----------------------------------------------------------

let g:airline_theme='deus'
let g:airline_powerline_fonts=1

colorscheme tokyonight

nnoremap <C-s> :Telescope find_files<cr>

nnoremap <C-c> :Commentary<CR>
vnoremap <C-c> :Commentary<CR>

nnoremap <leader>t :FloatermToggle<CR>
nnoremap <leader>T :FloatermKill<CR>
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
let g:floaterm_autoclose = 2
let g:floaterm_keymap_kill = '<leader>T'
let g:floaterm_keymap_hide = '<leader>f'
let g:floaterm_keymap_show = '<leader>F'

nnoremap <leader>N :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <S-Right> :tabn<CR>
nnoremap <S-Left> :tabp<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
"ctrl + ww to move
"autocmd VimEnter * NERDTree

