return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function()
			-- Цвет ОСНОВНОЙ линии (indent)
			vim.api.nvim_set_hl(0, "IblIndent", {
				fg = "#3b4252", -- Серо-синий (цвет можно заменить)
				blend = 30, -- Полупрозрачность (0-100)
			})

			-- Цвет SCOPE линии (подсветка блоков между {})
			vim.api.nvim_set_hl(0, "IblScope", {
				fg = "#17f4ff",
				bold = true, -- Жирный шрифт
				underline = false, -- Подчёркивание (опционально)
			})

			require("ibl").setup({
				indent = {
					char = "▏",
					highlight = "IblIndent",
				},
				scope = {
					enabled = true, -- Включить подсветку scope
					highlight = "IblScope", -- Группа подсветки
				},
			})
		end,
	},
}
