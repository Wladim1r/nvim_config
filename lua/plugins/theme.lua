return {
	"folke/tokyonight.nvim",
	name = "tokyonight",
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			integrations = {
				cmp = true,
			},
		})
		vim.cmd.colorscheme("tokyonight-night")
		require("custom.colors").setup()
	end,
}
