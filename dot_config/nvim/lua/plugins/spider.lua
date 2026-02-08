return {
    "chrisgrieser/nvim-spider",
    keys = {
        -- { "W", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" } },
        -- { "E", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" } },
        -- { "B", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" } },
        { "w", "<cmd>lua require('spider').motion('w', {subwordMovement = false})<cr>", mode = { "n", "o", "x" } },
        { "e", "<cmd>lua require('spider').motion('e', {subwordMovement = false})<cr>", mode = { "n", "o", "x" } },
        { "b", "<cmd>lua require('spider').motion('b', {subwordMovement = false})<cr>", mode = { "n", "o", "x" } },
        { "<A-f>", "<cmd>lua require('spider').motion('w')<cr>" },
        { "<A-b>", "<cmd>lua require('spider').motion('b')<cr>" },
        { "<A-f>", "<C-o><cmd>lua require('spider').motion('w')<cr>", mode = "i" },
        { "<A-b>", "<C-o><cmd>lua require('spider').motion('b')<cr>", mode = "i" },
    },
}
