call plug#begin('~/.config/nvim/plugins')
  Plug 'junegunn/goyo.vim'

  Plug 'tpope/vim-surround'

  Plug 'plasticboy/vim-markdown'

  Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " crazy python syntax

  Plug 'mg979/vim-visual-multi', {'branch': 'test'}

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'vimwiki/vimwiki'
call plug#end()
