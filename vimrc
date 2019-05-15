"""neovim hacks
let g:omni_sql_no_default_maps = 1 "sql autocomplete bug :(

"turn on true colors (NOTE: also setup in terminal emulator + tmux)
set termguicolors

let g:ale_completion_enabled = 1
let g:elm_setup_keybindings = 0

"""setup plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "file & buffer opening
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree' "file system
Plug 'christoomey/vim-tmux-navigator' "easy tmux-vim navigation
Plug 'tpope/vim-surround' "adds surround motions
Plug 'vim-scripts/tComment' "comment shortcuts
Plug 'rhysd/clever-f.vim' "easier movement with f/F
Plug 'tpope/vim-fugitive' "git diff, blame, etc
Plug 'airblade/vim-gitgutter' "show lines changed in gutter
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'elmcast/elm-vim'
Plug 'janko-m/vim-test' "run tests from vim
Plug 'w0rp/ale' "linter
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'roxma/nvim-yarp' "requirement for ncm
Plug 'ncm2/ncm2' "autocompleter
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'andreypopp/vim-colors-plain'
Plug 'Lokaltog/vim-monotone'
call plug#end()

"""general settings
syntax on
filetype on
filetype plugin indent on
set hidden
set encoding=utf-8
set clipboard=unnamed
set expandtab
set history=1000
set hlsearch
set ignorecase
set smartcase
set incsearch
set laststatus=2 "always display last status
set number
set scrolloff=3 "start scrolling up/down 3 lines away
set shiftwidth=2
set softtabstop=2
set tabstop=8
set wildmenu
set wildmode=longest,list,full
set backspace=indent,eol,start
set timeoutlen=400 "let's get snappy!
set noautochdir "stop changing my dir!
set noerrorbells
set novisualbell
set nowrap
set noswapfile
set virtualedit=all "move the cursor where ever you want.
set synmaxcol=200
set tags=./tags;/
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=1000

"goofs (i can't spell)
abbr recieve receive
abbr reciever receiver
abbr reciever_id receiver_id


"""custom keymappings
let mapleader = ','

"i use C-c to escape a lot.
nnoremap <C-c> <silent> <C-c>

"faster split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"switch back to last buffer
nmap <leader>, <C-^>

"switch to alternate file
nnoremap <leader>a :w<cr>:call AltCommand(expand('%'), ':e')<cr>

"reselect visual after indenting
vmap > >gv
vmap < <gv

"remove whitespace on format
vmap = =:%s/\s\+$//e<CR>gv
nmap == ==:%s/\s\+$//e<CR>

"faster command
map ; :

"when lines wrap this makes the cursor move like you expect
map j gj
map k gk

"fzf
nmap <C-p> :Files<CR>
nmap <leader>m :History<CR>

"paste replaces selection
vnoremap p "_dP

"toggle nerdtree
map <C-n> :NERDTreeToggle<CR>

"grep workspace for work under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

"open grepper (ag, rg)
nnoremap \ :Ag<SPACE>

"run test on what cursor is close to
nmap <leader>s :TestNearest<CR>

"in terminal mode (neovim, get into normal mode)
tmap <C-t> <C-\><C-n>

"language server keymappings, show docs, goto definition
nnoremap <silent> H :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>


""" colors, ui
set background=light
colorscheme plain

" setup terminal buffer with no numbers or listchars
au TermOpen * setlocal listchars= nonumber norelativenumber

"wrap output in quickfix window
autocmd FileType qf setlocal wrap

"syntax
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

"ale (async lint engine)
let g:ale_linters = {'javascript': ['eslint', 'flow']}
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_rust_cargo_use_clippy = 1
let g:ale_sign_error = "●"
let g:ale_sign_warning = "●"
let g:ale_change_sign_column_color = 1
hi ALEWarningSign guifg=#A89C14
hi ALESignColumnWithErrors guibg=none


" status line
function! ALEWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '   ' : printf(' %d⚐ ', all_non_errors)
endfunction

function! ALEErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  return l:all_errors == 0 ? '   ' : printf(' %d✘ ', all_errors)
endfunction

set statusline+=%0*\ %f\  "filepath
set statusline+=%0*\ %= "whitespace
set statusline+=%0*\ %= "whitespace
set statusline+=%0*\ %l,%c  "buffer number
set statusline+=%0*\ %= "whitespace
set statusline+=%0*\%{fugitive#head()}\  "git branch
set statusline+=\%#ALEErrorStatus#%{ALEErrors()} "show linter errors
set statusline+=\%#ALEWarningStatus#%{ALEWarnings()} "show linter warnings


"""custom functions
"opens 'alternate' file - see <leader>a
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction


"rust
let g:rustfmt_autosave = 1

"elm
let g:elm_format_autosave = 1

"nerd treeeee
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store']
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

"rspec
"let test#ruby#rspec#options = { 'nearest': '--backtrace' }
let test#strategy = "neovim"
let test#neovim#term_position = "botright"

"fzf (fuzzy finder)
let g:fzf_action = { 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"grep/ag
set grepprg=ag\ --vimgrep\ --nocolor\ -i\ -p\ /home/liamgriffiths/work/grailed/.agignore
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

"ncm autocompleter
"enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

"language server
let g:LanguageClient_autoStart = 1
let g:LanguageClient_useVirtualText = 0 "this is cool but super annoying.
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['flow-language-server', '--stdio'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'ruby': ['tcp://localhost:7658']
    \}

