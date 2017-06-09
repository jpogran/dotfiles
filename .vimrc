"execute pathogen#infect()

set nocompatible          " get rid of Vi compatibility mode. SET FIRST!

filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]

set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).
colorscheme desert        " set colorscheme

set number                " show line numbers
set laststatus=2          " last window always has a statusline
filetype indent on        " activates indenting for files
set nohlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set autoindent            " auto-indent

set showmatch
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
set visualbell

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2

"set guifont=Envy\ Code\ R:h13
set pastetoggle=<F2>
