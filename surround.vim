vmap ( S)
vmap ' S'
vmap " S"
vmap { S}

" FIXME vim has [[ and other [* maps, so this lags
vmap [ S]

" markdown
vmap _ S_
autocmd FileType vimwiki,markdown let g:surround_95 = "[\r]()"

" latex
vmap ` S`
autocmd FileType latex let b:surround_96 = "``\r''"
autocmd FileType latex vmap $ S$
autocmd FileType latex vmap \| S\|

