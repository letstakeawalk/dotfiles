local utils = require("utils")

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        vim.print("name: " .. name .. " / kind: " .. kind)
    end,
})
-- Resize splits on vim resize
vim.api.nvim_create_autocmd("VimResized", {
    desc = "Resize splits on vim resize",
    group = vim.api.nvim_create_augroup("ResizeSplits", { clear = true }),
    callback = function() vim.cmd.tabdo("wincmd =") end,
})

-- Close buffer with `q`
vim.api.nvim_create_autocmd("FileType", {
    desc = "Close buffer with `q`",
    group = vim.api.nvim_create_augroup("QClose", { clear = true }),
    pattern = {
        "gitsigns-blame",
        "fugitive",
        "qf",
        "help",
        "man",
        "query",
        "harpoon",
    },
    callback = function(ev)
        vim.keymap.set("n", "q", "<cmd>bwipe<cr>", { buf = ev.buf, silent = true })
    end,
})

-- Close fugitive blob buffers with `q` (preserves window layout)
vim.api.nvim_create_autocmd("FileType", {
    desc = "Close fugitive blob buffers with `q` (preserves window layout)",
    group = vim.api.nvim_create_augroup("QCloseFugitiveBlob", { clear = true }),
    pattern = "git",
    callback = function(ev)
        local has_fugitive_win = false
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            if buf ~= ev.buf and vim.bo[buf].filetype == "fugitive" then
                has_fugitive_win = true
                break
            end
        end
        if not has_fugitive_win then return end
        vim.keymap.set("n", "q", "<cmd>BWipe<cr>", { buf = ev.buf, silent = true })
    end,
})

-- Smart window position: Open in vertical if screen is wide enough
vim.api.nvim_create_autocmd("BufWinEnter", {
    desc = "Smart window position: Open in vertical if screen is wide enough",
    group = vim.api.nvim_create_augroup("SmartWinPos", { clear = true }),
    pattern = { "fugitive://*//*", "*COMMIT_EDITMSG", "*/doc/*" },
    callback = function(ev)
        local target_fts = { "fugitive", "help", "gitcommit", "git" }
        local ft = vim.bo[ev.buf].filetype
        if not vim.list_contains(target_fts, ft) then return end
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if ev.buf == vim.api.nvim_win_get_buf(win) then
                local win_w = vim.api.nvim_win_get_width(win)
                local vim_w = vim.o.columns
                if vim_w >= 160 and win_w > math.floor(vim_w / 2) then
                    vim.cmd.wincmd("L")
                elseif win_w < 80 then
                    vim.cmd.wincmd("J")
                end
            end
        end
    end,
})

-- Set foldmethod=indent for karabiner.edn (overrides Telescope's foldmethod=expr)
vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Set foldmethod=indent for karabiner.edn (overrides Telescope's foldmethod=expr)",
    group = vim.api.nvim_create_augroup("KarabinerFold", { clear = true }),
    pattern = "*/goku/karabiner.edn",
    callback = function() vim.opt_local.foldmethod = "indent" end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Auto create dir when saving a file, in case some intermediate directory does not exist",
    group = vim.api.nvim_create_augroup("AutoCreateDir", { clear = true }),
    callback = function(event)
        if event.match:match("^%w%w+://") then return end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Open Oil file explorer if nvim is started with a directory as the argument.
vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Open Oil file explorer if nvim is started with a directory as the argument.",
    group = vim.api.nvim_create_augroup("OpenOilOnDir", { clear = true }),
    callback = function()
        if vim.fn.argc() ~= 1 then return end
        local dir = vim.fn.argv(0) --[[@as string]]
        if vim.fn.isdirectory(dir) == 1 then
            require("oil").open(dir)
            -- pcall(vim.cmd([[bdelete #]])) -- optional: close the default 'No Name' buffer
        end
    end,
    once = true,
})

local home = os.getenv("HOME") --[[@as string]]
local chez_src = os.getenv("CHEZMOI_SOURCE") --[[@as string]]

-- Auto add managed files to chezmoi on save
vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Auto add managed files to chezmoi on save",
    group = vim.api.nvim_create_augroup("ChezmoiAdd", { clear = true }),
    pattern = {
        string.format("%s/.config/**/*", home),
        string.format("%s/.local/script/*", home),
        string.format("%s/.claude/skills/**/*", home),
        string.format("%s/.claude/rules/**/*", home),
        string.format("%s/.claude/agents/**/*", home),
        string.format("%s/.claude/hooks/**/*", home),
    },
    callback = function(ev)
        if ev.file:match("COMMIT_EDITMSG$") or ev.file:match("git-rebase-merge$") then return end
        local fname = ev.match:gsub(home, "~")
        local rel = ev.match:gsub(home .. "/", "")
        local ignored = vim.fn.system({ "chezmoi", "ignored" })
        for line in ignored:gmatch("[^\n]+") do
            if rel == line or rel:find("^" .. vim.pesc(line) .. "/") then return end
        end
        local is_managed = #vim.fn.system({ "chezmoi", "managed", ev.match }) ~= 0

        local function chezmoi_add()
            local result = vim.fn.system({ "chezmoi", "add", ev.match })
            if vim.v.shell_error == 0 then
                vim.notify(
                    fname,
                    vim.log.levels.INFO,
                    { key = "Chezmoi", annote = "Chezmoi added" }
                )
            else
                vim.notify(
                    result,
                    vim.log.levels.ERROR,
                    { key = "Chezmoi", annote = "Chezmoi add failed" }
                )
            end
        end

        if is_managed then chezmoi_add() end
    end,
})

-- Auto apply chezmoi source to target on save
vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Auto apply chezmoi source to target on save",
    group = vim.api.nvim_create_augroup("ChezmoiApply", { clear = true }),
    pattern = string.format("%s/**/*", chez_src),
    callback = function(args)
        local excluded_filetypes = { "gitcommit", "gitrebase" }
        if vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then return end
        local rel = args.match:gsub(chez_src .. "/", "")
        local ignored = vim.fn.system({ "chezmoi", "ignored" })
        for line in ignored:gmatch("[^\n]+") do
            if rel == line or rel:find("^" .. vim.pesc(line) .. "/") then return end
        end
        local result = vim.fn.system({ "chezmoi", "apply", "--source-path", args.match })
        if vim.v.shell_error == 0 then
            local fname = args.match:gsub(chez_src .. "/", "")
            vim.notify(fname, vim.log.levels.INFO, { key = "Chezmoi", annote = "Chezmoi applied" })
        else
            vim.notify(
                result,
                vim.log.levels.ERROR,
                { key = "Chezmoi", annote = "Chezmoi apply failed" }
            )
        end
    end,
})
