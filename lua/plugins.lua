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
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)
