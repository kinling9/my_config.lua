local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
  vim.schedule(function()
    vim.notify("nvim-treesitter is not available", vim.log.levels.WARN)
  end)
  return
end

ts.setup({})

local ts_group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = ts_group,
  callback = function(args)
    if vim.bo[args.buf].filetype == "latex" then
      return
    end

    pcall(vim.treesitter.start, args.buf)
  end,
})
