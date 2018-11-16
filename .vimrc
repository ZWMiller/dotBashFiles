""""" Set Color Scheme (~/.vim/colors)
set termguicolors
colorscheme zachVimColorsSSH

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setting up Vundle - the vim plugin bundler
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
"Add your bundles here

" To install new ones do: \s to source this update file and then :PluginInstall
Plugin 'bling/vim-airline'
Plugin 'wincent/Command-T'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'sjl/gundo.vim'
Plugin 'jQuery'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'airblade/vim-gitgutter'
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'mattn/emmet-vim'
Plugin 'elzr/vim-json'
Plugin 'briancollins/vim-jst'
let g:instant_markdown_autostart = 0
" You can manually trigger markdown previewing with :InstantMarkdownPreview
Plugin 'suan/vim-instant-markdown'
" All of your Plugins must be added before the following line
Plugin 'kchmck/vim-coffee-script'
Plugin 'wavded/vim-stylus'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-jdaddy'
Plugin 'ngmy/vim-rubocop'
Plugin 'davidhalter/jedi-vim'
Plugin 'morhetz/gruvbox'
call vundle#end() 

""""" Text Formatting
set autoindent " Auto indentation
set smartindent " fixed autoindent fails
set expandtab " All new tab characters will be turned to spaces.
set shiftround
set shiftwidth=2 " Set shift width to n characters
set smarttab
set tabstop=3
" Tab at start of line inserts shiftwidth spaces, elsewhere inserts tabstop spaces
" use :retab to convert all existing tab characters to match current tab
" settings.

""""" Search Formating
set ignorecase " Case insensitive search
set smartcase " Ignore's case of search only if all lowercase
set wildignore+=tmp
nnoremap <silent> <C-l> :nohl<CR><C-l> "<ctrl-l> removes highlights

" Stuff from $VIMRUNTIME\vimrc_example.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set nonumber

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
set guioptions+=t

" Remove scrollbars!
set guioptions-=L
set guioptions-=R
set guioptions-=l
set guioptions-=r

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text,markdown,ruby,javascript setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

    " git commits always start on the first line.
    " From http://vim.wikia.com/wiki/Always_start_on_first_line_of_git_commit_message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  augroup END
else

  set autoindent
  set smartindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
"" Turn off auto-comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
""""" Root Syntax enabled by ~/.vim/after/syntax/c.vim
""""" Window Swapping (in window 1, type /wm. Go to window 2, type /pw)
function! MarkWindowSwap()
  let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
  "Mark destination
  let curNum = winnr()
  let curBuf = bufnr( "%" )
  exe g:markedWinNum . "wincmd w"
  "Switch to source and shuffle dest->source
  let markedBuf = bufnr( "%" )
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' curBuf
  "Switch to dest and shuffle source->dest
  exe curNum . "wincmd w"
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

"" Add search and replace current word
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

set directory=$HOME/.vim/swap//
set backupdir=$HOME/.vim/backups//

"" Highlight Self in python
augroup PythonCustomization
  " highlight python self, when followed by a comma, a period or a parenth
   :autocmd FileType python syn match pythonStatement "\(\W\|^\)\@<=self\([\.,)]\)\@="
augroup END
