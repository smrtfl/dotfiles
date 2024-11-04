return {
	"nvimdev/dashboard-nvim",
	lazy = false,
	opts = function()
		local logo = {
			"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
			"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
			"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
			"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
			"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
			"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
			"                                                  ",
			"                                                  ",
			"                                                  ",
		}

		local function center_padding(logo_height)
			local win_height = vim.api.nvim_get_option("lines") - 2 -- Window height minus 2 for borders
			local padding = math.max(0, math.floor((win_height - logo_height) / 2))
			return padding
		end

		local padding_lines = center_padding(#logo)

		for _ = 1, padding_lines do
			table.insert(logo, 1, "")
		end

		local opts = {
			theme = "doom",
			hide = {
				statusline = false,
			},
			config = {
				header = logo,
				center = {
					{
						icon = "  ",
						desc = "Find File                          ",
						action = "Telescope find_files",
						key = "ff",
					},
					{
						icon = "  ",
						desc = "Find Word                          ",
						action = "Telescope live_grep",
						key = "fg",
					},
					{
						icon = "  ",
						desc = "Refresh plugins                    ",
						action = "Lazy sync",
						key = "pr",
					},
				},
				footer = {},
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
}
