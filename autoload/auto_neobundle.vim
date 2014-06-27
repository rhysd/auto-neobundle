" coding: utf-8

if exists("g:auto_neobundle_loaded")
    finish
endif
let g:auto_neobundle_loaded = 1

" no need to save cpo because line continuation isn't used.
" :help use-cpo-save

" set timestamp file location
if !exists("g:auto_neobundle_timestamp_dir")
    let g:auto_neobundle_timestamp_dir = $HOME . (has('win32')||has('win64') ? '/vimfiles' : '/.vim')
endif

" update timestamp.
function! auto_neobundle#timestamp()
    let stamp_file = g:auto_neobundle_timestamp_dir . '/.auto_neobundle_timestamp'
    call writefile([localtime()], stamp_file)
endfunction

" update plugins with neobundle if tics seconds have passed.
function! auto_neobundle#update(tics)
    let stamp_file = g:auto_neobundle_timestamp_dir . '/.auto_neobundle_timestamp'
    let stamp = filereadable(stamp_file) ? readfile(stamp_file)[0] : 0
    let now = localtime()

    if(now - stamp < a:tics)
        return
    endif

    " update plugins with neobundle.vim
    call unite#start([['neobundle/update']], {'auto_quit' : 1, 'buffer_name' : 'auto-neobundle', 'winheight' : 5, 'start_insert' : 0, 'log' : 1})
    " Unite neobundle/update -hide-source-names -buffer-name=auto-neobundle -winheight=5 -auto-quit -log -no-start-insert -auto-quit

    call auto_neobundle#timestamp()
endfunction

" check daily
function! auto_neobundle#update_daily()
    " 86400 seconds/day
    call auto_neobundle#update(86400)
endfunction

" check weekly
function! auto_neobundle#update_weekly()
    " 604800 seconds/weekly
    call auto_neobundle#update(604800)
endfunction

" check per 3 days
function! auto_neobundle#update_every_3days()
    " 259200 seconds/3days
    call auto_neobundle#update(259200)
endfunction

function! auto_neobundle#update_every_30days()
    " 2592000 seconds/30days
    call auto_neobundle#update(2592000)
endfunction

command! AutoNeoBundleTimestamp call auto_neobundle#timestamp()
