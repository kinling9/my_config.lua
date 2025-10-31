local cmp_nvim_lsp = require("cmp_nvim_lsp")

vim.lsp.config("clangd", {
  on_attach = on_attch,
  capabilities = cmp_nvim_lsp.default_capabilities(),
  cmd = {
    "clangd",
    '--query-driver="/usr/bin/gcc, /usr/bin/g++"',
    "--offset-encoding=utf-16",
  },
  filetypes = { "c", "cpp", "h", "hpp" },
})
