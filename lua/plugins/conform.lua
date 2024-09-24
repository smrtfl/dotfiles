return {
	"stevearc/conform.nvim",

	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				["*"] = { "trim_whitespace" },

				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				vue = { "prettier" },

				lua = { "stylua" },
				kotlin = { "ktfmt" },
				python = { "black" },
				ruby = { "rufo" },
				php = { "php-cs-fixer" },
				java = { "google-java-format" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				cs = { "csharpier" },
				go = { "gofumt", "goimports", "goimports-reviser", "golines" },
				rust = { "rustfmt" },
				terraform = { "terraform_fmt" },

				gradle = { "ktfmt" },

				shell = { "shfmt" },
				bash = { "shfmt" },

				yaml = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				xml = { "prettier" },

				dockerfile = { "dockerfile-format" },
				dockercompose = { "dockerfile-format" },

				sql = { "sqlfmt" },
				helm = { "helm" },
				nginx = { "nginxbeautifier" },

				lsp_fallback = true,
				timeout_ms = 500,
			},

			formatters = {
				black = {
					prepend_args = { "--line-length", "79" },
				},
			},

			format_on_save = true,
		})

		vim.keymap.set({ "n", "v" }, "<leader>c", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end)
	end,
}
