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
