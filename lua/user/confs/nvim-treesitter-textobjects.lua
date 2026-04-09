return function()
  local ok, configs = pcall(require, "nvim-treesitter.configs")
  if not ok then
    vim.schedule(function()
      vim.notify("nvim-treesitter.configs is not available", vim.log.levels.WARN)
    end)
    return
  end

  configs.setup({
    textobjects = {
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "<c-v>",
        },
        include_surrounding_whitespace = true,
      },
      move = {
        set_jumps = true,
      },
    },
  })
end
