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

map {'n', '<Leader>w', ':w<CR>'}
map {'n', '<Leader>e', ':e!<CR>'}
map {'n', '<Leader>b', ':NvimTreeFindFileToggle<CR>'}
map {'n', 'ZZ', ':wqa<CR>'}
map {'i', 'ZZ', '<esc>:wqa<CR>'}
map {'n', 'ZX', ':qa!<CR>'}
map {'i', 'ZX', '<esc>:qa!<CR>'}

map {'n', '<BS>', ':set nohls<CR>'}
map {'n', 'o', 'o<esc>'}
map {'n', 'O', 'O<esc>'}
map {'n', '<leader>e', ':e!<CR>'}

map {'i', 'jk', '<esc>'}


map {'n', '<C-p>', '<Esc>:Telescope git_files<CR>'}
map {'n', '<leader><C-p>', '<Esc>:Telescope git_status<CR>'}
map {'n', '<leader><C-r>', '<Esc>:Telescope command_history<CR>'}
map {'n', '<leader>o', '<Esc>:Telescope buffers<CR>'}

map {'n', 'H', '0'}
map {'n', 'L', '$'}

map {'n', "<leader>p" ,'"_dePb'}

-- this is a key map for extand string as a tag line div -> <div /> or <div></div> with a style format
map {'n', '$,', ':<C-u>:set paste<CR>viW<esc>`<i<<esc>`>la /><esc>:<C-u>:set nopaste<CR>=='}
map {'n', '$.', ':<C-u>:set paste<CR>viW"zy<esc>`<i<<esc>`>la><esc>o<esc>"zpviW<esc>`<i</<esc>`>2la><esc>:<C-u>:set nopaste<CR>=at'}

map {'n', '<leader>ss', ':Telescope grep_string<CR>'}
map {'n', '<leader>sw', ':Telescope live_grep<CR>'}

-- <M-p>
map {'n', 'cp', ':<C-U>:normal viwvpgv"mx<cr>'}

return {
  map = map
}

