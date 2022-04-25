fun functions#MarkRange()
    for level in range(1, 9)
        execute 'nnoremap <leader>H' . level . ' :call functions#MarkHead(' . level . ')<cr>'
    endfor
endf

fun functions#MarkHead(level)
    normal! mm
    execute ':normal! ' . a:level . 'I#a `m' . a:level . 'll'
endf

" fun functions#AplSetup()
" 	nunmap <leader>r
" 	nunmap <leader>R
" 	nnoremap <leader>r :VtrSendLinesToRunner<cr>
" 	nnoremap <leader>R :VtrSendFile<cr>
" endf
