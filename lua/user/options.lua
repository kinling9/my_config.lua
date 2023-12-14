local options = {
	clipboard = "unnamedplus",
	cmdheight = 1,
	showmode = true,
	conceallevel = 0,
	termguicolors = true,
	mouse = "a",
	fileencoding = "utf-8",
	ignorecase = true,
	smartcase = true,
	smartindent = true,
	cindent = true,
	autoindent = true,
	tabstop = 2,
	shiftwidth = 2,
	number = true,
	relativenumber = true,
	showtabline = 2,
	wrap = false,
	cursorline = true,
	cursorcolumn = false,
	showcmd = true,
	expandtab = true,
}

vim.opt.shortmess:append("c")
for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")

vim.cmd([[
	syntax on
	colorscheme onedark
]])

if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
	}
end

require("lspconfig").clangd.setup({
	-- on_attach = lsphandler.on_attach,
	-- capabilities = lsphandler.capabilities,
	cmd = {
		"clangd",
		'--query-driver="/usr/bin/gcc, /usr/bin/g++"',
	},
	filetypes = { "c", "cpp", "h", "hpp" },
})

require("lspconfig").remark_ls.setup({
	cmd = { "remark-language-server", "--stdio" },
	filetypes = { "markdown" },
})
