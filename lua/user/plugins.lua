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
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
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
    -- "kinling9/im-select.nvim",
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
  -- {
  --   "olimorris/codecompanion.nvim",
  --   opts = {},
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = require("user.confs.codecompanion"),
  -- },
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- this file can contain specific instructions for your project
      instructions_file = "avante.md",
      -- for example
      -- provider = "my_qwencoder",
      provider = "gemini-cli",
      providers = {
        my_qwencoder = {
          __inherited_from = "openai",
          api_key_name = "DASHSCOPE_API_KEY",
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          model = "qwen3-coder-plus",
        },
        my_qwenplus = {
          __inherited_from = "openai",
          api_key_name = "DASHSCOPE_API_KEY",
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          model = "qwen-plus-2025-12-01",
        },
      },
      acp_providers = {
        ["gemini-cli"] = {
          command = "gemini",
          args = { "--experimental-acp" },
          env = {
            NODE_NO_WARNINGS = "1",
            GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-mini/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = require("user.confs.nvim-treesitter-textobjects"),
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
