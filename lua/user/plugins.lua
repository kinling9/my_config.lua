-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local default_config = {
  "navarasu/onedark.nvim",
  -- "airblade/vim-gitgutter",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "neovim/nvim-lspconfig",
  -- "kinling9/neoformat",
  {
    "stevearc/conform.nvim",
    opts = {},
    config = require("user.confs.conform"),
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  -- vsnip
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
      "julianolf/nvim-dap-lldb",
    },
    config = require("user.confs.dap"),
  },
  -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  {
    "keaising/im-select.nvim",
    config = function()
      require("user.confs.im_select")
    end,
  },
  { "echasnovski/mini.nvim", version = false },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("user.confs.nvim_tree")
    end,
  },
  {
    "terrortylor/nvim-comment",
    config = function()
      require("user.confs.nvim_comment")
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("user.confs.nvim_autopairs")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("user.confs.nvim_treesitter")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("user.confs.toggleterm")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("user.confs.nvim_cmp")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("user.confs.gitsigns")
    end,
  },
  {
    "NeogitOrg/neogit",
    config = function()
      require("user.confs.neogit")
    end,
  },
  {
    "easymotion/vim-easymotion",
    config = function()
      require("user.confs.easymotion")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      require("user.confs.markdown_preview")
    end,
  },
  {
    "lervag/vimtex",
    config = function()
      require("user.confs.vimtex")
    end,
  },
  {
    "richardbizik/nvim-toc",
    config = function()
      require("user.confs.nvim_toc")
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("user.confs.copilot")
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = require("user.confs.codecompanion"),
  },
}
local wsl_config = {
  -- "keaising/im-select.nvim",
}
if vim.fn.has("wsl") == 1 then
  local total_config = default_config
  for _, v in ipairs(wsl_config) do
    table.insert(total_config, v)
  end

  require("lazy").setup(total_config)
else
  require("lazy").setup(default_config)
end
