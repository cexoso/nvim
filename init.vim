lua require('keymap')
lua require('plugins')
lua require('init')

au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}

" augroup NvimTree
" au!
" autocmd FileType NvimTree nnoremap <buffer> <leader>f :echom "hello"<cr>
" augroup END
colorscheme monokai_pro
" colorscheme delek

nmap s <Plug>(easymotion-s2)
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

call arpeggio#load()

Arpeggionoremap rl :wa<CR> :CargoTestAll<CR>
Arpeggionoremap rp :VimuxPromptCommand<CR>

let g:UltiSnipsSnippetDirectories = [fnamemodify($MYVIMRC, ":h").."/UltiSnips/"]

let g:UltiSnipsExpandTrigger="<space>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
autocmd FileType markdown nmap <buffer><silent> <leader>i :call mdip#MarkdownClipboardImage()<CR>

function! ExportMMDC()
  if &filetype == 'markdown' || &filetype == 'md'
    let out = fnamemodify(expand("%:p"), ":h").."/"..expand('%:t:r')..".pdf"
    let command = "! md2pdf "..expand("%:p")
    execute command
  else
    echo "not support for "..&filetype.." file"
  endif
endfunction

command! MMDC call ExportMMDC()

function! GenerateModule()
  if &filetype == 'typescriptreact' || &filetype == 'vue'
    let cwd = fnamemodify(expand("%:p"), ":h")
    let command = "!wf generate -c "..cwd.." "..expand('<cword>')
    execute command
  else
    echo "not support for "..&filetype.." file"
  endif
endfunction

command! GM call GenerateModule()
