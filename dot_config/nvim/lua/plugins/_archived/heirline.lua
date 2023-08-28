return {
    "rebelot/heirline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "lewis6991/gitsigns.nvim",
    },
    event = "UiEnter",
    enabled = false,
    config = function()
        local heirline = require("heirline")
        local conditions = require("heirline.conditions")
        local utils = require("heirline.utils")

        -- Color setup
        local nord = require("utils.nord")
        local colors = {
            bright_bg = nord.c00_blk_br,
            bright_fg = nord.c01_gry,
            red = nord.c11_red,
            green = nord.c14_grn,
            blue = nord.c09_glcr,
            gray = nord.c03_gry_br,
            orange = nord.c12_orng,
            purple = nord.c15_prpl,
            cyan = nord.c08_teal,
            diag_error = nord.c11_red,
            diag_warn = nord.c13_ylw,
            diag_info = nord.c08_teal,
            diag_hint = nord.c10_blue,
            git_del = nord.c11_red,
            git_add = nord.c14_grn,
            git_change = nord.c13_ylw,
        }
        heirline.load_colors(colors)

        -- Vi Mode
        local ViMode = {
            -- get vim current mode, this information will be required by the provider
            -- and the highlight functions, so we compute it only once per component
            -- evaluation and store it as a component attribute
            init = function(self)
                self.mode = vim.fn.mode(1) -- :h mode()
            end,
            -- Now we define some dictionaries to map the output of mode() to the
            -- corresponding string and color. We can put these into `static` to compute
            -- them at initialisation time.
            static = {
                mode_names = { -- change the strings if you like it vvvvverbose!
                    n = "N",
                    no = "N?",
                    nov = "N?",
                    noV = "N?",
                    ["no\22"] = "N?",
                    niI = "Ni",
                    niR = "Nr",
                    niV = "Nv",
                    nt = "Nt",
                    v = "V",
                    vs = "Vs",
                    V = "V_",
                    Vs = "Vs",
                    ["\22"] = "^V",
                    ["\22s"] = "^V",
                    s = "S",
                    S = "S_",
                    ["\19"] = "^S",
                    i = "I",
                    ic = "Ic",
                    ix = "Ix",
                    R = "R",
                    Rc = "Rc",
                    Rx = "Rx",
                    Rv = "Rv",
                    Rvc = "Rv",
                    Rvx = "Rv",
                    c = "C",
                    cv = "Ex",
                    r = "...",
                    rm = "M",
                    ["r?"] = "?",
                    ["!"] = "!",
                    t = "T",
                },
                mode_colors = {
                    n = "red",
                    i = "green",
                    v = "cyan",
                    V = "cyan",
                    ["\22"] = "cyan",
                    c = "orange",
                    s = "purple",
                    S = "purple",
                    ["\19"] = "purple",
                    R = "orange",
                    r = "orange",
                    ["!"] = "red",
                    t = "red",
                },
            },
            -- We can now access the value of mode() that, by now, would have been
            -- computed by `init()` and use it to index our strings dictionary.
            -- note how `static` fields become just regular attributes once the
            -- component is instantiated.
            -- To be extra meticulous, we can also add some vim statusline syntax to
            -- control the padding and make sure our string is always at least 2
            -- characters long. Plus a nice Icon.
            provider = function(self)
                return "  %2(" .. self.mode_names[self.mode] .. "%)"
            end,
            -- Same goes for the highlight. Now the foreground will change according to the current mode.
            hl = function(self)
                local mode = self.mode:sub(1, 1) -- get only the first mode character
                return { fg = self.mode_colors[mode], bold = true }
            end,
            -- Re-evaluate the component only on ModeChanged event!
            -- Also allows the statusline to be re-evaluated when entering operator-pending mode
            update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                    vim.cmd("redrawstatus")
                end),
            },
        }

        -- File Name
        local FileNameBlock = {
            -- let's first set up some attributes needed by this component and it's children
            init = function(self)
                self.filename = vim.api.nvim_buf_get_name(0)
            end,
        }
        -- We can now define some children separately and add them later

        local FileIcon = {
            init = function(self)
                local filename = self.filename
                local extension = vim.fn.fnamemodify(filename, ":e")
                self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
            end,
            provider = function(self)
                return self.icon and (self.icon .. " ")
            end,
            hl = function(self)
                return { fg = self.icon_color }
            end,
        }

        local WorkDir = {
            init = function(self)
                local cwd = vim.fn.getcwd(0)
                self.cwd = vim.fn.fnamemodify(cwd, ":~")
            end,
            hl = { fg = "blue", bold = true },

            flexible = 1,

            {
                -- evaluates to the full-length path
                provider = function(self)
                    local trail = self.cwd:sub(-1) == "/" and "" or "/"
                    return self.cwd .. trail
                end,
            },
            {
                -- evaluates to the shortened path
                provider = function(self)
                    local cwd = vim.fn.pathshorten(self.cwd)
                    local trail = self.cwd:sub(-1) == "/" and "" or "/"
                    return cwd .. trail
                end,
            },
            {
                -- evaluates to "", hiding the component
                provider = "",
            },
        }

        local FileName = {
            provider = function(self)
                -- first, trim the pattern relative to the current directory. For other
                -- options, see :h filename-modifers
                local filename = vim.fn.fnamemodify(self.filename, ":.")
                if filename == "" then
                    return "[No Name]"
                end
                return filename
            end,
            hl = { fg = utils.get_highlight("Directory").fg },
        }

        local FileFlags = {
            {
                condition = function()
                    return vim.bo.modified
                end,
                provider = "[+]",
                hl = { fg = "green" },
            },
            {
                condition = function()
                    return not vim.bo.modifiable or vim.bo.readonly
                end,
                provider = "",
                hl = { fg = "orange" },
            },
        }

        -- Now, let's say that we want the filename color to change if the buffer is
        -- modified. Of course, we could do that directly using the FileName.hl field,
        -- but we'll see how easy it is to alter existing components using a "modifier"
        -- component
        local FileNameModifer = {
            hl = function()
                if vim.bo.modified then
                    -- use `force` because we need to override the child's hl foreground
                    return { fg = "cyan", bold = true, force = true }
                end
            end,
        }

        -- let's add the children to our FileNameBlock component
        FileNameBlock = utils.insert(
            FileNameBlock,
            FileIcon,
            WorkDir,
            utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
            FileFlags,
            { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
        )

        local Diagnostics = {
            condition = conditions.has_diagnostics,
            static = {
                error_icon = " ",
                warn_icon = " ",
                info_icon = " ",
                hint_icon = " ",
            },
            init = function(self)
                self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            end,
            update = { "DiagnosticChanged", "BufEnter" },
            {
                provider = function(self)
                    -- 0 is just another output, we can decide to print it or not!
                    return self.errors > 0 and (self.error_icon .. self.errors .. " ")
                end,
                hl = { fg = "diag_error" },
            },
            {
                provider = function(self)
                    return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
                end,
                hl = { fg = "diag_warn" },
            },
            {
                provider = function(self)
                    return self.info > 0 and (self.info_icon .. self.info .. " ")
                end,
                hl = { fg = "diag_info" },
            },
            {
                provider = function(self)
                    return self.hints > 0 and (self.hint_icon .. self.hints)
                end,
                hl = { fg = "diag_hint" },
            },
        }

        local Git = {
            condition = conditions.is_git_repo,
            init = function(self)
                ---@diagnostic disable-next-line: undefined-field
                self.status_dict = vim.b.gitsigns_status_dict
                self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
            end,

            hl = { fg = "orange" },

            { -- git branch name
                provider = function(self)
                    return " " .. self.status_dict.head
                end,
                hl = { bold = true },
            },
            {
                provider = function(self)
                    local count = self.status_dict.added or 0
                    return count > 0 and (" " .. count)
                end,
                hl = { fg = "git_add" },
            },
            {
                provider = function(self)
                    local count = self.status_dict.removed or 0
                    return count > 0 and (" " .. count)
                end,
                hl = { fg = "git_del" },
            },
            {
                condition = function(self)
                    return self.has_changes
                end,
                provider = " ",
            },
        }

        local LSPActive = {
            condition = conditions.lsp_attached,
            update = { "LspAttach", "LspDetach" },

            -- Or complicate things a bit and get the servers names
            provider = function()
                local res = " "
                for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                    if server.name == "copilot" then
                        res = " " .. res
                    end
                end
                return res
            end,
            hl = { fg = "green", bold = true },
        }

        local FileType = {
            provider = function()
                return string.upper(vim.bo.filetype)
            end,
            hl = { fg = utils.get_highlight("Type").fg, bold = true },
        }

        local Ruler = {
            -- %l = current line number
            -- %L = number of lines in the buffer
            -- %c = column number
            -- %P = percentage through file of displayed window
            provider = "%7(%l/%3L%):%2c %P",
        }
        -- I take no credits for this! :lion:
        local ScrollBar = {
            static = {
                sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
                -- Another variant, because the more choice the better.
                -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
            },
            provider = function(self)
                local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                local lines = vim.api.nvim_buf_line_count(0)
                local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
                return string.rep(self.sbar[i], 2)
            end,
            hl = { fg = "blue", bg = "bright_bg" },
        }

        local Align = { provider = "%=" }
        local Space = { provider = " " }

        local HelpFileName = {
            condition = function()
                return vim.bo.filetype == "help"
            end,
            provider = function()
                local filename = vim.api.nvim_buf_get_name(0)
                return vim.fn.fnamemodify(filename, ":t")
            end,
            hl = { fg = colors.blue },
        }

        ViMode = utils.surround({ " ", " " }, "bright_bg", { ViMode })

        -- stylua: ignore start
        local DefaultStatusline = {
            ViMode, Space, FileNameBlock, Space, Diagnostics, Git, Space, Align, Align,
            LSPActive, Space, Space, Space, FileType, Space, Ruler, Space, ScrollBar,
        }
        local InactiveStatusline = {
            condition = conditions.is_not_active,
            FileType, Space, FileName, Align,
        }
        -- local SpecialStatusline = {
        --     condition = function()
        --         return conditions.buffer_matches({
        --             buftype = { "nofile", "prompt", "help", "quickfix" },
        --             filetype = { "^git.*", "fugitive" },
        --         })
        --     end,
        --     FileType, Space, HelpFileName, Align,
        -- }
        local StatusLines = {
            hl = function()
                if conditions.is_active() then
                    return "StatusLine"
                else
                    return "StatusLineNC"
                end
            end,
            -- the first statusline with no condition, or which condition returns true is used.
            -- think of it as a switch case with breaks to stop fallthrough.
            fallthrough = false,
            -- SpecialStatusline,
            InactiveStatusline, DefaultStatusline,
        }
        -- stylua: ignore end

        heirline.setup({
            statusline = StatusLines,
        })
    end,
}
