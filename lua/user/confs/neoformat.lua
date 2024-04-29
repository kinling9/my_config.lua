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

-- cargo install stylua
vim.g.neoformat_enabled_lua = { "stylua" }

vim.g.neoformat_enabled_markdown = { "denofmt" }

vim.cmd([[
  let g:neoformat_bib_bibtextidysort = {
		\ 'exe': 'bibtex-tidy',
		\ 'args': ['--sort=type,-year,name', '--sort-fields', '--blank-lines'],
		\ 'stdin': 1,
	  \ }
]])

vim.g.neoformat_enabled_bib = { "bibtextidysort" }
vim.g.latexindent = "-m"
vim.cmd([[
  let g:neoformat_tex_latexindentoverwrite = {
    \ 'exe': 'latexindent',
    \ 'stdin': 0,
    \ }
]])

vim.g.neoformat_enabled_tex = { "latexindentoverwrite" }
