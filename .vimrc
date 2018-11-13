syntax on

" Disable vi-compatibility mode
set nocompatible
" Keep 100 lines of command line history
set history=100
" More undo
set undolevels=500
" Default encoding
set encoding=utf-8 nobomb
" Highlights search
set hlsearch
" Searches for text as entered
set incsearch
" Make search/replace have global flag by default
set gdefault
" Always show statusline
set laststatus=2
" Show current mode
set showmode
" Show filename in the titlebar
set title
" Don't show listchars
set list
" Show trailing spaces as dots
set listchars=tab:>-,trail:·,nbsp:_
" Allow hiding of unsaved buffers
set hidden
" Show regular numbers
set number
set numberwidth=5
" Start scrolling before the edge of window
set scrolloff=5
" Don't show command in the last line of the screen
set noshowcmd
" No swap
set noswapfile
" No Backup files
set nobackup
" Show the ruler
set ruler
" Highlight matching paren/brace/bracket
set showmatch
" Auto insert extra indent level in certain cases
set smartindent
" Prevents tab/space issues
set smarttab
" Copy indent from previous line
set autoindent
" Optimize for fast terminal connections
set ttyfast
" Enhance command-line completion
set wildmenu
set noerrorbells

" Formatting settings
set tabstop=4
set shiftwidth=4

" Filetype specific indent
filetype indent on
" Filetype specific plugins
filetype plugin on

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Shortcuts
map <F2> :NERDTreeToggle<CR>
map <F3> :NERTTreeFind<CR>

" Colors
colorscheme peachpuff
