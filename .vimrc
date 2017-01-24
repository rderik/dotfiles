" vim: set foldmethod=marker foldlevel=0:
set nocompatible
let s:darwin = has('mac')

" Plug section {{{
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Git
Plug 'tpope/vim-fugitive'
if v:version >= 703
  Plug 'mhinz/vim-signify'
endif


Plug 'ascenator/L9'
" airline a litte toolbar at the bottom of the screen
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" FZF Fuzzy Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Colour schema
Plug 'junegunn/seoul256.vim'
" Useful tools for aligning text
Plug 'junegunn/vim-easy-align'
" helpful plugin to write notes on vim using lists and bullets
Plug 'junegunn/vim-journal'
" Git Commit browser requires vim-fugitive (installed before)
Plug 'junegunn/gv.vim'
" Focus writing plugin
Plug 'junegunn/goyo.vim'
" Adds colour to goyo
Plug 'junegunn/limelight.vim'
"  helps visualize matches of parentheses
Plug 'junegunn/rainbow_parentheses.vim'
" Browsing - A vim plugin to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }

" Nerd Tree to view files
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Git flags
Plug 'Xuyuanp/nerdtree-git-plugin'

" Opens the directory of current file
Plug 'justinmk/vim-gtfo'
if v:version >= 703
    Plug 'junegunn/vim-after-object'
endif

" Lang
if v:version >= 703
  Plug 'vim-ruby/vim-ruby'
endif
" Go for vim
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" Javascript 
Plug 'pangloss/vim-javascript'
" Rails
Plug 'tpope/vim-rails'
" Fish script - fish terminal
Plug 'dag/vim-fish'
" TextObjects
Plug 'kana/vim-textobj-user'
" Ruby textobj
Plug 'nelstrom/vim-textobj-rubyblock'
" My potion plugin
Plug 'rderik/potion'


" All of your Plugins must be added before the following line
call plug#end()            " required
" }}}
" This setting is required for vim-textobj
if has("autocmd")
    filetype indent plugin on
endif
" ----------------------------------------------------------------------------
" matchit.vim - This enables filetype plugins, many of which tell  matchit.vim which matching pairs to use.
" Note: runtime is the same as source except that the path is relative to the
" Vim installation directory.
" ----------------------------------------------------------------------------
runtime macros/matchit.vim

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" Plugins configurations {{{
" Unified color scheme (default: dark)
colo seoul256
" Light color scheme
colo seoul256-light
" Switch
set background=dark

let mapleader = ","
" Go configuration
noremap <C-n> :cnext<CR>
noremap <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>


" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
set autowrite


" NERDTree Map
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0

" airline
set laststatus=2
" FZF configuration
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" This will split only under the current window.
let g:fzf_layout = { 'window': '10 split | enew'}
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" EasyAlign configuration
" Start interactive EasyAlign in visual mode (e.g. vipga)
xnoremap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(EasyAlign)

" Limilight keymap
nnoremap <Leader>l <Plug>(Limelight)
xnoremap <Leader>l <Plug>(Limelight)

" }}}

" ----------------------------------------------------------------------------
" goyo.vim + limelight.vim {{{
" ----------------------------------------------------------------------------
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  Limelight
  let &l:statusline = '%M'
  hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  Limelight!
endfunction

nnoremap <Leader>G :Goyo<CR>
" }}}
" ----------------------------------------------------------------------------
" Autocommand {{{
" ----------------------------------------------------------------------------
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END
augroup vimrc
  autocmd!
 " go config
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " Limelight Goyo auto integration
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()

  " vim-after-object
  autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

  " Browsing - A vim plugin to display the indention levels with thin vertical lines
  autocmd! User indentLine doautocmd indentLine Syntax
augroup END
" }}}


" ----------------------------------------------------------------------------
" General Settings {{{
" ----------------------------------------------------------------------------
set expandtab
set pastetoggle=<F3>
set bs=2
set ts=2
set sw=2
set number
set encoding=utf-8
set history=1000
set wildmenu
set wildmode=list:longest
" shows row and column number at bottom right corner
set ruler
" fix to use clipboard on tmux
set clipboard=unnamed
filetype plugin indent on    " required
let g:potion_command = "/Users/derik/Documents/Development/potion/potion/bin/potion"
" ----------------------------------------------------------------------------
" Readline-style key bindings in command-line (excerpt from rsi.vim)
" ----------------------------------------------------------------------------
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! exe "set <S-Left>=\<Esc>b"
silent! exe "set <S-Right>=\<Esc>f"
" }}}
