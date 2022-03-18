lua require('keymap')
lua require('plugins')
lua require('init')
lua require('lsp')

au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
 
