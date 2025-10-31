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
  "terrortylor/nvim-comment",
  "nvim-tree/nvim-tree.lua",
  "nvim-treesitter/nvim-treesitter",
  -- "airblade/vim-gitgutter",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "windwp/nvim-autopairs",
  "easymotion/vim-easymotion",
  "akinsho/toggleterm.nvim",
  "neovim/nvim-lspconfig",
  -- "kinling9/neoformat",
  {
    "stevearc/conform.nvim",
    opts = {},
    config = require("user.confs.conform"),
  },
  "lewis6991/gitsigns.nvim",
  "NeogitOrg/neogit",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
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
  "lervag/vimtex",
  "richardbizik/nvim-toc",
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
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },
  "zbirenbaum/copilot-cmp",
  "keaising/im-select.nvim",
  { "echasnovski/mini.nvim", version = false },
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
