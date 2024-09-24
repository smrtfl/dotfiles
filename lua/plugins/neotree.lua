return {
	"nvim-neo-tree/neo-tree.nvim",

	build = ":TSUpdate",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		vim.keymap.set("n", "<leader>t", vim.cmd.Neotree)

		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_gitignored = true,
				},
			},
		})
	end,
}
