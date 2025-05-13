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
  { "echasnovski/mini.nvim", version = false },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          qwencoder = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "qwen",
              formatted_name = "Qwen",
              roles = {
                llm = "assistant",
                user = "user",
                system = "system",
              },
              opts = {
                stream = true,
              },
              features = {
                text = true,
                tokens = true,
                vision = false,
              },
              env = {
                url = "https://dashscope.aliyuncs.com/compatible-mode",
                chat_url = "/v1/chat/completions",
                api_key = "DASHSCOPE_API_KEY",
              },
              schema = {
                ---@type CodeCompanion.Schema
                model = {
                  default = "qwen-plus-latest",
                },
              },
            })
          end,
        },
        strategies = {
          agent = {
            adapter = "qwencoder",
          },
          chat = {
            adapter = "qwencoder",
          },
          inline = {
            adapter = "qwencoder",
          },
        },
      })
    end,
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
