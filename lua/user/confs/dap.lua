return function()
  local dap, dapui = require("dap"), require("dapui")
  require("dap-python").setup("python")
  require("dap-lldb").setup("cpp")
  require("dapui").setup()
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
  vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
  vim.keymap.set("n", "<Leader>dc", dap.continue, {})
end