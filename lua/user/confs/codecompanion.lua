return function()
  require("codecompanion").setup({
    adapters = {
      acp = {
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            defaults = {
              auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
            },
          })
        end,
      },
      http = {
        myqwencoder = function()
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
                default = "qwen3-coder-plus",
              },
            },
          })
        end,
        myqwenplus = function()
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
                default = "qwen-plus-2025-07-28",
              },
            },
          })
        end,
      },
    },
    -- strategies = {
    --   agent = {
    --     adapter = "qwencoder",
    --   },
    --   chat = {
    --     adapter = "qwencoder",
    --   },
    --   inline = {
    --     adapter = "qwencoder",
    --   },
    -- },
    interactions = {
      chat = {
        adapter = "gemini_cli",
      },
    },
  })
end
