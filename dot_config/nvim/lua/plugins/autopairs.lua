return {
    "windwp/nvim-autopairs",
    dir = "~/Workspace/projects/contribute/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        check_ts = true,
        ts_config = {},
        fast_wrap = {
            map = "<C-f>",
            chars = { "{", "[", "(", "<", '"', "'", "`" },
            pattern = [=[[%'%"%>%]%)%}%,%?%;:]]=],
            keys = "wftmneiokhluyrpsgdzxacv", -- no b,j,q
            before_key = "k",
            after_key = "h",
            end_key = "$",
            -- manually decide where (before/after) to insert the endpair
            manual_position = false, -- default: true
            -- cursor position to be before/after the endpair when moving with capital key
            cursor_pos_before = false,
            -- when `manual_position` is false, whether to move cursor when `end_key` is pressed
            avoid_move_to_end = true, -- stay for direct end_key use
            highlight = "CurSearch", -- default: "Search"
        },
        enable_check_bracket_line = false, -- dont change
        enable_moveright = true, -- (|) press ) ()|
        enable_abbr = true,
    },
    config = function(_, opts)
        local ap = require("nvim-autopairs")
        ap.setup(opts)
        require("config.autopairs")
    end,
}
