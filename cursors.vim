" multi-cursors
let g:VM_case_setting = "sensitive"
let g:VM_maps = {}
let g:VM_maps["Find Under"]         = "<c-d>"           " replace c-n
let g:VM_maps["Find Subword Under"] = "<c-d>"           " replace visual c-n
let g:VM_maps["Remove Last Region"] = "<c-u>"
let g:VM_maps["Undo"] = "u"
let g:VM_maps["Redo"] = "<c-r>"
let g:VM_maps["Skip Region"] = "<c-n>"

" TODO: can't figure out how to get these two to work...
" let g:VM_maps["Seek Prev"] = "<c-j>"
" let g:VM_maps["Seek Next"] = "<c-n>"

let g:VM_Selection_hl     = 'Visual'
let g:VM_Mono_Cursor_hl   = 'Visual'
let g:VM_Ins_Mode_hl      = 'Visual'
let g:VM_Normal_Cursor_hl = 'Visual'
