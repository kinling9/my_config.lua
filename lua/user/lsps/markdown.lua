vim.lsp.config("remark_ls", {
  cmd = { "remark-language-server", "--stdio" },
  filetypes = { "markdown" },
})
