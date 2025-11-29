return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				separator_style = "thin",
				indicator = { icon = "▎" },
				show_buffer_close_icons = true,
				show_close_icon = "always",
				diagnostics = "nvim_lsp",
			},
		})
	end,
}
