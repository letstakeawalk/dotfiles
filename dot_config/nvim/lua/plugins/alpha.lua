return {
	"goolord/alpha-nvim",
  event = "VimEnter",
	config = function()
		local alpha = require("alpha")

		-- TODO: add button menus

		local function header_hl_today()
			local wday = os.date("*t").wday
			local colors = { "Keyword", "Constant", "Number", "Type", "String", "Special", "Function" }
			return colors[wday]
		end

		local section_header = {
			type = "text",
			val = {
				[[  ██████   █████                   █████   █████  ███                  ]],
				[[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
				[[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
				[[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
				[[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
				[[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
				[[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
				[[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
			},
			opts = {
				position = "center",
				hl = header_hl_today(),
			},
		}

		local function info_text()
			---@diagnostic disable-next-line:undefined-field
			local total_plugins = require("lazy").stats().count
			local datetime = os.date(" %Y-%m-%d  󰨳 %A")
			local version = vim.version()
			---@diagnostic disable-next-line:need-check-nil
			local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

			return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
		end

		local section_info = {
			type = "text",
			val = info_text(),
			opts = {
				hl = "Comment",
				position = "center",
			},
		}

		local function shortcuts()
			local keybind_opts = { silent = true, noremap = true }
			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = { "AlphaReady" },
				callback = function(_)
					vim.api.nvim_buf_set_keymap(0, "n", "n", "<cmd>enew<cr>", keybind_opts)
					vim.api.nvim_buf_set_keymap(0, "n", "p", "<cmd>Telescope projects<CR>", keybind_opts)
					vim.api.nvim_buf_set_keymap(0, "n", "t", "<cmd>TodoTelescope<CR>", keybind_opts)
					vim.api.nvim_buf_set_keymap(0, "n", "s", "<cmd>e $MYVIMRC<CR>", keybind_opts)
				end,
			})
			return {
				{
					type = "text",
					val = {
						" New File [n]     Project [p]     Todo [t]     Settings [s]",
					},
					opts = {
						position = "center",
						hl = {
							{ "Function", 1, 19 },
							{ "Keyword", 19, 36 },
							{ "String", 36, 56 },
							{ "Number", 56, 80 },
							-- { "Constant", 64, 80 },
						},
					},
				},
			}
		end

		local section_shortcuts = { type = "group", val = shortcuts }

		local config = {
			layout = {
				{ type = "padding", val = 8 },
				section_header,
				{ type = "padding", val = 2 },
				section_shortcuts,
				{ type = "padding", val = 1 },
				section_info,
			},
		}

		alpha.setup(config)
	end,
}

-- reference
-- https://github.com/AllanChain/custom-chad/blob/main/plugins/alpha.lua
