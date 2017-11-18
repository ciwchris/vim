" .vimrc
" Author: Christopher Lopes <christopher.lopes@gmail.com>

" Preamble ---------------------------------------------------------------- {{{

" dein config: https://github.com/Shougo/dein.vim
if &compatible
    set nocompatible
endif
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/bundles/')
    call dein#begin('~/.vim/bundles/')

    call dein#add('~/.vim/bundles/repos/github.com/Shougo/dein.vim')
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('itchyny/lightline.vim')
    call dein#add('vim-scripts/bufexplorer.zip')
    call dein#add('junegunn/fzf.vim')

    call dein#add('tpope/vim-commentary')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/neocomplete.vim')

    call dein#add('beloglazov/vim-online-thesaurus')

    call dein#add('OmniSharp/omnisharp-vim')

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable
" End dein config

" }}}

" Basic options ----------------------------------------------------------- {{{

" Clear all autocmds so they won't get loaded twice. This needs to be up top!
autocmd!

" Set to auto read when a file is changed from the outside
" set autoread

" allow backspacing over everything in insert mode
" set backspace=indent,eol,start

set encoding=utf-8
set history=1000
set ruler                           " Show the cursor position all the time
set cmdheight=1                     " The commandbar height
set noshowcmd                       " Display incomplete commands
" perl/python regex (comment can't appear on line below)
nnoremap / /\v
vnoremap / /\v
set incsearch                       " Do incremental searching
set hlsearch
set tabstop=4

set wildmenu
set wildmode=list:longest,full      " Tab complete to longest string
set visualbell
set ttyfast

set number                          " Line numbers off
set relativenumber

set cindent
set autoindent
set smartindent
set mouse=a                         " Use mouse in xterm to scroll
set scrolloff=3                     " 3 lines before and after the current line when scrolling
set ignorecase                      " Ignore case
set smartcase                       " But don't ignore it, when search string contains uppercase letters
set hid                             " Allow switching buffers, which have unsaved changes
set shiftwidth=4                    " 4 characters for indenting
set showmatch                       " Showmatch: Show the matching bracket for the last ')'?
set expandtab                       " Use spaces instead of tabs
" Insert only one space when joining lines containing sentence terminating punctuation
set nojoinspaces

set nowrap                          " Don't wrap by default
set completeopt=menu,longest,preview
" Complete from current buffer, window, buffer, unloaded buffer and dictionary (when spelling is turned on)
set complete=.,w,b,u,kspell
set confirm
syn on

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let g:mapleader = "\<Space>"



" Change to directory of current file automatically
autocmd BufEnter,BufRead,BufNewFile,BufFilePost *     execute ":lcd " . expand("%:p:h")
" Turn on folding using markers
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Fast saving
nnoremap <leader>w :w!<cr>

" Fast unloading buffer
nnoremap <leader>d :bd!<cr>

" Fast edit single file
nnoremap <leader>on :on<cr>

" Fast switching to previous buffer
nnoremap <leader>bp :b#<cr>

" Fast editing of the .vimrc
nnoremap <leader>ev :e! $MYVIMRC<cr>

" When vimrc is edited, reload it
augroup write_vimrc
    autocmd!
    autocmd BufWritePost .vimrc source $MYVIMRC
augroup END

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>:set wrap<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convient Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <a-j> <down>
inoremap <a-k> <up>
" Use as leader instead
" nnoremap <space> <c-f>
" Up and down for screen not file line
nnoremap j gj
nnoremap k gk

" Copy & paster system clipboard
vmap <Leader>y "*y 
vmap <Leader>d "*d 
nmap <Leader>p "*p 
nmap <Leader>P "*P 
vmap <Leader>p "*p 
vmap <Leader>P "*P

" Ignores
set wildignore+=*.gif,*.png,*.jpg

""""""" Turn off toolbar
set guioptions-=T

""""""" Remove search highlighting with escape
" ISSUE! When using this after vim starts up we're left in insert mode
"nnoremap <esc> :noh<return><esc>

""""""" viminfo to turn off saving global marks across sessions
set viminfo='100,f0


""""""" show chars for tab and end of line
set list
set listchars=tab:▸\ ,eol:¬


""""""" Copy working directory of current buffer
:nmap ,p :let @p=substitute(expand("%:p:h"), "/", "\\", "g")<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%


" }}}

" NeoVim {{{

" Snow substitution when typing

if has('nvim')
    :set inccommand=nosplit

    " Arch fzf install location of plugin
    set runtimepath+=/usr/share/vim/vimfiles/

endif

" }}}
"
" Digraphs {{{

" To use: ":set digraph" then: ".<BS>-"
silent! dig -. 8230 "U+2026=…  HORIZONTAL ELLIPSIS  

" }}}
"
" Backups {{{


""""""" do not use swap or backup files
" set nobackup
" set nowritebackup
" set noswapfile


" From Steve Losh
set backup                        " enable backups
set noswapfile                    " it's 2013, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}

" Plugin mappings {{{

" lightline
set laststatus=2 " always show
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': { 'left': [['filename','modified']], 'right': [['column']]},
      \ 'inactive': { 'left': [['filename','modified']], 'right': [['column']]}
      \ }


" vim-script html indentation
let g:html_ident_inctags = "html,body,head,tbody"
let g:html_ident_script1 = "inc"
let g:html_ident_style1 = "inc"

" Theme
let s:background_color=readfile($HOME."/.bin/color-mode/current-color-mode","",1)
syntax enable
let &background=s:background_color[0]
colorscheme solarized

" OmniSharp
let g:OmniSharp_server_type = 'roslyn'

" }}}

" Highlight word {{{
highlight InterestingWord1 guibg=green guifg=white
highlight InterestingWord2 guibg=blue guifg=white
highlight InterestingWord3 guibg=pink guifg=black

nnoremap <silent> <leader>he :execute 'match ErrorMsg /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>
nnoremap <leader>hc :match none<cr>:2match none<cr>:3match none<cr>

" I often use one word form accidentially in place of another.
" This will highlight these occurences so I can review them
iabbrev there there<esc>b<leader>heea
iabbrev their their<esc>b<leader>heea
iabbrev attend attend<esc>b<leader>heea
iabbrev our our<esc>b<leader>heea
" }}}

