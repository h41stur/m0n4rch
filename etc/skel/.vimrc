set number
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set cursorline
set incsearch
set ignorecase
set smartcase
set hlsearch

"Plugin Vundle, automatiza a instalacao de outros plugins
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dracula/vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'cj/vim-webdevicons'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'ycm-core/YouCompleteMe'

call vundle#end()
filetype plugin indent on



"set relativenumber

"Salvar com Ctr+s
noremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>l
vnoremap <C-s> <Esc>:w<CR>

syntax on
filetype on
filetype plugin on
filetype indent on
color dracula


"Paste ident
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

" Abre NERDTree automaticamente
autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd vimenter * wincmd p
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
" let NERDTreeQuitOnOpen = 1

let g:NERDTreeDirArrowExpandable = '✚'
let g:NERDTreeDirArrowCollapsible = '➜'
set guifont=FantasqueSansMono-Regular\ 13
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
let NERDTreeGitStatusShowIgnored = 1



"Config dos plugins
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_theme='atomic'
set encoding=utf8
let g:airline_powerline_fonts = 1
let g:neocomplete#enable_at_startup = 1

let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
