local map = require('keymap').map;
-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map { "n", "gd",   "<cmd>Telescope lsp_definitions theme=dropdown<CR>" }
    -- -- 列出光标下所有引用（代替内置 LSP 的窗口，telescope 插件让查看引用更方便）
    -- vim.keybinds.bmap(bufnr, "n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>", vim.keybinds.opts)
    map { "n", "gr",  "<cmd>Telescope lsp_references theme=dropdown<CR>" }
    -- -- 工作区诊断（代替内置 LSP 的窗口，telescope 插件让工作区诊断更方便）
    map { "n", "go",  "<cmd>Telescope diagnostics theme=dropdown<CR>" }
    -- -- 显示代码可用操作（代替内置 LSP 的窗口，telescope 插件让代码行为更方便）
    -- vim.keybinds.bmap(bufnr, "n", "<leader>ca", "<cmd>Telescope lsp_code_actions theme=dropdown<CR>", vim.keybinds.opts)
    map { "n", "<leader>ca", "<cmd>Telescope lsp_code_actions theme=dropdown<CR>" }
    -- -- 变量重命名（代替内置 LSP 的窗口，Lspsaga 让变量重命名更美观）
    -- vim.keybinds.bmap(bufnr, "n", "<leader>cn", "<cmd>Lspsaga rename<CR>", vim.keybinds.opts)
    map { "n", "<leader>rn", "<cmd>Lspsaga rename<CR>" }
    -- -- 查看帮助信息（代替内置 LSP 的窗口，Lspsaga 让查看帮助信息更美观）
    map { "n", "K",  "<cmd>Lspsaga hover_doc<CR>" }
    -- vim.keybinds.bmap(bufnr, "n", "gh", "<cmd>Lspsaga hover_doc<CR>", vim.keybinds.opts)
    -- -- 跳转到上一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
    -- vim.keybinds.bmap(bufnr, "n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", vim.keybinds.opts)
    map { "n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>" }
    -- -- 跳转到下一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
    -- vim.keybinds.bmap(bufnr, "n", "g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", vim.keybinds.opts)
    map { "n", "g]", "<cmd>Lspsaga diagnostic_jump_next<CR>" }
  end,
})
