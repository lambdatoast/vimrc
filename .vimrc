
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

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
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" general editing config
let mapleader = ";"
set ai
set expandtab " Convert tabs to spaces
set shiftwidth=2 " Indentation tab to 2 spaces
set softtabstop=2
set showcmd   " Show (partial) command in status line.
set showmatch   " Show matching brackets.
vnoremap _ VdkPv
"" Move line down
vnoremap - VdjPv
nnoremap <leader>l :syn off<CR>:syn on<CR>
nnoremap ;4 :set shiftwidth=4<CR>

" pathogen config
execute pathogen#infect()

" drupal config
hi Comment ctermfg=gray
"" drupal-related file extensions
au BufNewFile,BufRead *.module set filetype=php
au BufNewFile,BufRead *.profile set filetype=php
au BufNewFile,BufRead *.test set filetype=php
au BufNewFile,BufRead *.install set filetype=php
au BufNewFile,BufRead *.inc set filetype=php
nnoremap ;dc :!drush cc all; drush cron;<CR><CR>

" scala config
au BufNewFile,BufRead *.twig set filetype=html

" purescript config
au BufNewFile,BufRead *.purs set filetype=haskell

" elm config

nnoremap <leader>ee :ElmEvalLine<CR>
nnoremap <leader>ep :ElmPrintTypes<CR>
nnoremap <leader>em :ElmMakeCurrentFile<CR>

" jekyll config
nnoremap <leader>jb :!jekyll build<CR>

" ctags config
nnoremap <leader>] :tn<CR>
nnoremap <leader>t :tp<CR>

" theme config
colorscheme solarized
call togglebg#map("<leader>s")

" markdown config
let g:vim_markdown_folding_disabled=1

" airline config
set laststatus=2
set ttimeoutlen=50
" let g:airline_theme=""
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  if g:airline_theme == 'solarized'
    for colors in values(a:palette.normal)
      let colors[2] = 20
    endfor
  endif
endfunction
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

" gitgutter config
autocmd BufReadPre,FileReadPre * :GitGutter
