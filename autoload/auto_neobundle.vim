" coding: utf-8

if exists("g:auto_neobundle_loaded")
    finish
endif
let g:auto_neobundle_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:update(interval_tics)
    
    execute "redir! > ".expand('%:h')."/timestamp"
        silent! echon localtime()
    redir END

endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
