return {
    "ray-x/lsp_signature.nvim", -- func signature in insert-mode
    event = "LspAttach",
    opts = {
        hint_enable = false,
        zindex = 10,
        toggle_key = "<M-x>",
        toggle_key_flip_floatwin_setting = true,
    },
}
