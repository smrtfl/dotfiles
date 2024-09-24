local two_space_languages = {
	"lua",
	"javascript",
	"typescript",
	"typescriptreact",
	"javascriptreact",
	"json",
	"yaml",
	"html",
	"css",
	"xml",
	"vue",
	"vim",
	"swift",
	"scala",
	"dart",
	"svelte",
	"closure",
}

for _, lang in ipairs(two_space_languages) do
	vim.api.nvim_create_autocmd("FileType", {
		pattern = lang,
		callback = function()
			vim.opt_local.tabstop = 2
			vim.opt_local.shiftwidth = 2
			vim.opt_local.expandtab = true
		end,
	})
end

local four_space_languages = {
	"python",
	"sql",
	"kotlin",
	"go",
	"ruby",
	"rust",
	"sh",
	"toml",
	"yaml",
	"perl",
}

for _, lang in ipairs(four_space_languages) do
	vim.api.nvim_create_autocmd("FileType", {
		pattern = lang,
		callback = function()
			vim.opt_local.tabstop = 4
			vim.opt_local.shiftwidth = 4
			vim.opt_local.expandtab = true
		end,
	})
end

local tab_languages = {
	"c",
	"cpp",
	"java",
}

for _, lang in ipairs(tab_languages) do
	vim.api.nvim_create_autocmd("FileType", {
		pattern = lang,
		callback = function()
			vim.opt_local.tabstop = 4
			vim.opt_local.shiftwidth = 4
			vim.opt_local.expandtab = false
		end,
	})
end
