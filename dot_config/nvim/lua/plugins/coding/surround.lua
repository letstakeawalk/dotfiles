-- surround word with '"([ <tag>, etc
return {
    "kylechui/nvim-surround",
    event = "BufRead",
    -- TODO: https://github.com/kylechui/nvim-surround/discussions/53
    config = function()
        local surround = require("nvim-surround")
        local utils = require("nvim-surround.config")

        ---@diagnostic disable: missing-fields
        surround.setup({
            surrounds = {
                -- consider making a PR. maybe common use case
                ["g"] = {
                    add = function()
                        local result = utils.get_input("Enter the type name: ")
                        if result and #result > 0 then
                            return { { result .. "<" }, { ">" } }
                        end
                    end,
                    find = function() return utils.get_selection({ pattern = "[%w%-_]+%b<>" }) end,
                    delete = "^(.-<)().-(>)()$", -- regex pattern
                    change = {
                        target = "^.-([%w_]+)()<.->()()$", -- regex pattern
                        replacement = function()
                            local result = utils.get_input("Enter the type name: ")
                            if result then
                                return { { result }, { "" } }
                            end
                        end,
                    },
                },
                ["F"] = {
                    add = function()
                        local ft = vim.bo.filetype
                        if ft == "lua" then
                            return { { "function() " }, { " end" } }
                        else
                            vim.notify("No function-surround defined for " .. ft)
                        end
                    end,
                    -- find = function() return utils.get_selection({ motion = "af" }) end,
                    find = function()
                        local ft = vim.bo.filetype
                        if ft == "lua" then
                            return utils.get_selection({ pattern = "function%(.-%).-end" })
                        else
                            vim.notify("No function-surround defined for " .. ft)
                        end
                    end,
                    delete = function()
                        local ft = vim.bo.filetype
                        local pattern
                        if ft == "lua" then
                            pattern = "^(function%(.-%)%s*)().-(%s*end)()$"
                        else
                            vim.notify("No function-surround defined for " .. ft)
                            pattern = "()()()()"
                        end
                        return utils.get_selections({
                            char = "F",
                            pattern = pattern,
                        })
                    end,
                },
            },
            move_cursor = false,
        })
    end,
}
