vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.neovide_input_macos_alt_is_meta = true
vim.keymap.set("n", "<leader>wx", ":w<CR>:Ex<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>x", vim.cmd.Ex, { noremap = true, silent = true })

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.autoindent = true
vim.opt.mouse = "a"

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.breakindent = true

vim.opt.undofile = true

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

vim.opt.scrolloff = 10

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.signcolumn = "yes"

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

require("./lazy")
require("tabspace")
