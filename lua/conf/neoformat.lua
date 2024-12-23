local map = require('keymap').map;
-- https://github.com/sbdchd/neoformat

-- WARN: neoformat 手动安装各语言的代码格式化程序
-- https://github.com/sbdchd/neoformat#supported-filetypes

-- 当没有找到格式化程序时，将按照如下方式自动格式化
-- 自动格式化

-- vim.cmd([[
-- augroup fmt
--   autocmd!
--   autocmd BufWritePre * undojoin | Neoformat
-- augroup END
-- ]])

map { "n", "<C-f>", "<cmd>Neoformat<CR>"}
