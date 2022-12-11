local ns = require("neoscroll")
ns.setup({
	-- TODO: Center after animation -- https://github.com/karb94/neoscroll.nvim/issues/65
	-- post_hook = function(info)
	-- 	print("post-hook")
	-- 	-- ns.zz(250)
	-- end,
	mappings = {},
})

local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", 200 } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", 200 } }
t["zt"] = { "zt", { 150 } }
t["zz"] = { "zz", { 150 } }
t["zb"] = { "zb", { 150 } }

require("neoscroll.config").set_mappings(t)
-- defaults
--  Key     Function ~
-- <C-u>    scroll(-vim.wo.scroll, true, 350)
-- <C-d>    scroll( vim.wo.scroll, true, 350)
-- <C-b>    scroll(-vim.api.nvim_win_get_height(0), true, 550)
-- <C-f>    scroll( vim.api.nvim_win_get_height(0), true, 550)
-- <C-y>    scroll(-0.10, false, 100)
-- <C-e>    scroll( 0.10, false, 100)
--  zt      zt(200)
--  zz      zz(200)
--  zb      zb(200)
