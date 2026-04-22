vim.pack.add({ "gh:chrisgrieser/nvim-spider" })

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
            patterns = { "%)", "}", "]", ">", "," },
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

local function ge()
    require("spider").motion("ge", {
        subwordMovement = false,
        customPatterns = {
            patterns = { "%( ", "{", "%[", "<" },
            overrideDefault = false,
        },
    })
end

local set = require("utils.keymap").set
set("nxo", "w", w)
set("nxo", "e", e)
set("nxo", "b", b)
set("nxo", "ge", ge)
set("n", "<A-f>", "<cmd>lua require('spider').motion('w')<cr>")
set("n", "<A-b>", "<cmd>lua require('spider').motion('b')<cr>")
set("i", "<A-f>", "<C-o><cmd>lua require('spider').motion('w')<cr>")
set("i", "<A-b>", "<C-o><cmd>lua require('spider').motion('b')<cr>")
