require("lspconfig").remark_ls.setup({
	cmd = { "remark-language-server", "--stdio" },
	filetypes = { "markdown" },
})
