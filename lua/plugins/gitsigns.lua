return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup()
	end,

	vim.keymap.set("n", "gp", ":Gitsigns preview_hunk<CR>", {}),
}
