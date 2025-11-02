return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{
			",,",
			"<cmd>ToggleTerm<cr>",
			desc = "Toggle terminal",
		},
	},
	opts = {
		direction = "horizontal",
		open_mapping = [[,,]],

		size = 20,
		shade_terminals = true,
		shading_factor = 2,
	},
}
