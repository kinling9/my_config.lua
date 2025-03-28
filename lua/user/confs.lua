require("user.confs.nvim_tree")
require("user.confs.nvim_comment")
require("user.confs.nvim_autopairs")
require("user.confs.nvim_treesitter")
require("user.confs.toggleterm")
-- require("user.confs.neoformat")
require("user.confs.nvim_cmp")
require("user.confs.gitsigns")
require("user.confs.neogit")
require("user.confs.nvim_treesitter")
-- if vim.fn.has("wsl") == 1 then
-- 	require("user.confs.im_select")
-- end
-- require("user.confs.im_select")
if vim.fn.has("wsl") == 0 then
  require("user.confs.markdown_preview")
end
require("user.confs.vimtex")
require("user.confs.nvim_toc")
require("user.confs.copilot")
require("user.confs.easymotion")
