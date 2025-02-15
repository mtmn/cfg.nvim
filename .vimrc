exe "set runtimepath=~/.vim," . $VIMRUNTIME

filetype plugin on
syntax on

set autoindent
set backspace=indent,eol,start
set backupcopy=yes
set cursorline
set formatoptions=qrn
set hlsearch
set ignorecase
set incsearch
set linebreak
set nofoldenable
set nojoinspaces
set nowrap
set number
set relativenumber
set scrolloff=15
set shiftround
set shiftwidth=4
set shortmess=aoOtI
set smartcase
set synmaxcol=1000
set textwidth=79
set viminfo='20,<1000,s1000
set ruler
set mouse=""

" this is not very portable as we should always fallback to `nightly`, but at
" the time of this implementation RLS was not yet added to the build.

let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <silent> <leader>n :setlocal paste<CR>
nnoremap <silent> <leader>q :%s/\s\+$//e<CR><C-o>
nnoremap <silent> / :let @/ = ""<CR>:set hlsearch<CR>/
nnoremap <silent> H :set hlsearch!<CR>

highlight TrailingWhitespace ctermbg=black
call matchadd('TrailingWhitespace', '\s\+$')

highlight Normal ctermbg=none
highlight MatchParen ctermbg=darkmagenta ctermfg=black

command FixFile :set fileencoding=utf-8 fileformat=unix nobomb | %s/\r$//

for directory in ["backup", "swap", "undo"]
  silent! call mkdir($HOME . "/.vim/" . directory, "p")
endfor
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set undofile

" Do not enter ex mode when I fat finger q with shift pressed
nnoremap Q <nop>

" Do not show me man pages when I'm bad at pressing k
nnoremap K <nop>

" I'm very bad at pressing things
" nmap <F1> <nop>
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>


" Do not show command history window when :q gets entered in the wrong order
map q: :q

" When joining, do the right thing to join up function definitions
vnoremap J J:s/( /(/g<CR>:s/,)/)/g<CR>

" Quickly move around (and into) command mode
" imap jk <Esc>
" imap kj <Esc>:
for keymode in ['n', 'v']
  exec keymode . 'noremap ; :'
  exec keymode . 'noremap : ;'
endfor

" Do not copy to default register on delete/change, use <Leader> prefixed
" version to use regular delete/change
for key in ['d', 'D', 'c', 'C']
  for keymode in ['n', 'v']
    exe keymode . 'noremap <Leader>' . key . ' ' . key
    exe keymode . 'noremap ' . key . ' "_' . key
  endfor
endfor

" gV to highlight previously inserted text
nnoremap gV `[v`]

nnoremap <silent> <Leader>y :w! ~/.vim/xfer<CR>:w !xclip<CR><CR>:w !xclip -sel clip<CR><CR>'
vnoremap <silent> <Leader>y :w! ~/.vim/xfer<CR>gv:w !xclip<CR><CR>gv:w !xclip -sel clip<CR><CR>'

" Automatically move to end of paste
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" I only really use a single mark, so M to set it, m to retrieve it
nnoremap M mA
nnoremap m 'A

augroup filetype_settings
  " Clear this autocmd group so that the settings won't get loaded over and
  " over again
  autocmd!

  autocmd BufNewFile,BufReadPost *.cconf,*.cinc,TARGETS setlocal filetype=python
  autocmd BufNewFile,BufReadPost *.lalrpop setlocal filetype=rust
  autocmd BufNewFile,BufReadPost *.def setlocal filetype=c
  autocmd BufNewFile,BufReadPost Jenkinsfile,Jenkinsfile.*,Jenkinsfile-* setlocal filetype=groovy
  autocmd BufNewFile,BufReadPost *.bb setlocal filetype=clojure

  for filetype in ['yaml', 'sql', 'ruby', 'html', 'css', 'xml', 'vim']
    exe 'autocmd FileType ' . filetype . ' setlocal sw=2 sts=2 ts=2'
  endfor

  for filetype in ['gitcommit']
    exe 'autocmd FileType ' . filetype . ' setlocal joinspaces'
  endfor

  for filetype in ['gitcommit']
    exe 'autocmd FileType ' . filetype . ' setlocal tw=72'
  endfor

  autocmd BufRead,BufNewFile */linux-mmots/*.c,*/linux-mmots/*.h setlocal textwidth=80
  autocmd BufRead,BufNewFile */systemd/*.c,*/systemd/*.h setlocal textwidth=109

augroup END

nnoremap <C-l> <C-l>zz

augroup modechange_settings
  autocmd!

  " Clear search context when entering insert mode, which implicitly stops the
  " highlighting of whatever was searched for with hlsearch on. It should also
  " not be persisted between sessions.
  autocmd InsertEnter * let @/ = ''
  autocmd BufReadPre,FileReadPre * let @/ = ''

  autocmd InsertLeave * setlocal nopaste

  " Jump to last position in file
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " Balance splits on window resize
  autocmd VimResized * wincmd =
augroup END


" Do not overwrite default register when pasting in visual mode
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Stuff to make working with unwrapped text easier
for key in ['k', 'j']
  exe 'noremap <buffer> <silent> <expr> ' . key . ' v:count ? ''' . key . ''' : ''g' . key . ''''
  exe 'onoremap <silent> <expr> ' . key . ' v:count ? ''' . key . ''' : ''g' . key . ''''
endfor
nnoremap <silent> <Leader>E :set wrap<CR>:setlocal formatoptions-=t<CR>:set textwidth=0<CR>
nnoremap <silent> <Leader>e :set nowrap<CR>:setlocal formatoptions+=t<CR>:set textwidth=79<CR>
