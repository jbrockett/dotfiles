" Basic settings
set encoding=UTF-8
set number                        " Show line numbers
set relativenumber
set ruler                         " Show line and column number
set noerrorbells                  " No beeps
set noswapfile                    " Don't use swapfile
set nobackup                      " Don't create annoying backup files
set splitright                    " Split vertical windows right to the current windows
set splitbelow                    " Split horizontal windows below to the current windows
set nocursorcolumn                " speed up syntax highlighting
set nocursorline
set clipboard^=unnamed            " Integrate vim with mac clipboard
set clipboard^=unnamedplus        " http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy

" Whitespace settings
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
"set nowrap                       " don't wrap lines

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

" Status Bar
if has("statusline") && !&cp
    set laststatus=2              " always show the status bar

    " Start the status line
    set statusline=%f\ %m\ %r
    set statusline+=Line:%l/%L[%p%%]
    set statusline+=Col:%v
    set statusline+=Buf:#%n
    set statusline+=[%b][0x%B]
endif

" Mappings - Do not use same line comments, as it causes issues with the mappings
" Map jk to esc as some keyboards lack the esc key now :(
imap jk <Esc>
" open nerdtree with ctrl-n
nnoremap <C-n> :NERDTreeToggle<cr>
" handle wrapped lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" save as sudo
cmap w!! w !sudo tee % >/dev/null