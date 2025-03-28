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
    config = function()
      -- require("conform").formatter.bibtextidy = {
      -- 	prepend_args = { "--sort=type,-year,name", "--sort-fields", "--blank-lines" },
      -- }
      require("conform").setup({
        formatters = {
          bibtextidy = {
            command = "bibtex-tidy",
            stdin = true,
            args = { "--sort=type,-year,name", "--sort-fields", "--blank-lines", "--quiet" },
          },
        },
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "black" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          markdown = { "deno_fmt" },
          tex = { "latexindent" },
          bib = { "bibtextidy" },
          rust = { "rustfmt" },
          ["*"] = { "trim_whitespace", "trim_newlines" },
        },
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
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
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      require("dap-python").setup("python")
      require("dap-lldb").setup("cpp")
      require("dapui").setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
      vim.keymap.set("n", "<Leader>dc", dap.continue, {})
    end,
  },
  -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },
  "zbirenbaum/copilot-cmp",
  "keaising/im-select.nvim",
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      debug = true,
      provider = "qianwen",
      vendors = {
        qianwen = {
          __inherited_from = "openai",
          api_key_name = "DASHSCOPE_API_KEY",
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          model = "qwen-max-latest",
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
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
