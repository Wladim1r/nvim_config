return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	config = function()
		require("catppuccin").setup({
			integrations = {
				cmp = true, -- Включаем интеграцию Catppuccin с nvim-cmp
			},
		})
		vim.cmd.colorscheme("catppuccin")
		require("custom.colors").setup()
	end,
}
