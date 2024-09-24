return {
	"mfussenegger/nvim-lint",

	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			kotlin = { "ktlint" },
			python = { "flake8", "pylint" },
			ruby = { "rubocop" },
			php = { "phpcs" },
			java = { "checkstyle" },
			c = { "cpplint" },
			cpp = { "cpplint" },
			go = { "golangci-lint" },
			lua = { "luacheck" },
			html = { "htmlhint" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			vue = { "eslint_d" },
			markdown = { "markdownlint" },
			terraform = { "tflint" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
			dockerfile = { "hadolint" },
			helm = { "helm_lint" },
			sql = { "sqlfluff" },
			sh = { "shellcheck" },
		}

		require("lint").linters.helm_lint = {
			cmd = "helm",
			args = { "lint", "-" },
			stdin = true,
			experimental = true,
		}

		require("lint").linters.pylint = {
			cmd = "pylint",
			args = {
				"--disable=C0114",
				"--disable=C0115",
				"--disable=C0116",
			},
		}

		require("lint").linters.eslint_d = {
			cmd = "eslint_d",
			args = {
				"--no-warn-ignored",
				"--format",
				"json",
				"--stdin",
				"--stdin-filename",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
			},
			stdin = true,
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end)
	end,
}
