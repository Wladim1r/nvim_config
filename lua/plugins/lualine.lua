return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "tokyonight",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return " " .. str
						end,
					},
				},
				lualine_b = { { "branch", icon = "" }, "diff" },
				lualine_c = {
					{
						"filename",
						path = 1, -- relative path
					},
				},
				lualine_x = {
					"diagnostics",
					"filetype",
					{
						function()
							return " " .. os.date("%Y-%m-%d") .. "  " .. os.date("%H:%M")
						end,
						cond = function()
							return vim.o.columns > 100
						end,
					},
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_c = { "filename" },
				lualine_x = { "location" },
			},
			extensions = { "nvim-tree" },
		})
	end,
}
