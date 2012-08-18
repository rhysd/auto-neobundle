" coding: utf-8

if exists("g:auto_neobundle_loaded")
    finish
endif
let g:auto_neobundle_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

" Update plugins with neobundle if tics seconds have passed.
function! s:update(interval_tics)
    let stamp = filereadable("timestamp") ? readfile("timestamp")[0] : 0
    let now = localtime()

    if(now - stamp < a:interval_tics)
        return
    endif

    " update plugins with neobundle.vim
    " Unite neobundle/update -hide-source-names -silent -buffer-name=auto-neobundle
    Unite file

    execute "redir! > ".expand('%:h')."/timestamp"
        silent! echon localtime()
    redir END
endfunction

" check daily
function! auto_neobundle#update_daily()
    " 86400 seconds/day
    call s:update(86400)
endfunction

" check weekly
function! auto_neobundle#update_weekly()
    " 604800 seconds/weekly
    call s:update(604800)
endfunction

function! auto_neobundle#update_30days()
    " 2592000 seconds/30days
    call s:update(2592000)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
