local winborder = vim.o.winborder
local function toggle_zen()
    vim.o.winborder = "none"
    require("zen-mode").toggle()
end
return {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    keys = {
        { "<leader>dz", toggle_zen, desc = "ZenMode" },
    },
    opts = {
        window = {
            backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
            width = 100, -- width of the Zen window
            height = 1, -- height of the Zen window
            options = {
                signcolumn = "yes",
                number = true,
                relativenumber = true,
                cursorline = true,
            },
        },
        plugins = {
            -- disable some global vim options (vim.o...)
            -- comment the lines to not apply the options
            options = {
                enabled = true,
                ruler = false, -- disables the ruler text in the cmd line area
                showcmd = true, -- disables the command in the last line of the screen
                -- you may turn on/off statusline in zen mode by setting 'laststatus'
                -- statusline will be shown only if 'laststatus' == 3
                laststatus = 3, -- turn off the statusline in zen mode
            },
            twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
            gitsigns = { enabled = false }, -- disables git signs
            tmux = { enabled = false }, -- disables the tmux statusline}
        },
        on_close = function()
            vim.o.winborder = winborder
        end,
    },
}
