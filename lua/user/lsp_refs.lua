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

function M.references(opts)
  opts = opts or {}
  local exclude_tests = opts.exclude_tests

  local params = vim.lsp.util.make_position_params(0, 'utf-8')
  params.context = { includeDeclaration = false }

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
    local filtered = result
    if exclude_tests then
      filtered = {}
      for _, item in ipairs(result) do
        local uri = item.uri or item.targetUri
        local path = uri and vim.uri_to_fname(uri) or ''
        if not is_test_file(path) then
          table.insert(filtered, item)
        end
      end
    end

    if vim.tbl_isempty(filtered) then
      vim.notify(
        ('All %d references are in test files. Use <leader>gr to view them.'):format(total),
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
