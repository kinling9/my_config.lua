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
require("lazy").setup(	{"navarasu/onedark.nvim",
"nvim-tree/nvim-tree.lua",
"nvim-treesitter/nvim-treesitter",
"airblade/vim-gitgutter",
"terrortylor/nvim-comment",
"nvim-lua/plenary.nvim",
"nvim-telescope/telescope.nvim",
"windwp/nvim-autopairs",
"easymotion/vim-easymotion",
"akinsho/toggleterm.nvim",
"akinsho/toggleterm.nvim",
"neovim/nvim-lspconfig",
"sbdchd/neoformat"})