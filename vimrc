" Turn on true colors (NOTE: also setup in terminal emulator + tmux)
set termguicolors

let g:ale_completion_enabled = 0
let g:elm_setup_keybindings = 0
let g:python3_host_prog = '/usr/local/bin/python3'

" Auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""" Setup plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " File & buffer opening
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree' " File system
Plug 'christoomey/vim-tmux-navigator' " Easy tmux-vim navigation
Plug 'tpope/vim-surround' " Adds surround motions
Plug 'vim-scripts/tComment' " Commenting macro
Plug 'rhysd/clever-f.vim' " Easier movements with f/F
Plug 'tpope/vim-fugitive' " git (Gblame, Gdiff)
Plug 'airblade/vim-gitgutter' " Show lines changed in gutter
Plug 'janko-m/vim-test' " Run tests from vim
Plug 'w0rp/ale' " Linter
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " LSP/Autocomplete
" Plug 'sbdchd/neoformat' " Formatter
" Plug 'rhysd/git-messenger.vim' " git hover overs

" Languages & Syntax
Plug 'mxw/vim-jsx'
Plug 'neovimhaskell/haskell-vim'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" Colorschemes
Plug 'liamgriffiths/vim-colors-plain'
Plug 'Lokaltog/vim-monotone'
call plug#end()

""" General Settings
syntax on
filetype on
filetype plugin indent on
set backspace=indent,eol,start
set clipboard=unnamed
set encoding=utf-8
set expandtab
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2 " Always display last status
set noautochdir " Stop changing my dir!
set nobackup
set noerrorbells
set noswapfile
set novisualbell
set nowrap
set nowritebackup
set number
set scrolloff=3 " Start scrolling up/down 3 lines away
set shiftwidth=2
set shortmess+=c " Don't give |ins-completion-menu| messages.
set signcolumn=yes
set smartcase
set softtabstop=2
set synmaxcol=200 " Stop syntax highlighting after col 200, speeds up vim.
set tabstop=8
set tags=./tags;/
set timeoutlen=400 " Let's get snappy!
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=1000
set updatetime=300 " Default: 4000, used for coc.vim diagnostics
set virtualedit=all " Move the cursor where ever you want.
set wildmenu
set wildmode=longest,list,full

" Goofs (i can't spell)
abbr recieve receive
abbr reciever receiver
abbr reciever_id receiver_id


""" Custom keymappings
let mapleader = ','

" I use C-c to escape a lot.
nnoremap <C-c> <silent> <C-c>

" Faster split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Switch back to last buffer (,,)
nmap <leader>, <C-^>

" Switch to alternate file
nnoremap <leader>a :A<cr>

" Reselect visual after indenting
vmap > >gv
vmap < <gv

" Remove whitespace on format
vmap = =:%s/\s\+$//e<CR>gv
nmap == ==:%s/\s\+$//e<CR>

" Faster command mode
map ; :

" When lines wrap this makes the cursor move like you expect
map j gj
map k gk

" FZF shortcuts
nmap <C-p> :Files<CR>
nmap <leader>m :History<CR>

" Paste replaces selection
vnoremap p "_dP

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" Open grepper (ag, rg)
nnoremap \ :Ag<SPACE>
" nnoremap \ :CtrlSF<SPACE>
" nnoremap \\ :CtrlSFToggle<CR>

" Run test on what cursor is close to
nmap <leader>s :TestNearest<CR>

" In terminal mode (neovim, get into normal mode)
tmap <C-t> <C-\><C-n>

" Run grep for word under cursor.
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" nnoremap K :CtrlSF "\b<C-R><C-W>\b"<CR>:cw<CR>

" Show LSP documentation in preview window
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-SPACE> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" TODO: what does this do?
" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
" TODO: what does this do?
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
" TODO: what does this do?
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>




""" Colors & UI
set background=light
colorscheme plain

" Setup terminal buffer with no numbers or listchars
au TermOpen * setlocal listchars= nonumber norelativenumber

" Wrap output in quickfix window
autocmd FileType qf setlocal wrap

" Syntax
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" ALE (async lint engine)
let g:ale_linters = {'javascript': ['eslint', 'flow']}
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_rust_cargo_use_clippy = 1
let g:ale_sign_error = "●"
let g:ale_sign_warning = "●"
let g:ale_change_sign_column_color = 1
hi ALEWarningSign guifg=#ffbb50
hi ALESignColumnWithErrors guibg=none

" Status line
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

set statusline+=%0*\ %f\  " Filepath
set statusline+=%0*\ %= " Whitespace
set statusline+=%0*\ %= " Whitespace
set statusline+=%0*\ %l,%c  " Buffer number
set statusline+=%0*\ %= " Whitespace
set statusline+=%0*\%{fugitive#head()}\  " Current git branch
set statusline+=\%#ALEErrorStatus#%{ALEErrors()} " Show linter errors
set statusline+=\%#ALEWarningStatus#%{ALEWarnings()} " Show linter warnings
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')} " Show Coc.vim status


" Rust
let g:rustfmt_autosave = 1

" Elm
let g:elm_format_autosave = 1

" NERDTree
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store']
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" Rspec (vim-test options)
"let test#ruby#rspec#options = { 'nearest': '--backtrace' }
let test#strategy = "neovim"
let test#neovim#term_position = "botright"

" fzf (fuzzy finder)
let g:fzf_action = { 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" grep/ag
set grepprg=ag\ --vimgrep\ --nocolor\ -i\ -p\ /home/liamgriffiths/work/grailed/.agignore
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" nvim terminal colors hack -_-
let g:terminal_color_0 = "#222222"
let g:terminal_color_8 = "#424242"
let g:terminal_color_1 = "#C30771"
let g:terminal_color_9 = "#E32791"
let g:terminal_color_2 = "#10A778"
let g:terminal_color_10 = "#5FD7A7"
let g:terminal_color_3 = "#e05e00"
let g:terminal_color_11 = "#f9b376"
let g:terminal_color_4 = "#008EC4"
let g:terminal_color_12 = "#B6D6FD"
let g:terminal_color_5 = "#523C79"
let g:terminal_color_13 = "#6855DE"
let g:terminal_color_6 = "#20A5BA"
let g:terminal_color_14 = "#4FB8CC"
let g:terminal_color_7 = "#F1F1F1"
let g:terminal_color_15 = "#999999"

" set autoread format on save.
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
