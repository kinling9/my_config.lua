local options = {
  clipboard = 'unnamedplus', 
  cmdheight = 1,
  showmode = true, 
  conceallevel = 0,
  termguicolors = true, 
  mouse = 'a', 
  fileencoding = 'utf-8', 
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

vim.opt.shortmess:append 'c'
for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"

-- vim.cmd([[
-- 	syntax on
-- 	colorscheme onedark
-- ]])

vim.cmd([[
	augroup set-commentstring-ag
	autocmd!
	autocmd BufEnter *.cc,*.cpp,*.h,*.hh,*.hpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
	autocmd BufFilePost *.cc,*.cpp,*.h,*.hh,*.hpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
	augroup END
]])

if vim.fn.has "wsl" == 1 then
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

vim.lsp.start({
   name = 'lsp-clangd',
   cmd = {'clangd'},
   -- root_dir = vim.fs.dirname(vim.fs.find({'configure'}, { upward = true })[1]),
})

require('lspconfig').clangd.setup{
  -- on_attach = lsphandler.on_attach,
  -- capabilities = lsphandler.capabilities,
  cmd = {
    "clangd",
    '--query-driver="/usr/bin/gcc, /usr/bin/g++"',
  },
  filetypes = { "c", "cpp", "h", "hpp"},
}
