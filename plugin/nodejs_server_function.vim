" ===========================================================================
" Description:  Vim plugin for start/restart/stop a Node.js server
" Mantainer:    Matias Linares <matiaslina at gmail dot com>
" Last Change:  16 July, 2013
" Licence:      This program is This program is free software. It comes 
"               without any warranty, to the extent permitted by applicable 
"               law. You can redistribute it and/or modify it under the terms 
"               of the GNU General Public License, 
"               Version 2, see the LICENSE file for more details
" ===========================================================================

let s:node_server = ""
let s:server_running = 0

function! NodeSetApp(text)
    let s:node_server = getcwd() .'/'. a:text
endfunction

function! NodeStartServer ()
    if !s:server_running
        let i = system('node ' . s:node_server . '&')
        echo "Node.js Server started"
        let s:server_running = 1
    else
        echo "Node.js Server already Running"
    endif
endfunction

function! NodeStopServer ()
    if s:server_running
        call system('pkill node')
        echo "Node.js Server stopped"
        let s:server_running = 0
    else
        echo "There's no node.js server running"
    endif
endfunction

function! NodeRestartServer()
    if s:server_running
        call NodeStopServer()
        call NodeStartServer()
        echo "Node.js Server Restarted"
    endif
endfunction

command! -nargs=1 -complete=file NodejsSetFile call NodeSetApp ("<args>") 
command! -nargs=0 NodejsStart call NodeStartServer ()
command! -nargs=0 NodejsStop call NodeStopServer ()
command! -nargs=0 NodejsRestart call NodeRestartServer ()
