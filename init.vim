lua require('keymap')
lua require('plugins')
lua require('init')

au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
 
" augroup NvimTree
" au!
" autocmd FileType NvimTree nnoremap <buffer> <leader>f :echom "hello"<cr>
" augroup END 
