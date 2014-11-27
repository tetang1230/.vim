set hlsearch
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set cindent
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set nu
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
if &term=="xterm"
set t_Co=8
set t_Sb=^[[4%dm
set t_Sf=^[[3%dm
endif
let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
"set tags="/home/chester/.vim/tags"
map <F2> :NERDTreeToggle<CR>
map <F3> :TlistToggle<CR>
map <F4> t :NERDTreeMirror<CR>
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

