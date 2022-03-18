vim.g.mapleader = ' '
local map = function(key)
  -- get the extra options
  local opts = {noremap = true}
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

map {'n', '<Leader>w', ':write<CR>'}
map {'n', '<Leader>b', ':NvimTreeToggle<CR>'}
map {'n', 'ZZ', ':wqa<CR>'}
map {'n', 'ZX', ':qa!<CR>'}

map {'n', '<BS>', ':set nohls<CR>'}
map {'n', 'o', 'o<esc>'}
map {'n', 'O', 'O<esc>'}
map {'n', '<leader>e', ':e!<CR>'}

map {'i', 'jk', '<esc>'}


map {'n', '<C-p>', '<Esc>:GFiles<CR>'}
map {'n', '<leader><C-p>', '<Esc>:GFiles?<CR>'}

map {'n', 'H', '0'}
map {'n', 'L', '$'}

