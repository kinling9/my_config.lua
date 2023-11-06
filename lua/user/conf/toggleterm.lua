require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	direction = "float"
})

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end
