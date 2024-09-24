return {
	"windwp/nvim-autopairs",

	event = "InsertEnter",

	dependencies = {
		"hrsh7th/nvim-cmp",
	},

	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,
			ts_config = {
				lua = { "string" },
				javascript = { "template_stirng" },
				java = false,
			},
		})

		local cmp = require("cmp")

		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
