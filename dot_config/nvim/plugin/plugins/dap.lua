vim.pack.add({
    "gh:mfussenegger/nvim-dap",
    "gh:rcarriga/nvim-dap-ui",
    "gh:nvim-neotest/nvim-nio",
    "gh:theHamsta/nvim-dap-virtual-text",
    -- "jay-babu/mason-nvim-dap.nvim",
})
local dap = require("dap")
local ui = require("dapui")
local dap_virtext = require("nvim-dap-virtual-text")

ui.setup()
dap_virtext.setup()

vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

dap.listeners.before.attach.dapui_config = function() ui.open() end
dap.listeners.before.launch.dapui_config = function() ui.open() end
dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
dap.listeners.before.event_exited.dapui_config = function() ui.close() end
