---@diagnostic disable: unused-local
local map = require('keymap').map;
-- https://github.com/williamboman/nvim-lsp-installer
local lsp_installer_servers = require("nvim-lsp-installer.servers")
-- WARN: 手动书写 LSP 配置文件
-- 名称：https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- 配置：https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
    -- 语言服务器名称：配置选项
    sumneko_lua = require("lsp.sumneko_lua"),
    -- pyright = require("lsp.pyright"),
    tsserver = require("lsp.tsserver"),
    -- html = require("lsp.html"),
    -- cssls = require("lsp.cssls"),
    -- gopls = require("lsp.gopls"),
    -- jsonls = require("lsp.jsonls"),
    -- zeta_note = require("lsp.zeta_note"),
    -- sqls = require("lsp.sqls"),
    vuels = require("lsp.vuels"),
    rust_analyzer = require("lsp.rust_analyzer"),
}
-- 这里是 LSP 服务启动后的按键加载
local function attach(_, bufnr)
    -- -- 跳转到定义（代替内置 LSP 的窗口，telescope 插件让跳转定义更方便）
    -- vim.keybinds.bmap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions theme=dropdown<CR>", vim.keybinds.opts)
    map { "n", "gd",   "<cmd>Telescope lsp_definitions theme=dropdown<CR>", buffer = true }
    -- -- 列出光标下所有引用（代替内置 LSP 的窗口，telescope 插件让查看引用更方便）
    -- vim.keybinds.bmap(bufnr, "n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>", vim.keybinds.opts)
    map { "n", "gr",  "<cmd>Telescope lsp_references theme=dropdown<CR>", buffer = true }
    -- -- 工作区诊断（代替内置 LSP 的窗口，telescope 插件让工作区诊断更方便）
    map { "n", "go",  "<cmd>Telescope diagnostics theme=dropdown<CR>", buffer = true }
    -- -- 显示代码可用操作（代替内置 LSP 的窗口，telescope 插件让代码行为更方便）
    -- vim.keybinds.bmap(bufnr, "n", "<leader>ca", "<cmd>Telescope lsp_code_actions theme=dropdown<CR>", vim.keybinds.opts)
    map { "n", "<leader>ca", "<cmd>Telescope lsp_code_actions theme=dropdown<CR>", buffer = true }
    -- -- 变量重命名（代替内置 LSP 的窗口，Lspsaga 让变量重命名更美观）
    -- vim.keybinds.bmap(bufnr, "n", "<leader>cn", "<cmd>Lspsaga rename<CR>", vim.keybinds.opts)
    map { "n", "<leader>rn", "<cmd>Lspsaga rename<CR>", buffer = true }
    -- -- 查看帮助信息（代替内置 LSP 的窗口，Lspsaga 让查看帮助信息更美观）
    map { "n", "K",  "<cmd>Lspsaga hover_doc<CR>", buffer = true }
    -- vim.keybinds.bmap(bufnr, "n", "gh", "<cmd>Lspsaga hover_doc<CR>", vim.keybinds.opts)
    -- -- 跳转到上一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
    -- vim.keybinds.bmap(bufnr, "n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", vim.keybinds.opts)
    map { "n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", buffer = true }
    -- -- 跳转到下一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
    -- vim.keybinds.bmap(bufnr, "n", "g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", vim.keybinds.opts)
    map { "n", "g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", buffer = true }
    -- -- 悬浮窗口上翻页，由 Lspsaga 提供
    -- vim.keybinds.bmap(
    --     bufnr,
    --     "n",
    --     "<C-p>",
    --     "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
    --     vim.keybinds.opts
    -- )
    -- map { "n", "<C-p>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", buffer = true }
    -- -- 悬浮窗口下翻页，由 Lspsaga 提供
    -- vim.keybinds.bmap(
    --     bufnr,
    --     "n",
    --     "<C-n>",
    --     "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
    --     vim.keybinds.opts
    -- )
    -- map { "n", "<C-n>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", buffer = true }
end
-- 自动安装或启动 LanguageServers
for server_name, server_options in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    -- 判断服务是否可用
    if server_available then
        -- 判断服务是否准备就绪，若就绪则启动服务
        server:on_ready(
            function()
                -- keybind
                server_options.on_attach = attach
                -- options config
                server_options.flags = {
                    debounce_text_changes = 150
                }
                -- 启动服务
                server:setup(server_options)
            end
        )
        -- 如果服务器没有下载，则通过 notify 插件弹出下载提示
        if not server:is_installed() then
            vim.notify("Install Language Server : " .. server_name, "WARN", {title = "Language Servers"})
            server:install()
        end
    end
end
