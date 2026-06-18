-- 复制带路径与行号的内容到系统剪贴板。
-- 普通模式 Y: "<绝对路径>:<行号>: <当前行内容>"
-- Visual 模式 Y: "<绝对路径>:<起始行>:<结束行>\n<选中代码>"
local M = {}

local function set_clipboard(text)
  vim.fn.setreg('"', text)
  vim.fn.setreg('+', text)
  vim.fn.setreg('*', text)
end

function M.yank()
  local path = vim.fn.expand('%:p')
  if path == '' then
    vim.notify('Current buffer has no file', vim.log.levels.WARN)
    return
  end
  local lnum = vim.fn.line('.')
  local line = vim.api.nvim_get_current_line()
  set_clipboard(string.format('%s:%d: %s', path, lnum, line))
end

function M.yank_visual()
  local path = vim.fn.expand('%:p')
  if path == '' then
    vim.notify('Current buffer has no file', vim.log.levels.WARN)
    return
  end

  local mode = vim.fn.visualmode()

  -- 退出 visual 模式以刷新 '< '> 标记
  vim.cmd('normal! \27')

  local s_pos = vim.fn.getpos("'<")
  local e_pos = vim.fn.getpos("'>")
  local s_line, s_col = s_pos[2], s_pos[3]
  local e_line, e_col = e_pos[2], e_pos[3]
  if s_line > e_line or (s_line == e_line and s_col > e_col) then
    s_line, e_line = e_line, s_line
    s_col, e_col = e_col, s_col
  end

  local lines = vim.api.nvim_buf_get_lines(0, s_line - 1, e_line, false)

  if mode == 'V' then
    local header = string.format('%s:%d:%d', path, s_line, e_line)
    set_clipboard(header .. '\n\n' .. table.concat(lines, '\n'))
    return
  end

  if mode == '\22' then -- block-wise (Ctrl-V)
    local block = {}
    for _, line in ipairs(lines) do
      table.insert(block, line:sub(s_col, e_col))
    end
    local header = string.format('%s:%d:%d:%d-%d', path, s_line, e_line, s_col, e_col)
    set_clipboard(header .. '\n\n' .. table.concat(block, '\n'))
    return
  end

  -- characterwise (v)
  -- '> 的列可能是 MAXCOL（行尾扩展，如 V$ 后切回 v），截到行长
  local last_line_len = #lines[#lines]
  if e_col > last_line_len then e_col = last_line_len end

  local header
  if s_line == e_line then
    lines[1] = lines[1]:sub(s_col, e_col)
    header = string.format('%s:%d:%d-%d', path, s_line, s_col, e_col)
  else
    -- 跨行：保留完整行，header 记录精确列范围
    header = string.format('%s:%d:%d-%d:%d', path, s_line, s_col, e_line, e_col)
  end
  set_clipboard(header .. '\n\n' .. table.concat(lines, '\n'))
end

return M
