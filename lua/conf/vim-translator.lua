local map = require('keymap').map;

map {'n', '<leader>t', ':TranslateW<cr>'}
vim.cmd([[
let g:translator_default_engines=['bing', 'google', 'haici', 'youdao']
]])
