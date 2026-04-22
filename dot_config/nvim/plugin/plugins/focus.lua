vim.pack.add({ "gh:nvim-focus/focus.nvim" })
require("focus").setup({
    ui = {
        signcolumn = false,
        cursorline = false,
    },
    autoresize = {
        height_quickfix = 10, -- Set the height of quickfix panel
    },
})

local ignore_filetypes = { "qf", "undotree", "aerial", "diff" }
local ignore_buftypes = { "nofile", "prompt", "popup", "quickfix" }

vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("FocusDisable", { clear = true }),
    -- pattern = ignore_filetypes,
    callback = function(_)
        if
            vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
            or vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
        then
            vim.b.focus_disable = true
        else
            vim.b.focus_disable = false
        end
    end,
    desc = "Disable focus autoresize for FileType",
})

require("utils.keymap").set("n", "<leader>df", "<cmd>FocusToggle<cr>", { desc = "Focus Toggle" })
