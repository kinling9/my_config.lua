require('nvim_comment').setup()

vim.cmd([[
	augroup set-commentstring-ag
	autocmd!
	autocmd BufEnter *.cc,*.cpp,*.h,*.hh :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
	autocmd BufFilePost *.cc,*.cpp,*.h,*.hh :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
	augroup END
]])
