vim.cmd([[
	augroup fmt
		autocmd!
		autocmd BufWritePre * undojoin | Neoformat
	augroup END
]])

vim.cmd([[
	let g:neoformat_basic_format_retab = 1
	let g:neoformat_basic_format_trim = 1
]])

vim.cmd([[
  let g:neoformat_cpp_clanggoogle = {
		\ 'exe': 'clang-format',
		\ 'args': ['-style=Google'],
		\ 'stdin': 1,
	  \ }

  let g:neoformat_cpp_clangfile = {
		\ 'exe': 'clang-format',
		\ 'args': ['-style=file'],
		\ 'stdin': 1,
	  \ }

	let g:neoformat_enabled_cpp = ['clanggoogle']
]])

vim.cmd([[
	let g:neoformat_enabled_python = ['black']
]])

vim.cmd([[
  let g:neoformat_try_node_exe = 1
	let g:neoformat_enabled_markdown = ['remark']
]])

-- cargo install stylua
vim.g.neoformat_enabled_lua = { "stylua" }
