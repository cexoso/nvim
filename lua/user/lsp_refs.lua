-- 自定义 LSP references：支持过滤测试文件后再喂给 Telescope。
local M = {}

local TEST_PATTERNS = {
  '%.test%.[%w]+$',
  '%.spec%.[%w]+$',
}

local function is_test_file(path)
  for _, pat in ipairs(TEST_PATTERNS) do
    if path:match(pat) then
      return true
    end
  end
  return false
end

-- 把 LSP location 标准化为 "uri:line:col" 用于去重比较。
-- references 和 definition 返回的范围可能不完全一致（一个指标识符、一个指整个声明），
-- 所以只比较起始 uri + 起始行，足以判断是不是同一个声明。
local function loc_key(loc)
  local uri = loc.uri or loc.targetUri
  local range = loc.range or loc.targetSelectionRange or loc.targetRange
  if not uri or not range then return nil end
  return uri .. ':' .. range.start.line
end

function M.references(opts)
  opts = opts or {}
  local exclude_tests = opts.exclude_tests

  local params = vim.lsp.util.make_position_params(0, 'utf-8')
  params.context = { includeDeclaration = false }

  -- 当前光标所在文件的 URI + 行号，用于剔除"光标自己所在的那一项"
  -- （即你按 gr 时正盯着的那一行调用 / 声明 — 不需要再列出来）
  local cur_uri = vim.uri_from_bufnr(0)
  local cur_line = params.position.line
  local cur_key = cur_uri .. ':' .. cur_line

  vim.lsp.buf_request(0, 'textDocument/references', params, function(err, result, ctx)
    if err then
      vim.notify('LSP references error: ' .. tostring(err.message), vim.log.levels.ERROR)
      return
    end
    if not result or vim.tbl_isempty(result) then
      vim.notify('No references found', vim.log.levels.INFO)
      return
    end

    local total = #result
    local filtered = {}
    for _, item in ipairs(result) do
      local uri = item.uri or item.targetUri
      local path = uri and vim.uri_to_fname(uri) or ''
      if exclude_tests and is_test_file(path) then
        -- skip
      elseif loc_key(item) == cur_key then
        -- 跳过光标当前所在的那一项（"自己"）
      else
        table.insert(filtered, item)
      end
    end

    if vim.tbl_isempty(filtered) then
      vim.notify(
        ('No other references found (%d filtered).'):format(total),
        vim.log.levels.INFO
      )
      return
    end

    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local offset_encoding = client and client.offset_encoding or 'utf-16'

    -- 只有一个引用时直接跳转，跳过 picker
    if #filtered == 1 then
      vim.lsp.util.show_document(filtered[1], offset_encoding, { focus = true })
      return
    end

    local items = vim.lsp.util.locations_to_items(filtered, offset_encoding)

    local themes = require('telescope.themes')
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local make_entry = require('telescope.make_entry')

    local prompt_title = 'LSP References'
    if exclude_tests and #filtered < total then
      prompt_title = ('LSP References (%d/%d, tests hidden)'):format(#filtered, total)
    end

    pickers
      .new(themes.get_dropdown({}), {
        prompt_title = prompt_title,
        finder = finders.new_table({
          results = items,
          entry_maker = make_entry.gen_from_quickfix({}),
        }),
        previewer = conf.qflist_previewer({}),
        sorter = conf.generic_sorter({}),
      })
      :find()
  end)
end

return M
