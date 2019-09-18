runtime plugins.vim

runtime base.vim

runtime airline.vim
runtime cursors.vim
runtime goyo.vim
runtime markdown.vim
runtime surround.vim

runtime comfortable_motion.vim

" vimwiki/vimwiki
nmap <Leader>d <Plug>VimwikiDiaryIndex
nmap <Leader>t <Plug>VimwikiMakeDiaryNote
nmap <Leader>md <Plug>VimwikiDiaryGenerateLinks
let g:vimwiki_global_ext=0
let g:vimwiki_list = [{'path': '~/wiki/', 'syntax': 'markdown', 'ext': '.md'}]
