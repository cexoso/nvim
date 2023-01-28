-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require("conf.nvim-tree")
    end
  }
  use 'christoomey/vim-tmux-navigator'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'tpope/vim-surround'
  use 'tomtom/tcomment_vim'

  use 'tanvirtin/monokai.nvim'
  use 'gcmt/wildfire.vim'
  use 'tpope/vim-repeat'
  use 'AndrewRadev/splitjoin.vim'
  -- LSP 基础服务
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("conf.nvim-lspconfig")
    end
  }

  -- 自动安装 LSP
  use {
    "williamboman/nvim-lsp-installer",
    config = function()
      require("conf.nvim-lsp-installer")
    end
  }

  -- LSP UI 美化
  use {
    "tami5/lspsaga.nvim",
    config = function()
      require("conf.lspsaga")
    end
  }
  -- LSP 进度提示
  use {
    "j-hui/fidget.nvim",
    config = function()
      require("conf.fidget")
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require("conf.telescope")
    end
  }
  -- 插入模式获得函数签名
  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("conf.lsp_signature")
    end
  }
  -- 灯泡提示代码行为
  use {
    "kosayoda/nvim-lightbulb",
    config = function()
      require("conf.nvim-lightbulb")
    end
  }
  -- 自动代码补全系列插件
  use {
    "hrsh7th/nvim-cmp",  -- 代码补全核心插件，下面都是增强补全的体验插件
    requires = {
      {"onsails/lspkind-nvim"}, -- 为补全添加类似 vscode 的图标
      {"hrsh7th/vim-vsnip"}, -- vsnip 引擎，用于获得代码片段支持
      {"hrsh7th/cmp-vsnip"}, -- 适用于 vsnip 的代码片段源
      {"hrsh7th/cmp-nvim-lsp"}, -- 替换内置 omnifunc，获得更多补全
      {"hrsh7th/cmp-path"}, -- 路径补全
      {"hrsh7th/cmp-buffer"}, -- 缓冲区补全
      {"hrsh7th/cmp-cmdline"}, -- 命令补全
      {"f3fora/cmp-spell"}, -- 拼写建议
      {"rafamadriz/friendly-snippets"}, -- 提供多种语言的代码片段
      {"lukas-reineke/cmp-under-comparator"}, -- 让补全结果的排序更加智能
      {"tzachar/cmp-tabnine", run = "./install.sh"} -- tabnine 源,提供基于 AI 的智能补全
    },
    config = function()
      require("conf.nvim-cmp")
    end
  }

  use 'leafgarland/typescript-vim'
  use 'peitalin/vim-jsx-typescript'

  -- 代码格式化
  use {
    "sbdchd/neoformat",
    config = function()
      require("conf.neoformat")
    end
  }

  use {
    "easymotion/vim-easymotion"
  }

  use {
    "tveskag/nvim-blame-line"
  }

  use {
    'preservim/vimux'
  }
  use {
    'kana/vim-arpeggio'
  }
  use {
    'voldikss/vim-translator',
    config = function()
      require("conf.vim-translator")
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release' -- To use the latest release
    config = function()
      require("conf.gitsigns")
    end
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- use {'ZhiyuanLck/smart-pairs', event = 'InsertEnter', config = function() require('pairs'):setup() end}
  use {
    'eliba2/vim-node-inspect',
    config = function()
      require("conf.node-inspect")
    end
  }
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function()
      require("conf.markdown-preview")
    end
  })

  use({ "jtdowney/vimux-cargo" })

  use({ "SirVer/ultisnips" })
  use({ "stsewd/fzf-checkout.vim" })

end)
