local wk = require("which-key")
wk.setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	plugins = {
		marks = false, -- shows a list of your marks on ' and `
		registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
	},
})

wk.register({
	b = "Telescope Buffers",
	c = { name = "Tmux Runner" },
	e = "NvimTree",
	f = "Telescope Files",
	p = "Telescope Live Grep",
	d = { name = "Diagnostic" },
	r = {
		name = "Refactor",
		a = "Code Action",
		n = "Rename",
		f = "Format File",
		s = "Swap Param >>",
		S = "Swap Param <<",
		w = "Trailing Whitespace",
	},
	g = {
		name = "Telescope",
		r = "LSP References",
		i = "LSP Implementation",
		d = "LSP Definition",
		t = "LSP Type Definition",
		b = "Git Branches",
		c = "Git Commits",
		C = "Git BufCommits",
		s = "Git Status",
	},
	G = {
		name = "Git",
		s = "Git stage hunk",
		r = "Git reset hunk",
		S = "Git stage buffer",
		R = "Git reset buffer",
		u = "Git undo stage hunk",
		p = "Git preview hunk",
		b = "Git blame",
		B = "Git blame current line",
		d = "Git diff",
		D = "Git diff",
		x = "Git toggled deleted",
	},
	t = {
		name = "Telescope",
		c = "Commands",
		h = "Help",
		k = "Keymaps",
		m = "Marks",
		q = "Quickfix",
		s = "Spell Suggest",
		t = {
			name = "lala",
		},
	},
	x = {
		name = "Trouble",
		d = "Document Diagnostic",
		l = "Local list",
		q = "Quickfix",
		w = "Workspace Diagnostic",
		x = "Toggle",
	},
}, { prefix = "<leader>" })
