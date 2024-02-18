local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local default_config = {
	"navarasu/onedark.nvim",
	"terrortylor/nvim-comment",
	"nvim-tree/nvim-tree.lua",
	"nvim-treesitter/nvim-treesitter",
	-- "airblade/vim-gitgutter",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"windwp/nvim-autopairs",
	"easymotion/vim-easymotion",
	"akinsho/toggleterm.nvim",
	"neovim/nvim-lspconfig",
	"sbdchd/neoformat",
	"lewis6991/gitsigns.nvim",
	"NeogitOrg/neogit",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	-- vsnip
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	"lervag/vimtex",
	"richardbizik/nvim-toc",
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	"zbirenbaum/copilot-cmp",
}
local wsl_config = {
	"keaising/im-select.nvim",
}
if vim.fn.has("wsl") == 1 then
	local total_config = default_config
	for _, v in ipairs(wsl_config) do
		table.insert(total_config, v)
	end

	require("lazy").setup(total_config)
else
	require("lazy").setup(default_config)
end
