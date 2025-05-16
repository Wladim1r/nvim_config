return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- Полностью отключаем все лишние сообщения
			messages = {
				enabled = true, -- Отключает системные сообщения
			},
			lsp = {
				-- Настройки LSP-уведомлений
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				progress = {
					enabled = false, -- Отключает LSP-прогресс (проценты)
				},
				signature = {
					enabled = true, -- подписи
				},
				hover = {
					enabled = true, -- всплывающие подсказки
				},
				message = {
					enabled = true, -- LSP-сообщения
				},
			},
			presets = {
				lsp_doc_border = true, -- Рамка для документации
				command_palette = true, -- Включает палитру команд
				long_message_to_split = true, -- Длинные сообщения в сплит
				inc_rename = false, -- Отключает инкрементальное переименование
				bottom_search = false, -- Отключает поиск снизу
			},
			cmdline = {
				view = "cmdline_popup", -- Стильное отображение командной строки
			},
			-- Дополнительное отключение логов
			notify = {
				enabled = false, -- notify
			},
			health = {
				checker = true, -- проверкa здоровья
			},
		},
		-- Дополнительно отключаем все возможные уведомления
		init = function()
			vim.notify = function() end
		end,
	},
}
