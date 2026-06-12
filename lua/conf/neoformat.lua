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

vim.g.neoformat_try_node_exe = 1

-- oxfmt: Prettier 兼容的高性能格式化器（JS/TS/JSON/YAML/TOML 等）
-- https://oxc.rs/docs/guide/usage/formatter.html
vim.g.neoformat_javascript_oxfmt = {
  exe = 'oxfmt',
  args = { '--stdin-filepath', '"%:p"' },
  stdin = 1,
  try_node_exe = 1,
}
vim.g.neoformat_typescript_oxfmt        = vim.g.neoformat_javascript_oxfmt
vim.g.neoformat_javascriptreact_oxfmt   = vim.g.neoformat_javascript_oxfmt
vim.g.neoformat_typescriptreact_oxfmt   = vim.g.neoformat_javascript_oxfmt
vim.g.neoformat_json_oxfmt              = vim.g.neoformat_javascript_oxfmt
vim.g.neoformat_jsonc_oxfmt             = vim.g.neoformat_javascript_oxfmt
vim.g.neoformat_yaml_oxfmt              = vim.g.neoformat_javascript_oxfmt
vim.g.neoformat_toml_oxfmt              = vim.g.neoformat_javascript_oxfmt

-- 让 oxfmt 成为这些 filetype 的首选 formatter，找不到时 fallback 到 prettier
vim.g.neoformat_enabled_javascript      = { 'oxfmt', 'prettier' }
vim.g.neoformat_enabled_typescript      = { 'oxfmt', 'prettier' }
vim.g.neoformat_enabled_javascriptreact = { 'oxfmt', 'prettier' }
vim.g.neoformat_enabled_typescriptreact = { 'oxfmt', 'prettier' }
vim.g.neoformat_enabled_json            = { 'oxfmt', 'prettier' }
vim.g.neoformat_enabled_jsonc           = { 'oxfmt', 'prettier' }
vim.g.neoformat_enabled_yaml            = { 'oxfmt', 'prettier' }

map { "n", "<C-f>", "<cmd>Neoformat<CR>"}
