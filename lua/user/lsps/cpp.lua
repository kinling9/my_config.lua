require("lspconfig").clangd.setup({
	-- on_attach = lsphandler.on_attach,
	-- capabilities = lsphandler.capabilities,
	cmd = {
		"clangd",
		'--query-driver="/usr/bin/gcc, /usr/bin/g++"',
	},
	filetypes = { "c", "cpp", "h", "hpp" },
})
