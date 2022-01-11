"mac
"1) default: capslock - 中英输入法切换 shift - 大写
"2) sogoupinyin: shift - 中英文切换 | 按住shift大写
"   系统设置-键盘-修饰键 ESC->CapsLock
"Ref: https://github.com/theniceboy/vimrc-example/blob/master/vimrc
"
" ----------------------------------------
" the following is about map-key
"使用vim自己的键盘模式,而不是兼容vi的模式
set nocompatible
"使vim识别不同文件
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
":messages能看到一些报错信息

let mapleader=' '
inoremap jj <ESC>
noremap H ^
noremap L $

"J 把当前行与下一行连接在一起
"K 用于查看处于光标之下的那个单词的手册页
noremap J 5j
noremap K 5k
noremap D J

"s - 删除光标所在字符并进入insert模式
"S - 删除整行并进入insert模式
"Q - 进入Ex mode, http://yyq123.blogspot.com/2019/08/vim-ex-mode.html
" ZZ = :wq!
map s <nop>
map S :w<CR> "<CR>回车, 大写S保存
map Q :q<CR>

":split 上下分屏
":vsplit 左右分屏 光标在左  先执行set splitright 可以使光标在右
map sh :set nosplitright<CR>:vsplit<CR>
map sl :set splitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>
" ctrl+w+h/j/k/l 分屏之间移动光标 
map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l
" 调整当前分屏大小
map <leader><up> :res +5<CR>
map <leader><down> :res -5<CR>
map <leader><left> :vertical resize-5<CR>
map <leader><right> :vertical resize+5<CR>

":tabe 新标签页
":tabe <file-path> 新标签页打开对应文件
":file <file-path> 未命名的文件保存到对应路径
":+tabnext :-tabnext +右/-左切换标签页 
map tn :tabe<CR>
map tl :+tabnext<CR>
map th :-tabnext<CR>
" ----------------------------------------

" ---------------------------------------- the following is about settings.
" vim 可以使用鼠标
set mouse=a
"connection to the system clipboard
set clipboard+=unnamedplus 
set encoding=utf-8
set nu
"相对行号 set relativenumber | set norelativenumber
set scrolloff=8
set wildmenu
colorscheme gruvbox

" setting for search
set hlsearch " 搜索高亮
set incsearch " 边输入搜索边高亮
set ignorecase
"syntax on " 自动语法高亮
noremap <leader><CR> :noh<CR>

" setting for python
set viminfo='1000
set helplang=cn "中文帮助文档(前提是下了中文包)
syntax enable
set guifont=Consolas:h12:cANSI"英文字体
set guifontwide=SimSun-ExtB:h12:cGB2312
set tabstop=4"表示Tab代表4个空格的宽度
set expandtab"表示Tab自动转换成空格
set autoindent"表示换行后自动缩进
set autoread " 当文件在外部被修改时，自动重新读取
set history=400"vim记住的历史操作的数量，默认的是20
set confirm"处理未保存或者只读文件时,给出提示
set smartindent"智能对齐
set shiftwidth=4


" 插件----------------------------------------
" the following is about vim-plug github/vim-plug vim插件管理
" Unfortunately, the company MAC cannot use git clone. Thus, install plugin manually. https://blog.csdn.net/cuml0912/article/details/107389119 (~/.vim/pack/vendor/start/)
"call plug#begin('~/.vim/plugged')
"Plug 'vim-airline/vim-airline'
"call plug#end()

if has('nvim')
    "ncm2 for autocomplete
    "缓存
    autocmd BufEnter * call ncm2#enable_for_buffer()
    " IMPORTANT: :help Ncm2PopupOpen for more information
    " 补全模式 https://zhuanlan.zhihu.com/p/106070272
    set completeopt=noinsert,menuone "noselect
    set shortmess+=c
    " 延迟弹窗,这样提示更加流畅
    let ncm2#popup_delay = 5
    "输入几个字母开始提醒:[[最小优先级,最小长度]]
    "如果是输入的是[[1,3],[7,2]],那么优先级在1-6之间,会在输入3个字符弹出,如果大于等于7,则2个字符弹出----优先级概念请参考文档中 ncm2-priority 
    let ncm2#complete_length = [[1, 1]]
    "模糊匹配模式,详情请输入:help ncm2查看相关文档
    let g:ncm2#matcher = 'substrfuzzy'
    "使用tab键向下选择弹框菜单
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>" 
    "使用shift+tab键向上选择弹窗菜单
    "inoremap <expr> <S> pumvisible() ? "\<C-p>" : "\<S>"


    "python path for neovim
    let g:python_host_prog  = '/Users/jh/miniconda3/envs/py27/bin/python'
    let g:python3_host_prog = '/Users/jh/miniconda3/bin/python'
    "python_verison for ncm2-jedi
    let g:ncm2_jedi#python_version = 2

    "NERDTree
    ":NERDTree
    "t 新标签页打开文件，i横向分割/s纵向分割在窗口打开文件 
    "m 示文件系统菜单（添加、删除、移动操作, 执行命令）
    "NERDTree快捷键配置 | git状态显示配置等

    "markdown-preview.nvim
    "github下载zip文件解压，放在~/.vim/pack/vendor/start/ 下，进入插件目录，执行:call mkdp#util#install(), git无法下载的自己下载放入当前文件夹
    " ===
    " === MarkdownPreview
    " ===
    "map-keys. 只有文件类型md才生效
    "打开、关闭markdownpreview
    autocmd Filetype markdown noremap ,m :MarkdownPreview<CR>
    autocmd Filetype markdown noremap ,ms :MarkdownPreviewStop<CR>
    "粗体快捷键
    autocmd Filetype markdown noremap ,b i****<ESC>hi
    autocmd Filetype markdown noremap ,k i[]()<ESC>2hi
    "链接快捷键
    "
    let g:mkdp_auto_start = 0
    let g:mkdp_auto_close = 1
    let g:mkdp_refresh_slow = 0
    let g:mkdp_command_for_global = 0
    let g:mkdp_open_to_the_world = 0
    let g:mkdp_open_ip = ''
    let g:mkdp_browser = '' "指定浏览器，''为系统默认浏览器
    let g:mkdp_browserfunc = '' 
    let g:mkdp_echo_preview_url = 0
    let g:mkdp_preview_options = {
        \ 'mkit': {},
        \ 'katex': {},
        \ 'uml': {},
        \ 'maid': {},
        \ 'disable_sync_scroll': 0,
        \ 'sync_scroll_type': 'middle',
        \ 'hide_yaml_meta': 1
        \ }
    let g:mkdp_markdown_css = ''
    let g:mkdp_highlight_css = ''
    let g:mkdp_port = ''
    let g:mkdp_page_title = '「${name}」'

endif
