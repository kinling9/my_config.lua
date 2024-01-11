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
require("lazy").setup({
	"navarasu/onedark.nvim",
	"nvim-tree/nvim-tree.lua",
	"nvim-treesitter/nvim-treesitter",
	-- "airblade/vim-gitgutter",
	"terrortylor/nvim-comment",
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
	"keaising/im-select.nvim",
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	"lervag/vimtex",
})
