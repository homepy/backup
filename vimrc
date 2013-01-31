"""""""""""""""""""vimrc sample"""""""""""""""""""""""""""""
"An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
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

" Use Vim settings, rather than Vi settings (much better!).
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

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

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

  " For all text files set 'textwidth' to 79 characters.
  autocmd FileType text setlocal textwidth=79

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 关闭文件备份
set nobackup
set nowritebackup
set noswapfile    " (additionally disable swap files)


" 对于多字节字符支持 (如 CJK 支持):
set fileencodings=utf-8,ucs-bom,cp936,big5,euc-jp,euc-kr,gb18030,latin1

set tabstop=4       " 文件中一个 <Tab> 占据的空格数。
set shiftwidth=4    " 每一级自动缩进的空格数。

" 代码高亮
filetype plugin on
syntax on

" 显示行号
set number

"高亮显示匹配的括号
set showmatch

set showcmd         " 在状态栏中显示(部分)命令。

" 环绕搜索
set wrapscan
set hlsearch        " 当有一个符合之前搜索的值时，高亮所有匹配
set ignorecase      " 在搜索中忽略大小写

set ruler           " 显示当前光标位置的行号和列号，用逗号分割

colorscheme desert

"set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.


set guifont=Inconsolata\ 13


if has("autocmd")

  " 自动检测文件类型并加载相应的设置
  filetype plugin indent on

  " Python 文件的一般设置，比如不要 tab 等
  autocmd FileType python setlocal et | setlocal sta | setlocal sw=4

  " Python Unittest 的一些设置
  " 可以让我们在编写 Python 代码及 unittest 测试时不需要离开 vim
  " 键入 :make 或者点击 gvim 工具条上的 make 按钮就自动执行测试用例
  "autocmd FileType python compiler pyunit
  "autocmd FileType python setlocal makeprg=python\ ./alltests.py
  "autocmd BufNewFile,BufRead test*.py setlocal makeprg=python\ %

  " 自动使用新文件模板
  "autocmd BufNewFile test*.py 0r ~/.vim/skeleton/test.py
  "autocmd BufNewFile alltests.py 0r ~/.vim/skeleton/alltests.py
  "autocmd BufNewFile *.py 0r ~/.vim/skeleton/skeleton.py

endif

let python_highlight_all = 1 

" filetype plugin on
let g:pydiction_location = '/usr/share/pydiction/complete-dict'

" taglist
" let Tlist_Ctags_Cmd='/usr/bin/ctags' 		" 指定Exuberant ctags程序的位置
" let Tlist_Use_Right_Window=1 			" taglist窗口出现在右侧
" let Tlist_Show_One_File=1
" let Tlist_Exit_OnlyWindow=1 			" taglist窗口是最后一个窗口时退出VIM



" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeWinSize=22

" tagbar
let g:tagbar_ctags_bin = '/usr/bin/ctags'	" specify the location of your ctags executable
let g:tagbar_width = 30			" Width of the Tagbar window
let g:tagbar_foldlevel = 3 			" Folds with a level
						" higher than this number will be closed.
autocmd FileType python,c,cpp nested :TagbarOpen 	" open Tagbar only for specific filetypes
        
" let g:tagbar_left = 1 			" to open it on the left instead.
" autocmd VimEnter * nested :TagbarOpen 	" open Tagbar automatically on Vim startup no matter what


" hot key 快捷键 
" <F7> flake8
nmap <F8> :NERDTree<CR>
nmap <F9> :TagbarToggle<CR>

