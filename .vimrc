"高亮搜索
set hlsearch
"在搜索时，输入的词句的逐字符高亮（类似firefox的搜索） 
set incsearch 
syntax on
set tabstop=4
set softtabstop=4
set ts=4
set expandtab
set shiftwidth=4
set autoindent
set cindent
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set nu

"添加cscope表示执行成功或失败的信息
set csverb

"t_Co即terminal Color之意
set t_Co=256
" 高亮当前行,一条线
set cursorline
"一行设置背景色
"hi cursorline   cterm=NONE ctermbg=lightgray ctermfg=NON
"ctermbg是指背景色,hi又是指highlight line,下面这句话就是指
"高亮鼠标所在行的背景颜色,里面的数字是指什么样的颜色
"首先要设置你的终端->仿真->终端"xterm",选中ANSI颜色选项
"终端里面输入命令:tput colors;结果显示256证明支持256色了
hi cursorline cterm=NONE ctermbg=233 ctermfg=NONE

"设置可是块的颜色
"我securecrt显示的可视块颜色将里面的内容都盖掉了
"我自己重新设置了下
"命令模式下输入hi, 你会看到高亮显示的配置
hi Visual term=reverse ctermbg=245 guibg=reverse

"menu弹层
"hi Pmenu ctermbg=2
"背景深
highlight Pmenu ctermbg=darkred
highlight PmenuSel ctermbg=red ctermfg=yellow
"下面是我自己试验的绿色系的,感觉还是红色的好点
"highlight Pmenu ctermbg=2
"highlight PmenuSel ctermbg=2 ctermfg=yellow

set foldmethod=indent
"折叠代码： 快捷按键 zc
"递归折叠代码： 快捷按键 zC
"取消代码折叠： 快捷按键 zo
"递归取消折叠代码: 快捷按键 zO
"折叠文件中的所有代码： 快捷按键 zM
"取消文件中所有代码的折叠： 快捷按键 zR
"对第m行到第n行进行折叠： 打开折叠，使用命令： :m,nfoldopen, 关闭折叠，使用命令： :m,nfoldclose
"在折叠代码中的上下移动： 在打开的折叠中：[z ]z 在关闭的折叠中：zj zk （一试便知）
"遇到大写的字母就是shift+键盘上的字母
"if &term=="xterm"
"set t_Co=8
"set t_Sb=^[[4%dm
"set t_Sf=^[[3%dm
"endif

"光标遇到折叠，折叠就打开 
"set foldopen=all 
"移开折叠时自动关闭折叠 
"set foldclose=all 
"置粘贴模式，这样粘贴过来的程序代码就不会错位了
"默认打开这个功能,neocomplcache就会失效
"set paste 

"打开光标的行列位置显示功能 
set ruler 

"增强模式中的命令行自动完成操作 
set wildmenu 

set nocompatible              " be iMproved, required
filetype off                  " required

"filetype plugin indent on    " required

let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
"set tags="/home/chester/.vim/tags"
"以下去实时更新tags,目前不需要,只需手动执行下ctags就好了
"au BufWritePost *.cpp,*.h,*.c,*.rl,*.def call system(“ctags –tag-relative -a -o ~/.vim/tags/usr/ctags/tags –extra=+q ” . expand(“%:p”))
map <F6> :NERDTreeToggle<CR>
map <F7> :TlistToggle<CR>
map <F8> t :NERDTreeMirror<CR>

"快捷键for DoxGenToolKit
map gx :Dox<CR>
map ga :DoxAut<CR>
map gl :DoxLic<CR>

let g:DoxygenToolkit_briefTag_pre="@Synopsis  " 
let g:DoxygenToolkit_paramTag_pre="@Param " 
let g:DoxygenToolkit_returnTag="@Returns   " 
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------" 
let g:DoxygenToolkit_authorName="Ji Chao" 
let g:DoxygenToolkit_licenseTag="My own license"

" 记住上次编辑的位置
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif

filetype plugin on
set dictionary-=~/.vim/php_funclist.txt dictionary+=~/.vim/php_funclist.txt
"Use the dictionary completion
set complete-=k complete+=k
function! InsertTabWrapper()
    let col=col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<TAB>"
    else
        return "\<C-N>"
    endif
endfunction
"Remap the tab key to select action with InsertTabWrapper
inoremap <TAB> <C-R>=InsertTabWrapper()<CR>

if !exists('g:AutoComplPop_Behavior')
    let g:AutoComplPop_Behavior = {}
    let g:AutoComplPop_Behavior['php'] = []
    call add(g:AutoComplPop_Behavior['php'], {
            \ 'command' : "\<C-x>\<C-o>",
            \ 'pattern' : printf('\(->\|::\|\$\)\k\{%d,}$', 0),
            \ 'repeat' : 0,
            \})
endif
set runtimepath+=$HOME/.vim/vim-php-manual
autocmd BufNewFile,Bufread *.module,*.inc,*.php set keywordprg="help"


"以下是相关neocomplcache相关配置
"
"自动启动neocomplcache的命令： 
let g:neocomplcache_enable_at_startup = 1

"类似于AutoComplPop用法
let g:neocomplcache_enable_auto_select = 1

"禁止AutoComplPop
"let g:NeoComplCache_DisableAutoComplete = 1

"通过C-X,C-U打开匹配列表
"let g:SuerTabDefaultCompletionType = '<C-X><C-U>'


" neocompcache匹配字典
" 可以添加更多字典
" 比如css javascript 
let g:neocomplcache_dictionary_filetype_lists = { 
    \ 'default' : '', 
    \ 'php' : $HOME.'/.vim/php_funclist.txt'
\ }

"<CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"<TAB>: completion. NO USE with snipmate
"取消 <TAB> 的相关映射
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"<C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-Y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"inoremap <expr><Enter>  pumvisible() ? neocomplcache#close_popup()."\<C-n>" : "\<Enter>"
"赋予 <Enter> <C-Y> 的功能, <C-Y> 的功能是选择选项之后关闭弹出框
inoremap <expr><Enter>  pumvisible() ? "\<C-Y>" : "\<Enter>"

