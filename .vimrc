" My vimrc is highly based on:
" https://github.com/junegunn/dotfiles/blob/master/vimrc
" vim: set foldmethod=marker foldlevel=0:
set nocompatible"{{{"}}}
let s:darwin = has('mac')

" Plug section {{{
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
if v:version >= 703
  Plug 'mhinz/vim-signify'
endif
" endwise.vim: wisely add 'end' in ruby, endfunction/endif/more in vim script,
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'


Plug 'ascenator/L9'
" FZF Fuzzy Search
Plug 'junegunn/fzf', { 'dir': '/usr/local/opt/fzf', 'do': './install --all' }
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
if s:darwin
    " Markdown Preview
    Plug 'junegunn/vim-xmark', { 'do': 'make' }
endif
" vimscrip test framework
Plug 'junegunn/vader.vim'

" Browsing - A vim plugin to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }

" Nerd Tree to view files
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Git flags
Plug 'Xuyuanp/nerdtree-git-plugin'

" Opens the directory of current file
Plug 'justinmk/vim-gtfo'

" Defines text objects to target text after the designated characters.
if v:version >= 703
    Plug 'junegunn/vim-after-object'
endif

" Languages
if v:version >= 703
  Plug 'vim-ruby/vim-ruby'
endif
" Javascript
Plug 'pangloss/vim-javascript'
" Rails
Plug 'tpope/vim-rails'
" TextObjects
Plug 'kana/vim-textobj-user'
" Ruby textobj
Plug 'nelstrom/vim-textobj-rubyblock'
" My potion plugin
Plug 'rderik/potion'
" ALE for linters
Plug 'w0rp/ale'

" Session manager
Plug 'xolox/vim-misc' " vim-session dependency
Plug 'xolox/vim-session'

" Sent commands from vim to TMUX
Plug 'sjl/tslime.vim'

Plug 'mrtazz/simplenote.vim'

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

let mapleader = "\\"
let maplocalleader = "\\"

" NERDTree Map
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
" AG maps
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>

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

" Limelight keymap
nnoremap <Leader>l <Plug>(Limelight)
xnoremap <Leader>l <Plug>(Limelight)

" Session config
let g:session_autosave = 'no'

" Journal date function
function! s:Insert_journal_date()
  let curr_date = strftime("%B %A %d, %Y")
  call append(".", [curr_date , "=================="])
endfunction

" test command for Vader
function! s:vader_tests()
  if expand('%:e') == 'vim'
    let testfile = printf('%s/%s.vader', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(testfile)
      echoerr 'File does not exist: '. testfile
      return
    endif
    source %
    execute 'Vader' testfile
  else
    let sourcefile = printf('%s/%s.vim', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(sourcefile)
      echoerr 'File does not exist: '. sourcefile
      return
    endif
    execute 'source' sourcefile
    Vader
  endif
endfunction


" Linter configuration
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
" This flag can be set to 0 to disable linting when the buffer is entered.
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 0

" SimpleNote
let g:SimplenoteVertical=1

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

  " JavaScript
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<Esc>

  " Ruby
  autocmd FileType ruby nnoremap <buffer> <localleader>c I#<Esc>

  " Journal
  autocmd FileType journal nnoremap <buffer> <localleader>d :<c-u>call <SID>Insert_journal_date()<CR>

  " Potion
  "autocmd FileType potion let g:potion_command = "PATHTO/bin/potion"

  " Racket auto indent replacement
  autocmd filetype lisp,scheme,art setlocal equalprg=scmindent.rkt

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

  " Set the command :Test for any .vader .vim file
autocmd BufRead *.{vader,vim}
      \ command! -buffer Test call s:vader_tests()
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
set laststatus=2
set incsearch
" ctags
set tags=./tags
" shows row and column number at bottom right corner
set ruler
" fix to use clipboard on tmux
set clipboard=unnamed
set hlsearch
filetype plugin indent on    " required

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

" %< Where to truncate
" %n buffer number
" %F Full path
" %m Modified flag: [+], [-]
" %r Readonly flag: [RO]
" %y Type:          [vim]
" fugitive#statusline()
" %= Separator
" %-14.(...)
" %l Line
" %c Column
" %V Virtual column
" %P Percentage
" %#HighlightGroup#
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P

" ----------------------------------------------------------------------------
" Readline-style key bindings in command-line (excerpt from rsi.vim)
" ----------------------------------------------------------------------------
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
" Mnemonic: Copy File path
nnor <leader>cf :let @+=expand("%:p")<CR>
" Mnemonic: Yank File path
nnor <leader>yf :let @"=expand("%:p")<CR>
" Mnemonic: yank File Name
nnor <leader>fn :let @"=expand("%")<CR>
" Slime configuration {{{
let g:tslime_ensure_trailing_newlines = 2
let g:tslime_normal_mapping = '<leader>t'
let g:tslime_visual_mapping = '<leader>t'
let g:tslime_vars_mapping = '<leader>T'
" }}}

" .vimrc utils
" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" envelop visual selection with quotes \"
vnoremap <leader>" <Esc>`>a"<Esc>`<i"<Esc>`>

" toggle spell check
nnoremap <leader>sc :setlocal spell! spelllang=en<CR>

" mute off search higlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" change grep to use ag
set grepprg=ag\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

" }}}
" ----------------------------------------------------------------------------
" Bug fix for Hyper term {{{
" ----------------------------------------------------------------------------
set t_RV=
" }}}
" ============================================================================
" LOCAL VIMRC {{{
" ============================================================================
"let s:local_vimrc = fnamemodify(resolve(expand('<sfile>')), ':p:h').'/vimrc-extra'
" I'll use my home directory .vim to save the local configuration so the git
" file stays clean
let s:local_vimrc = $HOME.'/.vim/vimrc-extra'
if filereadable(s:local_vimrc)
  execute 'source' s:local_vimrc
endif
" }}}
" ============================================================================
