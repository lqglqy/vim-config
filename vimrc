" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup        " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
set history=50        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch        " do incremental searching
set number
color desert
syntax on
set tabstop=8
set nobackup
"set foldmethod=indent
set textwidth=78
set cindent
set cino=:0,t0,+4,(0,u0,l1,c0
set comments=sr:/*,mb:*,ex:*/
if $TERM !="linux"
 "set mouse=a
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
"set mouse=a

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

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
         \ | wincmd p | diffthis

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


"let NERD_Use_Right_Window=1

let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

let NERDTreeWinPos='right'  
let NERDTreeShowLineNumbers=1
let NERDTreeWinSize=30      
let NERDChristmasTree=1      
let NERDTreeAutoCenter=1    
let NERDTreeDirArrows = 0

"Tlist
let Tlist_Show_One_File=1
let Tlist_Auto_Open=1
let Tlist_Exit_OnlyWindow=1
"set Tlist_Inc_Winwidth=0
"source ~/cscope_maps.vim
"%s@DBG_OUT(\{1,\}DERR\,@DBG_OUT(\{1,\}DERR@g
"TlistToggle
set cindent
map <F2> :TlistToggle<CR>
"map <F3> :call Search_Word()<CR>
map <F3> :!grep -nr <C-r><C-w> *<CR>
map <F4> <Esc>o/*<CR><CR>/<Esc>ka<Space>
"nmap <C-m> :set mouse=a<CR>
nmap <C-c> :set mouse=<CR>
nmap <F8>   :TrinityToggleAll<CR>
nmap <C-.> <C-w> <S-.>
"nmap <F9> :%s@^\/\*!\(.*\n\)\{-1,} \*\/@@g<CR>
"nmap <F9>   :TrinityToggleSourceExplorer<CR>
map <F9> :NERDTreeToggle<CR>
nmap <F10>  :TrinityToggleTagList<CR>
nmap <F11>  :TrinityToggleNERDTree<CR>
nnoremap <F5> "=strftime("%F %T")<CR>gP
"map <F6> :Explore<CR>

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.*/
"set paste

" To do the first type of search, hit 'CTRL-\', followed by one of the
" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
" search will be displayed in the current window.  You can use CTRL-T to
" go back to where you were before the search.  
"

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"cs add ~/work_space/nm130508/cscope.out
if has("cscope")  
    set csprg=/usr/bin/cscope  
    set csto=0 
    set cst  
    set csverb  
    set cspc=3 
    set nocsverb
    "add any database in current dir  
    if filereadable("cscope.out")  
	    cs add cscope.out  
    "else search cscope.out elsewhere  
    else 
	    let cscope_file=findfile("cscope.out",".;")  
	    let cscope_pre=matchstr(cscope_file,".*/")  
	    if !empty(cscope_file) && filereadable(cscope_file)  
		    exe "cs add" cscope_file cscope_pre 
	    endif        
    endif  
    set csverb
endif

"set cscopequickfix=c-,d-,e-,g-,i-,s-,t-
"nmap <C-n> :cnext<CR>
"nmap <C-p> :cprev<CR> 
"nmap <C-t> :colder<CR>:cc<CR>


"colorscheme torte 
"set t_Co=256
"colorscheme darkblue
colorscheme desert

"set fileencodings = "en_US.UTF-8,GBK,gb18030"
set fileencodings = "utf-8,ucs-bom,cp936,gbk,gb2312,big5,latin1"

set completeopt=longest,menu



" Convenient command to see the difference between the current buffer and the
" " file it was loaded from, thus the changes you made.
" "command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
" "                       \ | wincmd p | diffthis
"
 set shiftwidth=8
 set tabstop=8
"
" " ???ڵ????м?????
 set lbr
" " ?򿪶???ģ????????????֧??
 set fo+=mB
"
 source $VIMRUNTIME/ftplugin/man.vim
"
" " ???????·??ŵĵ??ʲ?Ҫ?????зָ? 
 set iskeyword+=_,$,@,%,#
"
" " ??????ʾƥ????��??
 set showmatch
"
" " ?????ַ??????䲻??100?????? 
" " :highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
" " :match OverLength '\%101v.*'
"
 set wildmode=list:full
" " ?Զ???ȫ????ʱ??ʹ?ò˵?ʽƥ???б?
 set wildmenu
 set wildignore=*.bak,*.o,*.e,*~
"
" " set nocp
 filetype plugin on


 "-------------------------------------------------------------------------------
 "" Use of dictionaries
 "-------------------------------------------------------------------------------
 ""
 set complete+=k           " scan the files given with the 'dictionary' option

 "-------------------------------------------------------------------------------
 "" Various settings
 "-------------------------------------------------------------------------------
 ""
 set autoread              " read open files again when changed outside Vim
 set autowrite             " write a modified buffer on each :next , ...
 set browsedir  =current   " which directory to use for the file browser

 set visualbell            " visual bell instead of beeping

 " ??Cע???и????ַ???
  let c_comment_strings=1

"-------------------------------------------------------------------------------
""" bash-support.vim
"-------------------------------------------------------------------------------
let g:BASH_AuthorName   = 'qg.liu'
let g:BASH_AuthorRef    = ''
let g:BASH_Company      = ''
let g:BASH_Email        = 'lqglqy@126.com'
"
""let OmniCpp_ShowScopeInAbbr = 1
"let OmniCpp_ShowPrototypeInAbbr = 1
""let OmniCpp_ShowAccess = 0

if has("autocmd")
	autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
	autocmd InsertLeave * if pumvisible() == 0|pclose|endif
endif " has("autocmd")

function AddTitle()
	call setline(1,"/****************************************************")
	call append(1,"       Function: ")
	call append(2,"    Description: ")
	call append(3,"          Input: ")
	call append(4,"         Output: ")
	call append(5,"         Return: ")
	call append(6,"****************************************************/")
endf
map func :call AddTitle():$o
