return function()
  local ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
  if not ok then
    vim.schedule(function()
      vim.notify("nvim-treesitter-textobjects is not available", vim.log.levels.WARN)
    end)
    return
  end

  textobjects.setup({
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
  })
end
