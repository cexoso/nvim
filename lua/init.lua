local M = {
}

vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.shiftround      = true
vim.opt.swapfile        = false
vim.opt.clipboard       = 'unnamed'
vim.opt.ignorecase      = true
vim.opt.scrolloff       = 10
vim.opt.foldmethod      = 'indent'
vim.opt.foldlevel       = 99
vim.opt.syntax          = 'on'
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.autoindent = true
vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2

-- require('monokai').setup { palette = require('monokai').pro }

vim.g.fzf_layout = { window = {width = 1, height = 1} }
-- vim.g.fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
-- vim.cmd([[
-- let g:fzf_layout = { 'window': { 'width': 1, 'height': 1 } }
-- ]])
if (vim.fn.has('termguicolors') == 1) then
    vim.opt.termguicolors = true
end

return M

