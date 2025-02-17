return {
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icon
    config = function()
      require('conf.nvim-tree')
    end
  },

  -- Miscellaneous plugins
  { 'christoomey/vim-tmux-navigator' },
  { 'junegunn/fzf' },
  { 'junegunn/fzf.vim' },
  { 'tpope/vim-surround' },
  { 'tomtom/tcomment_vim' },
  { 
    priority = 1000,
    lazy = false,
    'tanvirtin/monokai.nvim',
    config = function ()
     -- 设置配色方案
     vim.cmd("colorscheme monokai_pro")
    end
  },
  { 'gcmt/wildfire.vim' },
  { 'tpope/vim-repeat' },
  { 'AndrewRadev/splitjoin.vim' },

  -- LSP configuration
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('conf.nvim-lspconfig')
    end
  },

  -- LSP UI enhancements
  {
    'nvimdev/lspsaga.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('conf.lspsaga')
    end
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('conf.telescope')
    end
  },

  -- LSP signature help
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('conf.lsp_signature')
    end
  },

  -- Code action indicator
  {
    'kosayoda/nvim-lightbulb',
    config = function()
      require('conf.nvim-lightbulb')
    end
  },

  -- Auto-completion plugins
  {
    'hrsh7th/nvim-cmp',
    priority = 900,
    dependencies = {
      { 'onsails/lspkind-nvim' },
      { 'hrsh7th/vim-vsnip' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'f3fora/cmp-spell' },
      { 'rafamadriz/friendly-snippets' },
      { 'lukas-reineke/cmp-under-comparator' },
      { 'tzachar/cmp-tabnine', build = './install.sh' }
    },
    config = function()
      require('conf.nvim-cmp')
    end
  },

  -- Additional language support
  { 'leafgarland/typescript-vim' },
  { 'peitalin/vim-jsx-typescript' },

  -- Code formatting
  {
    'sbdchd/neoformat',
    config = function()
      require('conf.neoformat')
    end
  },

  -- Motion plugins
  { 'easymotion/vim-easymotion' },
  { 'preservim/vimux' },
  { 'kana/vim-arpeggio' },

  -- Translation plugin
  {
    'voldikss/vim-translator',
    config = function()
      require('conf.vim-translator')
    end
  },

  -- Telescope enhancements
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  -- Cargo integration for Vimux
  { 'jtdowney/vimux-cargo' },

  -- Snippets
  { 
    'SirVer/ultisnips',
    priority = 1000,
    config = function()
      vim.g.UltiSnipsExpandTrigger = "<space>"
      vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<S-tab>"
      vim.g.UltiSnipsSnippetDirectories = {vim.fn.fnamemodify(vim.fn.expand("$MYVIMRC"), ":h").."/UltiSnips/"}
      -- 其他 UltiSnips 的配置...
    end,
  },

  -- Git branch checkout with fzf
  { 'stsewd/fzf-checkout.vim' },

  -- Image pasting
  { 'img-paste-devs/img-paste.vim' }
}
