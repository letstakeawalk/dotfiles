return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        local utils = require("nvim-surround.config")
        require("nvim-surround").setup({
            surrounds = {
                -- Generic Type
                ["g"] = {
                    add = function()
                        local result = utils.get_input("Enter the type name: ")
                        if result and #result > 0 then
                            return { { result .. "<" }, { ">" } }
                        end
                    end,
                    find = function()
                        return utils.get_selection({ pattern = "[%w_]+%b<>" })
                    end,
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
                -- Surround with function
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
