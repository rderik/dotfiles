" My vimrc is highly based on:
" https://github.com/junegunn/dotfiles/blob/master/vimrc
" vim: foldmethod=marker

set nocompatible
let s:darwin = has('mac')

" Plug section {{{
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rhubarb'
if v:version >= 703
  Plug 'mhinz/vim-signify'
endif
" endwise.vim: wisely add 'end' in ruby, endfunction/endif/more in vim script,
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-obsession'
" l9 is a Vim-script library, which provides some utility functions and commands
" for programming in Vim.
Plug 'ascenator/L9'
" FZF Fuzzy Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plugin that makes color aproximation for temrinal
Plug 'godlygeek/csapprox'
" Colour schemas
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rderik/thankful_eyes'
Plug 'ayu-theme/ayu-vim'
"Plug 'vim-scripts/CSApprox'

" Display ctags on current file
Plug 'majutsushi/tagbar'
" Org-mode
Plug 'jceb/vim-orgmode'
" Plugin to create links - Universal Text Linking
Plug 'vim-scripts/utl.vim'
" Ledger accounting
Plug 'ledger/vim-ledger'
"Useful tools for aligning text
Plug 'junegunn/vim-easy-align'
" helpful plugin to write notes on vim using lists and bullets
Plug 'junegunn/vim-journal'
" Git Commit browser requires vim-fugitive (installed before)
Plug 'junegunn/gv.vim'
"  helps visualize matches of parentheses
Plug 'junegunn/rainbow_parentheses.vim'
" Markdown Preview
Plug 'junegunn/vim-xmark', { 'do': 'make' }
" vimscrip test framework
Plug 'junegunn/vader.vim'
" Distracton free writing
Plug 'junegunn/goyo.vim'
" Create Table of Content form Markdown files
Plug 'rderik/vim-markdown-toc', { 'branch': 'add-anchors-to-headings/drc2r' }
" Markdown rendering
Plug 'plasticboy/vim-markdown'
" Markdown footnotes
Plug 'vim-pandoc/vim-markdownfootnotes'

" Browsing - A vim plugin to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }

" Nerd Tree to view files
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Nerd Commenter
Plug 'scrooloose/nerdcommenter'
" Git flags
Plug 'Xuyuanp/nerdtree-git-plugin'

"Vim Tables
Plug 'dhruvasagar/vim-table-mode'

"Opens the directory of current file

" Defines text objects to target text after the designated characters.
if v:version >= 703
    Plug 'junegunn/vim-after-object'
endif

" Languages

" Javascript
Plug 'pangloss/vim-javascript'
" Vue JavaScript Frontend
Plug 'leafOfTree/vim-vue-plugin'
"JSX
Plug 'mxw/vim-jsx'
" TextObjects
Plug 'kana/vim-textobj-user'
" Ruby textobj
Plug 'nelstrom/vim-textobj-rubyblock'
" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-dispatch'
" Rails
Plug 'tpope/vim-rails'
" TypeScript
Plug 'leafgarland/typescript-vim'
" Rust
Plug 'rust-lang/rust.vim'
"Swift
Plug 'keith/swift.vim'
" Cargo
Plug 'timonv/vim-cargo'
" Racer - use Racer for Rust code completion and navigation.
Plug 'racer-rust/vim-racer'
" My potion plugin
Plug 'rderik/potion'
" Fish script
Plug 'dag/vim-fish'
" Vapor Leaf templating language
Plug 'vapor-community/vim-leaf'
" Vim LSP related :CocConfig to open configuration file
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Twig template system for PHP
Plug 'nelsyeung/twig.vim'

" Session manager
Plug 'xolox/vim-misc' " vim-session dependency
Plug 'xolox/vim-session'

" Sent commands from vim to TMUX
Plug 'sjl/tslime.vim'

" Emmet is a text expander
Plug 'mattn/emmet-vim'

" Nginx syntax
Plug 'vim-scripts/nginx.vim'

"Snippets
Plug 'honza/vim-snippets'

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
"set termguicolors     " enable true colors support
"let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
colorscheme dracula
set term=xterm-256color

let mapleader = "\\"
let maplocalleader = "\\"

" NERDTree Map
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
let g:NERDTreeSortOrder=['\/$', '*', '\.swp$',  '\.bak$', '\~$']
let NERDTreeNaturalSort = 0
" AG maps
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>

" EasyAlign configuration
" Start interactive EasyAlign in visual mode (e.g. vipga)
xnoremap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(EasyAlign)

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
"AG is already configured to work with FZF if we want to us ripgrep we use the
"following command, and now we can use Rg and the search will be performed by
"ripgrep
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
\   <bang>0 ? fzf#vim#with_preview('up:60%')
\           : fzf#vim#with_preview('right:50%:hidden', '?'),
\   <bang>0)

" Journal date function
function! s:Insert_journal_date()
  let l:curr_date = '# ' . strftime('%Y-%m-%d %A')
  call append('.', [ l:curr_date ])
endfunction

"Rust
let g:rustfmt_autosave = 1
" Session config
let g:session_autosave = 'no'



"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
nnoremap <leader>sy :SyntasticToggleMode<CR>

"Table mode
let g:table_mode_header_fillchar='='

"tags
nnoremap <silent> <Leader>t       :Tags <CR>

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

"Goyo configuration 
map <Leader>g :Goyo<CR>

" Show Ctags ofcurrent file
map <Leader>TT :TagbarToggle<CR>
let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }

" follow UTL link
nmap <LocalLeader>gt :Utl<CR>

" Emmet JSX support of little detials like className
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
" Racer Rust
set hidden
let g:racer_cmd = "$HOME/.cargo/bin/racer"
let g:racer_experimental_completer = 1

"Ledger
let g:ledger_align_at = 80
" Vim markdown Table of Contents
let g:vmt_insert_anchors = 1
let g:vmt_auto_update_on_save = 1

"Vim-markdown plugin
let g:vim_markdown_conceal=2
let g:vim_markdown_conceal_code_blocks = 1
let g:vim_markdown_folding_disabled = 1

let g:coc_global_extensions = ["coc-snippets"]
" Snippet
imap <LocalLeader><Tab> <Plug>(coc-snippets-expand)

"}}}

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

" PHP
autocmd FileType php setlocal ts=4 sw=4 sts=4 expandtab

" Objective-c
au BufNewFile,BufRead *.m set filetype=objc
" Treat plist files as XML
au BufNewFile,BufRead *.plist set filetype=xml

" Markdown
autocmd FileType markdown nnoremap <buffer> <localleader>d :<c-u>call <SID>Insert_journal_date()<CR>

" Ledger
au FileType ledger noremap { ?^\d<CR>
au FileType ledger noremap } /^\d<CR>
autocmd FileType ledger setlocal foldmethod=syntax
autocmd FileType ledger nnoremap <buffer> <localleader>d :<c-u>call ledger#transaction_date_set(line('.'), "auxiliary")<CR>
autocmd FileType ledger nnoremap <buffer> <localleader>s :<c-u>call ledger#transaction_state_toggle(line('.'), ' *?!')<CR>
autocmd FileType ledger nnoremap <buffer> <localleader>e :<c-u>call ledger#entry()<CR>
" If text is selected, save it in the v buffer and send that buffer it to tmux
autocmd FileType ledger vmap <LocalLeader>= "v :LedgerAlign<CR>

" If the filetype is Makefile then we need to use tabs
" So do not expand tabs into space.
autocmd FileType make   set noexpandtab

" Potion
"autocmd FileType potion let g:potion_command = "PATHTO/bin/potion"

" Racket auto indent replacement
autocmd filetype lisp,scheme,art setlocal equalprg=scmindent.rkt

" Vimscript
autocmd FileType vim setlocal ts=4 sw=4 sts=4 expandtab

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
" Swift linter
autocmd FileType swift setlocal makeprg=swiftlint\ lint
augroup END

" To behave nicely when resizeing the current pane in tmux
autocmd VimResized * :wincmd =
" }}}


" ----------------------------------------------------------------------------
" General Settings {{{
" ----------------------------------------------------------------------------
set expandtab
set pastetoggle=<F3>
set bs=2
set ts=2
set sw=2
set nu
set encoding=utf-8
set history=1000
set wildmenu
set wildmode=list:longest
set laststatus=2
set incsearch
set modelines=3
set eol
set nolist
"cursorlines are very useful but they make the whole interface slow
"set cursorline "highlight current line
"set cursorcolumn "highlight curent column
" ctags
set tags=./tags
" For Tpope's Fugitive Plugin
set tags^=./.git/tags;
" shows row and column number at bottom right corner
set ruler
" fix to use clipboard on tmux
set clipboard=unnamed
set hlsearch
filetype plugin indent on

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

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

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
let g:tslime_normal_mapping = '<Leader>t'
let g:tslime_visual_mapping = '<Leader>t'
let g:tslime_vars_mapping = '<Leader>T'
" }}}

" ----------------------------------------------------------------------------
" Mappings {{{
" ----------------------------------------------------------------------------
" .vimrc utils
" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" bash_profile utils
let $BASH_PROFILE = '~/.bash_profile'
nnoremap <leader>eb :vsplit $BASH_PROFILE<cr>

" toggle spell check
nnoremap <leader>sc :setlocal spell! spelllang=en<CR>

" mute off search higlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Set list of non visible characters
set listchars=eol:⏎,tab:␉·,trail:☠,nbsp:⎵
" The command :dig displays other digraphs you can use.
nmap <leader>sl :set list!<CR>


" use FZF buffers
nnoremap <leader>b :Buffers<CR>

" }}}

" Close all buffers except currenton
"nnoremap <leader>z :%bd|e#

" Mappings for vimscirpt
nnoremap <leader>x :exec getline('.')<CR>

" change grep to use ag
set grepprg=ag\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" General Surround for erb
" as suggested by TPope https://github.com/tpope/vim-rails/issues/245
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"

" Aoutocomplete improvements
" https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone
inoremap <expr> <C-CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" }}}
" ----------------------------------------------------------------------------
" Bug fix for Hyper term {{{
" ----------------------------------------------------------------------------
"set t_RV=
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
