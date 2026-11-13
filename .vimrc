" ============================================================
"  ~/.vimrc  导航
" ------------------------------------------------------------
"  [01] 模块开关          g:vimrc_*   ← 改这里开关功能
"  [02] 基础兼容          nocompatible / syntax / debian
"  [03] 编辑器外观        number / gruvbox / 终端色 / 高亮
"                         gruvbox 关闭时恢复 default 主题
"  [04] 缩进与搜索        expandtab / hlsearch / smartcase
"  [05] 全局键位          <Leader>=Space / 窗口 / 缓存区
"  [06] 插件管理          Vundle（按开关条件声明）
"  [07] 文件树            NERDTree
"  [08] 代码大纲          tags / tagbar
"  [09] 补全跳转          coc.nvim  gd/gr/gi/gy/gh/fi
"  [09a] cscope           cscope 查询窗口复用 coc list
"  [09b] 历史 YCM         暂不使用，改用 coc.nvim
"  [10] Git               fugitive / gv
"  [11] Markdown          预览 Markdown 文件
"  [12] 文件管理器        Vifm/Ranger
"  [13] 状态栏            Airline
"  [14] 屏保              matrix-screensaver
"  [15] autocmd           quickfix / list / nerdtree 光标行
"  [16] 系统配置          /etc/vim/vimrc.local
" ============================================================

" ============================================================
" [01] 模块开关：1=开启 0=关闭
"      同时控制 Vundle Plugin 声明与对应配置块
" ============================================================
let g:vimrc_enable_nerdtree        = 1
let g:vimrc_enable_tagbar          = 1
let g:vimrc_enable_fzf             = 1
let g:vimrc_enable_vifm            = 1
let g:vimrc_enable_ranger          = 1
let g:vimrc_enable_coc             = 1
let g:vimrc_enable_cscope          = 1
let g:vimrc_enable_markdown        = 1
let g:vimrc_enable_git             = 1   " fugitive + gv
let g:vimrc_enable_airline         = 1
let g:vimrc_enable_matrix          = 0   " 屏保插件
let g:vimrc_enable_gruvbox         = 1   " 1=gruvbox 主题；0=默认主题
let g:vimrc_enable_terminal_colors = 1   " 终端 16 色（依赖 vimrc_enable_gruvbox）
let g:vimrc_enable_vscode          = 0
let g:vimrc_enable_indentLine      = 1


" ============================================================
" [02] 基础兼容
" ============================================================
" $VIMRUNTIME refers to the versioned system directory where Vim stores its
" system runtime files -- /usr/share/vim/vim<version>.
"
" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
"
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" Glet g:skip_defaults_vim = 1
"
" If you would rather _use_ default.vim's settings, but have the system or
" user vimrc override its settings, then uncomment the line below.
" source $VIMRUNTIME/defaults.vim

" All Debian-specific settings are defined in $VIMRUNTIME/debian.vim and
" sourced by the call to :runtime you can find below.  If you wish to change
" any of those settings, you should do it in this file or
" /etc/vim/vimrc.local, since debian.vim will be overwritten everytime an
" upgrade of the vim packages is performed. It is recommended to make changes
" after sourcing debian.vim so your settings take precedence.

runtime! debian.vim

set nocompatible              " 禁用Vi兼容模式
set timeoutlen=500            " 单位ms

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes
" numerous options, so any other options should be set AFTER changing
" 'compatible'.
" set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif


" ============================================================
" [03] 编辑器外观
" ============================================================
set number
set showmode
set cursorline

" 主题色调整--使用经典的 gruvbox
if get(g:, 'vimrc_enable_gruvbox', 1)
  set termguicolors " 真彩色支持

  " If using a dark background within the editing area and syntax highlighting
  " turn on this option as well
  set background=dark
  let g:gruvbox_contrast_dark = 'soft'
  "let g:gruvbox_contrast_light = 'medium'
  colorscheme gruvbox " 应用主题

  " 设置 Vim 内置 terminal 的 16 色（gruvbox dark soft 配色）
  " 参考 gruvbox.vim 里三档背景是：
  " dark0_hard = #1d2021
  " dark0      = #282828
  " dark0_soft = #32302f
  " 标准色 (0-3): dark0, bright_red, bright_green, bright_yellow
  " 标准色 (4-7): bright_blue, bright_purple, bright_aqua, light4
  " 亮色 (8-11) : gray, bright_red, bright_green, bright_yellow
  " 亮色 (12-15): bright_blue, bright_purple, bright_aqua, light0
  if get(g:, 'vimrc_enable_terminal_colors', 1)
    let g:terminal_ansi_colors = [
      \ '#32302f', '#cc241d', '#98971a', '#d79921',
      \ '#458588', '#b16286', '#689d6a', '#a89984',
      \ '#928374', '#fb4934', '#b8bb26', '#fabd2f',
      \ '#83a598', '#d3869b', '#8ec07c', '#f2e5bc'
      \ ]
  endif
else
  " 恢复 vim 默认主题
  colorscheme default
  set background=dark
endif

" 语法加亮微调
let g:c_space_errors = 1
let g:c_gnu = 1
let g:c_no_curly_error = 1

if 0
" !!! 如果设置了 colorscheme=gruvbox , 那么下列vim自己的主题不会生效
" 窗口分隔符颜色（根据终端背景色调整）
highlight VertSplit cterm=NONE ctermfg=NONE ctermbg=NONE guibg=#1e1e1e
highlight StatusLine term=NONE cterm=NONE ctermfg=NONE ctermbg=238 guifg=NONE guibg=NONE
highlight StatusLineNC term=NONE cterm=NONE ctermfg=NONE ctermbg=238 guifg=NONE guibg=NONE
highlight StatusLineTerm term=NONE cterm=NONE ctermfg=NONE ctermbg=238 guifg=NONE guibg=NONE
highlight StatusLineTermNC term=NONE cterm=NONE ctermfg=NONE ctermbg=238 guifg=NONE guibg=NONE
endif

if 0
" 如果不使用 airline , 使用原生状态栏功能, 简洁点
let &statusline = '%<%f   %{tagbar#currenttag("%s","")} %=%l:%c %p%%'
set laststatus=2
endif

if 0
" 如果不使用 airline , 使用原生状态栏功能, 简洁点
"白色 white 字体颜色调整
" 色号 │ 十六进制 │ 说明
" 15   │ #ffffff  │ 纯白（最亮）
" 255  │ #eeeeee  │ 近白
" 254  │ #e4e4e4  │ 亮白
highlight Normal guifg=#eeeeee ctermfg=255
endif


" ============================================================
" [04] 缩进与搜索
" ============================================================
set expandtab " 将制表符展开为空格
set autoindent
set shiftwidth=2
set tabstop=2
set hlsearch

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
" filetype plugin indent on
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)


" ============================================================
" [05] 全局键位映射
" ============================================================
" <Leader> 默认是反斜杆'\', 改成空格键
let mapleader = ' '
nnoremap <leader>q :q<CR>
"tnoremap <leader>q exit<CR> "直接使用会导致 Vifm 插件的 space + q 映射异常，无法退出
function! s:TermSpaceQ() abort
  " 按下时判断：vifm 的终端（插件已改名为 vifm: xxx）→ 退出
  if bufname('%') =~# '^vifm:'
    return ":q\<CR>"
  endif
  return "exit\<CR>"
endfunction
tnoremap <expr> <leader>q <SID>TermSpaceQ()

nnoremap <leader>w :w<CR>
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l
tnoremap <leader>h <c-w>h
tnoremap <leader>j <c-w>j
tnoremap <leader>k <c-w>k
tnoremap <leader>l <c-w>l

" Buffers
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
nnoremap <leader>fs :Files<CR>


" ============================================================
" [06] 插件管理（Vundle）
" ============================================================
filetype off " 必须
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

if get(g:, 'vimrc_enable_nerdtree', 1)
  Plugin 'preservim/nerdtree'
endif

if get(g:, 'vimrc_enable_tagbar', 1)
  Plugin 'preservim/tagbar'
endif

if get(g:, 'vimrc_enable_fzf', 1)
  Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plugin 'junegunn/fzf.vim'
endif

if get(g:, 'vimrc_enable_vifm', 1)
  Plugin 'vifm/vifm.vim'
endif

if get(g:, 'vimrc_enable_ranger', 1)
  Plugin 'iberianpig/ranger-explorer.vim'
endif

if get(g:, 'vimrc_enable_markdown', 1)
  Plugin 'iamcco/markdown-preview.nvim'
endif

if get(g:, 'vimrc_enable_matrix', 1)
  Plugin 'uguu-org/vim-matrix-screensaver'
endif

if get(g:, 'vimrc_enable_git', 1)
  Plugin 'tpope/vim-fugitive'
  Plugin 'junegunn/gv.vim'
endif

if get(g:, 'vimrc_enable_airline', 1)
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
endif

if get(g:, 'vimrc_enable_vscode')
  Plugin 'Mofiqul/vscode.nvim'
  colorscheme vscode
  set background=light
endif

if get(g:, 'vimrc_enable_indentLine')
  Plugin 'Yggdroot/indentLine'
endif

call vundle#end() " 必须

filetype plugin indent on " 启用文件类型检测,注意需要放在vundle之后!


" ============================================================
" [07] 文件树：NERDTree
" ============================================================
if get(g:, 'vimrc_enable_nerdtree', 1)
  " 符号配置
  let g:NERDTreeDirArrowExpandable = '+'
  let g:NERDTreeDirArrowCollapsible = '-'
  " 显示隐藏文件
  let NERDTreeShowHidden = 1
  let NERDTreeMinimalUI = 1
  "let g:NERDTreeHijackNetrw = 0  " 禁止 NERDTree 劫持 netrw
  nnoremap <leader>8 :NERDTreeFind<CR> " 让光标直接落在当前文件上
endif


" ============================================================
" [08] 代码大纲：tags + tagbar
" ============================================================
" 配置 tags 查找路径，从当前目录递归往父目录查找
set tags+=./tags,tags;

if get(g:, 'vimrc_enable_tagbar', 1)
  "配置 tagbar 插件
  let g:tagbar_ctags_bin='/usr/bin/ctags'
  "let g:tagbar_width=30 "窗口宽度设置为 30
  "let g:tagbar_left=1 "设置在 vim 左边显示

  "关闭 tagbar 的原型提示，与空格Leader冲突
  let g:tagbar_map_showproto = ''
  nnoremap <silent> <leader>9 :TagbarToggle<CR>
endif


" ============================================================
" [09] 补全与跳转：coc.nvim
" ============================================================
" 特别注意 coc.nvim 会使每个新开的 vim 都会拉一个 clangd lsp 进程,
" chromium项目一个此进程占用大概 10G 以上内存，多开几个 vim 访问 C++
" 代码就会导致内存爆炸!!!
" coc 其他配置路径在 ~/.vim/coc-settings.json

if get(g:, 'vimrc_enable_coc', 1)
  " 禁止 coc 自动启动
  "let g:coc_start_at_startup = 0

  " coc.nvim 基本设置
  set updatetime=300

  " Tab 键触发补全
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  " 回车确认补全
  inoremap <silent><expr> <CR>
        \ coc#pum#visible() ? coc#pum#confirm() :
        \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " coc.nvim 快捷键配置（替代 YCM）默认异步Action
  "nmap <silent> gh <Plug>(coc-declaration)
  "nmap <silent> gd <Plug>(coc-definition)
  "nmap <silent> gt <Plug>(coc-definition)
  "nmap <silent> gr <Plug>(coc-references)
  "nmap <silent> gi <Plug>(coc-implementation)
  "nmap <silent> gy <Plug>(coc-type-definition)
  "nmap <silent> fi <Plug>(coc-fix)
  "nmap <silent> ci :call CocActionAsync('showIncomingCalls')<CR>
  "nmap <silent> co :call CocActionAsync('showOutgoingCalls')<CR>
  "nmap <silent> cs :call CocActionAsync('showSuperTypes')<CR>
  "nmap <silent> cb :call CocActionAsync('showSubTypes')<CR>
  "nnoremap <silent> <leader>r :CocListResume<CR>

  " coc.nvim 快捷键配置（替代 YCM）同步Action
  nmap <silent> gh :call CocAction('jumpDeclaration')<CR>
  nmap <silent> gd :call CocAction('jumpDefinition')<CR>
  nmap <silent> gt :call CocAction('jumpDefinition')<CR>
  nmap <silent> gr :call CocAction('jumpReferences')<CR>
  nmap <silent> gi :call CocAction('jumpImplementation')<CR>
  nmap <silent> gy :call CocAction('jumpTypeDefinition')<CR>
  nmap <silent> fi :call CocAction('quickfixes')<CR>
  nmap <silent> ci :call CocAction('showIncomingCalls')<CR>
  nmap <silent> co :call CocAction('showOutgoingCalls')<CR>
  nmap <silent> cs :call CocAction('showSuperTypes')<CR>
  nmap <silent> cb :call CocAction('showSubTypes')<CR>

  nnoremap <silent> <leader>r :CocListResume<CR>

  " coctree 会动态映射自己的 space ，需要延时200ms取消掉
  autocmd FileType coctree call timer_start(200, {->
      \ execute('silent! nunmap <buffer> <Space>') })
  autocmd FileType coctree setlocal cursorline " quickfix 窗口当前行高亮
  autocmd FileType coctree setlocal winhighlight=CursorLine:CocListLine " 光标行映射为 CocListLine

  autocmd FileType list setlocal cursorline " quickfix 窗口当前行高亮
  autocmd FileType list setlocal winhighlight=CursorLine:CocListLine " 光标行映射为 CocListLine

  autocmd FileType nerdtree setlocal winhighlight=CursorLine:CocListLine " nerdtree 光标行也用下划线
  autocmd FileType tagbar setlocal cursorline winhighlight=CursorLine:CocListLine " tagbar 光标行下划线

  hi CocListLine cterm=underline gui=underline " 光标行：下划线
  hi CocLocationLine guibg=NONE ctermbg=NONE " 清掉所有行的背景色块

  " coc list:///location 引用列表窗口左侧Vim 的 sign 列(signcolumn)背景色设置为透明
  " 另外按空格打红色 * 标记符号是 CocSelect
  autocmd VimEnter * call timer_start(100, {-> execute('hi SignColumn cterm=NONE ctermbg=NONE guibg=NONE')})
endif


" ============================================================
"  [09a] cscope 查询窗口复用 coc list
" ============================================================
if get(g:, 'vimrc_enable_coc', 1)
  if get(g:, 'vimrc_enable_cscope', 1)
    " ===== cscope 基础（前置条件 1、2）=====
    if has("cscope")
      set cscopequickfix=s-,c-,d-,i-,t-,e-,a-   " 结果进 quickfix（前置条件 2）
    endif

    function! s:CscopeToCocList(qtype) abort
      execute 'cs find ' . a:qtype . ' ' . expand('<cword>')
      execute 'CocList --normal quickfix'
    endfunction

    nnoremap <silent> FS :call <SID>CscopeToCocList('s')<CR>  " 找引用
    nnoremap <silent> FG :call <SID>CscopeToCocList('g')<CR>  " 找定义
    nnoremap <silent> FC :call <SID>CscopeToCocList('c')<CR>  " 找调用者
    nnoremap <silent> FD :call <SID>CscopeToCocList('d')<CR>  " 找被调用函数
    nnoremap <silent> FT :call <SID>CscopeToCocList('t')<CR>  " 找文本
  endif " vimrc_enable_cscope
endif " vimrc_enable_coc


" ============================================================
" [09b] YCM 配置（当前是禁用，改用上面的 coc.nvim)
" ============================================================
" 特别注意 YouCompleteMe 会使每个新开的 vim 都会拉一个 clangd lsp 进程,
" chromium项目一个此进程占用大概 10G 以上内存，多开几个 vim 访问 C++
" 代码就会导致内存爆炸!!!
" 禁用 ycm
let g:loaded_youcompleteme = 1

if 0 " 关闭
" 设置 ycmd 空闲自杀时间（秒），例如 600秒=10分钟
let g:ycm_server_idle_suicide_seconds = 600
"下面功能需要 ycm 配合安装 clangd 语义分析器
nnoremap fi :YcmCompleter FixIt<CR>
nnoremap gt :YcmCompleter GoTo<CR>
nnoremap gd :YcmCompleter GoToDefinition<CR>
nnoremap gh :YcmCompleter GoToDeclaration<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>

let g:ycm_auto_hover = ''
let g:ycm_complete_in_comments = 1
let g:ycm_filetype_whitelist = {
      \ 'c': 1,
      \ 'cpp': 1,
      \ 'cc': 1,
      \ 'python': 1,
      \ 'vim': 1,
      \ 'sh': 1,
      \ 'zsh': 1,
      \ 'java': 1,
      \ }
let g:ycm_show_diagnostics_ui = 0
endif


" ============================================================
" [10] Git：fugitive + gv
" ============================================================
if get(g:, 'vimrc_enable_git', 1)
  " 配置可在此扩展
endif


" ============================================================
" [11] Markdown 预览
" ============================================================
if get(g:, 'vimrc_enable_markdown', 1)
  " 配置可在此扩展
endif


" ============================================================
" [12] 文件管理器：vifm / ranger
" ============================================================
if get(g:, 'vimrc_enable_vifm', 1)
  let g:vifm_embed_term = 1   " 使用嵌入式终端
  let g:vifm_embed_split = 1  " 让 vifm 在分割窗口中打开
  nnoremap <leader>f :Vifm<CR>
endif

if get(g:, 'vimrc_enable_ranger', 1)
  " 配置可在此扩展
endif


" ============================================================
" [13] 状态栏：airline
" ============================================================
if get(g:, 'vimrc_enable_airline', 1)
  set laststatus=2
  "let g:airline_disable_statusline = 1 " 禁用整体 airline
  " 自定义状态栏显示内容
  "let g:airline_section_a = ''  " 清空模式显示
  let g:airline_section_b = '%f'  " 只显示文件名
  let g:airline_section_c = '%{tagbar#currenttag("%s","")}' " 显示当前函数名
  let g:airline_section_x = ''  " 清空文件类型显示
  let g:airline_section_y = ''  " 清空编码显示
  let g:airline_section_z = '%l:%c %p%%'  " 显示行:列 百分比
  "let g:airline_theme = 'base16_gruvbox_dark_hard'
  let g:airline_theme = 'base16_gruvbox_dark_soft'
  "let g:airline_theme = 'base16_gruvbox_light_medium'
  let g:airline_inactive_collapse = 0 " 禁止非活动窗口折叠
  let g:airline#extensions#default#section_truncate_width = {} " 设置为空字典，禁用截断
  "let g:airline#extensions#whitespace#enabled=0 " 关闭空白符检测
  let g:airline#extensions#term#enabled = 0 " 禁用终端扩展(非活动时反色变黑背景不好看)，让它使用普通窗口的配置
  "let g:airline#extensions#whitespace#enabled=0 " 关闭空白符检测
  let g:airline#extensions#tabline#enabled = 1 " 在顶部启用缓存区列表
  let g:airline#extensions#tabline#buffer_nr_show = 1 " 显示缓存区编号
  let g:airline#extensions#tabline#show_tab_nr = 0 " 关闭显示标签页编号
  let g:airline_skip_empty_sections = 1 " 跳过空 section, 避免多余的箭头色块
  " 提供 Powerline 箭头符号的形状
  " --> 需要预先安装对应字体: 比如 Source Code Pro / Fira Code 等
  "  git clone https://github.com/powerline/fonts.git
  "  cd fonts/
  "  ./install.sh
  "  然后在终端设置该类型字体
  "  另外需要重点说明：Ubuntu 可能需要将系统语言设置为英语!否则箭头与字体单元格高度还是错位！
  "  原因：Ubuntu21 之后的系统终端行间距过大，VTE在一次更新后自作聪明，从你的系统语言字体里获
  "  取行高，如果你把系统语言设置成中文，一般来讲这个字体是Noto CJK，它的行高很大，但这只是因
  "  为中文的行高本来就比英文大，很多TUI程序的显示都会受到影响；如果你是Powerline的用户，影响
  "  就更大了。必须要把系统语言整个更改成英文，才能让终端显示恢复正常
  "  详情见原文: https://2o181o28.github.io/2021/09/25/Ubuntu21.10%E8%AF%95%E7%94%A8%E4%BD%93%E9%AA%8C/
  "  注：kitty 不受影响
  let g:airline_powerline_fonts = 1
endif


" ============================================================
" [14] 屏保：matrix-screensaver
" ============================================================
if get(g:, 'vimrc_enable_matrix', 1)
  " 配置可在此扩展
endif


" ============================================================
" [15] 其他 autocmd
" ============================================================
autocmd FileType qf setlocal cursorline " quickfix 窗口当前行高亮
autocmd FileType fugitiveblame setlocal cursorline " quickfix 窗口当前行高亮


" ============================================================
" [16] 系统配置
" ============================================================
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
