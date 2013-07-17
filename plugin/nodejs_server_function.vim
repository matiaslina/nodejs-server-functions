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

" Initialization
function! s:set (var, default)
    if !exists(a:var)
        if type(a:default)
            exe 'let' a:var '=' string(a:default)
        else
            exe 'let' a:var '=' a:default
        endif
    endif
endfunction

" NodejsRunType it's a field that allows to change the behaviour of the
" script. It can be setted to:
"
"   * NodejsRunType = "npm"      => uses npm scripts
"   * NodejsRunType = "node-dev" => uses node-dev script
"   * NodejsRunType = "bash"     => use bash to Start/Stop the server.
"
" By default it will be setted to bash.

call s:set('g:NodejsRunType', "bash")

" Some variables
let s:node_server = ""
let s:server_running = 0

" Auxiliar functions
function! s:exec_exists(e)
    if executable(a:e)
        return 1
    else
        return 0
    endif
endfunction

function! s:highlight_error (var)
    echohl WarningMsg | echo a:var | echohl None
endfunction

function! NodeSetApp(text)
    let s:node_server = getcwd() .'/'. a:text
endfunction

function! NodeStartServer ()
    if !s:server_running
        if s:exec_exists ("node")
            if g:NodejsRunType == "npm"
                if s:exec_exists ("npm")
                    call system('npm start &')
                else
                    call s:highlight_error ("npm isn't installed in your system!")
                endif
            elseif g:NodejsRunType == "node-dev"
                if s:exec_exists ("node-dev")
                    if s:node_server != ""
                        call system('node-dev ' . s:node_server . '&')
                    else
                        call s:highlight_error( "You need to set the server file with :NodejsSetFile")
                    endif
                else
                    call s:highlight_error( "node-dev isn't installed in your system!")
                endif
            else
                if s:node_server != ""
                    call system('node ' . s:node_server . '&')
                else
                    call s:highlight_error( "You need to set the server file with :NodejsSetFile")
                endif
                let s:server_running = 1
                echo "Node.js Server started"
            endif
        else
            call s:highlight_error("node.js isn't installed in your system!")
        endif
    else
        call s:highlight_error("Node.js Server already Running")
    endif
endfunction

function! NodeStopServer ()
    if s:server_running
        if s:exec_exists ("node")
            if g:NodejsRunType == "npm"
                call system('npm stop &')
            else
                call system('pkill node')
            endif
            let s:server_running = 0
            echo "Node.js Server stopped"
        else
            call s:highlight_error( "node.js isn't installed in your system!")
        endif
    else
        call s:highlight_error( "There's no node.js server running")
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
