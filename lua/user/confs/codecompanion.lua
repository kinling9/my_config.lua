return function()
  require("codecompanion").setup({
    adapters = {
      http = {
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
                default = "qwen3-coder-plus",
              },
            },
          })
        end,
      },
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
end