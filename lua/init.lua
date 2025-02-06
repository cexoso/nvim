require('keymap')
-- require('plugins')

-- 复制高亮
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({higroup="IncSearch", timeout=150})
  end
})

-- NvimTree 注释部分,如果需要可以取消注释
-- vim.api.nvim_create_augroup("NvimTree", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   group = "NvimTree",
--   pattern = "NvimTree",
--   callback = function()
--     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>f', ':echom "hello"<CR>', {noremap = true, silent = true})
--   end
-- })

-- 设置配色方案
vim.cmd("colorscheme monokai_pro")

-- EasyMotion 配置
vim.api.nvim_set_keymap('n', 's', '<Plug>(easymotion-s2)', {})
vim.g.EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

-- Arpeggio 配置
vim.cmd("call arpeggio#load()")
vim.cmd("Arpeggionoremap rl :wa<CR> :CargoTestAll<CR>")
vim.cmd("Arpeggionoremap rp :VimuxPromptCommand<CR>")

-- UltiSnips 配置
vim.g.UltiSnipsSnippetDirectories = {vim.fn.fnamemodify(vim.fn.expand("$MYVIMRC"), ":h").."/UltiSnips/"}
vim.g.UltiSnipsExpandTrigger = "<space>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-tab>"

-- Markdown 图片粘贴快捷键
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>i', ':call mdip#MarkdownClipboardImage()<CR>', {noremap = true, silent = true})
  end
})

-- ExportMMDC 函数
function ExportMMDC()
  local filetype = vim.bo.filetype
  if filetype == 'markdown' or filetype == 'md' then
    local out = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h").."/"..vim.fn.expand('%:t:r')..".pdf"
    local command = "! md2pdf "..vim.fn.expand("%:p")
    vim.cmd(command)
  else
    print("not support for "..filetype.." file")
  end
end

vim.api.nvim_create_user_command('MMDC', ExportMMDC, {})

-- GenerateModule 函数
function GenerateModule()
  local filetype = vim.bo.filetype
  if filetype == 'typescriptreact' or filetype == 'vue' then
    local cwd = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h")
    local command = "!wf generate -c "..cwd.." "..vim.fn.expand('<cword>')
    vim.cmd(command)
  else
    print("not support for "..filetype.." file")
  end
end

vim.api.nvim_create_user_command('GM', GenerateModule, {})

-- 设置 PATH
vim.env.PATH = '/Users/xiongjie/Library/Caches/fnm_multishells/21132_1738727315752/bin:' .. vim.env.PATH
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

