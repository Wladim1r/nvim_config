local M = {}

function M.setup()
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#90e0ef", ctermfg = 218 })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e7c6ff", ctermfg = 196, bold = true })
	vim.opt.cursorline = true

	vim.api.nvim_set_hl(0, "FloatBorder", {
		fg = "#17f4ff", -- Цвет рамки
	})
end

return M
