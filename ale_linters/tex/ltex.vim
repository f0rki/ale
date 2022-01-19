" Author: Ricardo Liang <ricardoliang@gmail.com>
" Author: ourigen <https://github.com/ourigen>
" Author: Michael Rodler <https://github.com/f0rki>
" Description: LTex-ls language server 

call ale#Set('tex_ltex_executable', 'ltex-ls')
call ale#Set('tex_ltex_options', '')
call ale#Set('tex_ltex_config', {})

function! ale_linters#tex#ltex#GetProjectRoot(buffer) abort
    let l:git_path = ale#path#FindNearestDirectory(a:buffer, '.git')

    return !empty(l:git_path) ? fnamemodify(l:git_path, ':h:h') : ''
endfunction

function! ale_linters#tex#ltex#GetCommand(buffer) abort
    return '%e' . ale#Pad(ale#Var(a:buffer, 'tex_ltex_options'))
endfunction

call ale#linter#Define('tex', {
\   'name': 'ltex',
\   'lsp': 'stdio',
\   'executable': {b -> ale#Var(b, 'tex_ltex_executable')},
\   'command': function('ale_linters#tex#ltex#GetCommand'),
\   'project_root': function('ale_linters#tex#ltex#GetProjectRoot'),
\   'lsp_config': {b -> ale#Var(b, 'tex_ltex_config')},
\})
