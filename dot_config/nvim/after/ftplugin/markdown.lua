-- vim.notify("FileType Markdown", vim.log.levels.WARN)
-- vim.bo.formatoptions = "tcqnlj"
vim.bo.formatoptions = "tcqj"
-- vim.wo.wrap = true

-- task management
local task = require("utils.task")
vim.keymap.set("i", "<C-x>", task.toggle_completion, { desc = "Toggle Task", buffer = true })
-- vim.keymap.set("n", "<leader>nx", task.toggle_task, { desc = "Toggle List/Task", buffer = true })
vim.keymap.set("n", "<leader>nax", task.toggle_completion, { desc = "Toggle Task", buffer = true })
vim.keymap.set("n", "<leader>nac", task.toggle_canceled, { desc = "Set Canceled Tag", buffer = true })
vim.keymap.set("n", "<leader>nas", task.toggle_started, { desc = "Set Started Tag", buffer = true })
vim.keymap.set("n", "<leader>nad", task.toggle_due, { desc = "Set Due Date", buffer = true })
vim.keymap.set("n", "<leader>naS", task.toggle_scheduled, { desc = "Set Scheduled Date", buffer = true })
vim.keymap.set("n", "<leader>nap", task.toggle_priority, { desc = "Set Priority", buffer = true })
vim.keymap.set("n", "<leader>nar", task.toggle_project, { desc = "Set Project", buffer = true })

-- TODO: formatlistpattern for lists & tasks
-- vim.cmd("set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|\\s*[-+*]\\(\\s\\[[^]]\\]\\)\\?\\s\\+")
-- vim.opt_local.formatlistpat="\\"
-- vim.cm("set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|\\s*[-+*]\\(\\s\\[[^]]\\]\\)\\?\\s\\+")
-- ^\\s*\\d\\+\\.\\s\\+
-- \\|
-- ^\\s*[-+*]\\s\\+
-- \\|
-- ^\\s*[-+*]\\s\\[[^]]\\]
vim.bo.formatlistpat = [[^\s*\d\+\.\s\+|\s*[-+*]\s\+]]

-- formatlistpat=
-- ^\s*\d\+\.\s\+  \|
-- ^\s*[-*+]\s\+   \|
-- ^\[^\ze[^\]]\+\]:\&^.\{4\}
