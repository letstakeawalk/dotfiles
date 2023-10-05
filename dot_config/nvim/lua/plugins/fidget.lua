return {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    tag = "legacy",
    init = function()
        vim.api.nvim_set_hl(0, "FidgetTitle", { link = "Variable" })
        vim.api.nvim_set_hl(0, "FidgetTask", { link = "Comment" })
    end,
    opts = {
        window = { blend = 0 },
    },
}
