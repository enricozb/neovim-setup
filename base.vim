" line numbers
set number

" share os clipboard
set clipboard=unnamed
set clipboard+=unnamedplus

" tabs
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" clear find highlighting
nnoremap <esc> :noh<return><esc>

" colors
set t_Co=256
colorscheme pablo

" todo/fixme colors
highlight todo ctermfg=red ctermbg=NONE

" navigation (force learn good commands)
noremap gk gg
noremap gj G
noremap gh 0
noremap gl $
map gg <Nop>

" TODO: consider changing this (0 is a nice single key...)
map 0  <Nop>
map $  <Nop>

" disable recording
map q <Nop>

" trailing whitespace (highlight and remove)
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfunction

nnoremap <c-s> :call TrimWhitespace()<cr>:retab<cr>:w<cr>
inoremap <c-s> <esc>:call TrimWhitespace()<cr>:retab<cr>:w<cr>

" 80 char limit
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" spelling
"" turn it on on tex/md/txt files
autocmd BufNewFile,BufRead *.tex setlocal spell
autocmd BufNewFile,BufRead *.md setlocal spell
autocmd BufNewFile,BufRead *.txt setlocal spell

"" us US spelling
set spelllang=en_us

"" specific highlighting styles
hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi SpellBad cterm=underline ctermfg=red
hi SpellCap cterm=underline ctermfg=blue
hi SpellLocal cterm=underline ctermfg=green

" see tabs
highlight SpecialKey ctermfg=4
set listchars=tab:>—
set list
