local function w()
    require("spider").motion("w", {
        subwordMovement = false,
        customPatterns = {
            patterns = { "%)", "}", "]", ">" },
            overrideDefault = false,
        },
    })
end

local function e()
    require("spider").motion("e", {
        subwordMovement = false,
        customPatterns = {
            patterns = { "%)", "}", "]", ">" },
            overrideDefault = false,
        },
    })
end

local function b()
    require("spider").motion("b", {
        subwordMovement = false,
        customPatterns = {
            patterns = { "%( ", "{", "%[", "<" },
            overrideDefault = false,
        },
    })
end

return {
    "chrisgrieser/nvim-spider",
    keys = {
        { "w", w, mode = { "n", "o", "x" } },
        { "e", e, mode = { "n", "o", "x" } },
        { "b", b, mode = { "n", "o", "x" } },
        { "<A-f>", "<cmd>lua require('spider').motion('w')<cr>" },
        { "<A-b>", "<cmd>lua require('spider').motion('b')<cr>" },
        { "<A-f>", "<C-o><cmd>lua require('spider').motion('w')<cr>", mode = "i" },
        { "<A-b>", "<C-o><cmd>lua require('spider').motion('b')<cr>", mode = "i" },
    },
}
