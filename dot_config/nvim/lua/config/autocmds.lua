-- set tab size to 4
local function set_tabstop(size)
    vim.opt_local.tabstop = size
    vim.opt_local.softtabstop = size
    vim.opt_local.shiftwidth = size
end
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("TabSizeFour", {}),
    pattern = { "python", "rust", "c", "cpp", "lua" },
    callback = function()
        set_tabstop(4)
    end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("TabSizeTwo", {}),
    pattern = { "markdown" },
    callback = function()
        set_tabstop(2)
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- set formatoptions
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("FormatOptions", {}),
    pattern = { "lua", "gitcommit" },
    callback = function()
        vim.opt_local.formatoptions = "crqnlj" -- :help fo-table
    end,
})

-- wrap text
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("TextWrap", {}),
    pattern = { "markdown", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- auto add config files to chezmoi
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("Chezmoi", {}),
    pattern = { vim.env.XDG_CONFIG_HOME .. "/**/*" },
    callback = function()
        vim.cmd([[!chezmoi add "%"]])
    end,
})
-- -- auto apply config files to $XDG_CONFIG_HOME
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     group = vim.api.nvim_create_augroup("Chezmoi", {}),
--     pattern = { vim.env.CHEZMOI_SOURCE .. "/*" },
--     callback = function(args)
--         print("CHEZMOI AUTOCMD RUNNING")
--         vim.pretty_print(args)
--         -- if args.file:match("COMMIT_EDITMSG") == nil then
--         --     vim.cmd([[!chezmoi apply --source-path "%"]])
--         -- end
--         -- local apply = function()
--         --     vim.cmd([[!chezmoi apply --source-path "%"]])
--         -- end
--         -- local success, _ = pcall(apply)
--         -- if success then
--         --     print("Sourced")
--         -- else
--         --     print("Chezmoi ERROR")
--         -- end
--     end,
-- })
-- -- chezmoi respective filetype
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--     group = vim.api.nvim_create_augroup("Chezmoi", {}),
--     pattern = "dot_zshrc",
--     callback = function()
--         vim.opt.filetype = "zsh"
--     end,
-- })

-- -- set spell on txt, md, tex, gitcommit ft
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "gitcommit", "markdown" },
-- 	callback = function()
-- 		vim.opt_local.wrap = true
-- 		vim.opt_local.spell = true
-- 	end,
-- })

-- TODO: dynamic help pane location
-- local function is_wide_win()
--   return vim.fn.winwidth(0) > 160
-- end
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "help" },
--   callback = function()
--     print("help win entered")
--     if is_wide_win() then
--       print("wide window")
--       vim.cmd([[ wincmd L ]])
--     else
--       print("narrow window")
--     end
--   end,
-- })
