-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/hrsh7th/vim-vsnip
-- https://github.com/hrsh7th/cmp-vsnip
-- https://github.com/hrsh7th/cmp-nvim-lsp
-- https://github.com/hrsh7th/cmp-path
-- https://github.com/hrsh7th/cmp-buffer
-- https://github.com/hrsh7th/cmp-cmdline
-- https://github.com/f3fora/cmp-spell
-- https://github.com/rafamadriz/friendly-snippets
-- https://github.com/lukas-reineke/cmp-under-comparator
-- https://github.com/tzachar/cmp-tabnine

-- FIX: tabline 在某些计算机上有 1 个 BUG
-- 当出现：
--    TabNine is not executable
-- 等字样时，需要手动执行（仅限 Manjaro）：
--    rm ~/.local/share/nvim/plugged/cmp-tabnine/binaries
--    ~/.local/share/nvim/plugged/cmp-tabnine/install.sh

local lspkind = require("lspkind")

require('lspkind').init({
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "",
    },
})

local cmp = require("cmp")

cmp.setup(
    ---@diagnostic disable-next-line: redundant-parameter
    {
        -- 指定补全引擎
        snippet = {
            expand = function(args)
                -- 使用 vsnip 引擎
                vim.fn["vsnip#anonymous"](args.body)
            end
        },
        -- 指定补全源（安装了补全源插件就在这里指定）
        sources = cmp.config.sources(
            {
                {name = "vsnip"},
                {name = "nvim_lsp"},
                {name = "path"},
                {name = "buffer"},
                {name = "cmdline"},
                {name = "spell"},
                {name = "cmp_tabnine"}
            }
        ),
        -- 格式化补全菜单
        formatting = {
            format = lspkind.cmp_format(
                {
                    with_text = true,
                    maxwidth = 50,
                    before = function(entry, vim_item)
                        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                        return vim_item
                    end
                }
            )
        },
        -- 对补全建议排序
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                require("cmp-under-comparator").under,
                require("cmp_tabnine.compare"),
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order
            }
        },
        -- 绑定补全相关的按键
        mapping = {
            -- 上一个
            ["<c-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
            ["<s-tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
            -- 下一个
            ["<c-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
            ["<tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
            -- 选择补全
            ["<CR>"] = cmp.mapping.confirm()
            --  出现或关闭补全
            -- ["<C-k>"] = cmp.mapping(
            --     {
            --         i = function()
            --             if cmp.visible() then
            --                 cmp.abort()
            --             else
            --                 cmp.complete()
            --             end
            --         end,
            --         c = function()
            --             if cmp.visible() then
            --                 cmp.close()
            --             else
            --                 cmp.complete()
            --             end
            --         end
            --     }
            -- )
        }
    }
)

-- 命令行 / 模式提示
cmp.setup.cmdline(
    "/",
    {
        sources = {
            {name = "buffer"}
        }
    }
)

-- 命令行 : 模式提示
cmp.setup.cmdline(
    ":",
    {
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)
vim.g.vsnip_snippet_dir = "~/.config/nvim/snippet";
