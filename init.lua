if vim.g.vscode then
	-- VSCode extension
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
else
	-- ordinary Neovim
	require("user.plugins")
	require("user.options")
	require("user.keymaps")
	require("user.confs")
end
