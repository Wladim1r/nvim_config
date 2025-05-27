return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				go = { "gofmt", "goimports", "golines" },
				cpp = { "clang-format" }, -- Добавлено для C++
				c = { "clang-format" }, -- Добавлено для C
				h = { "clang-format" }, -- Добавлено для C/C++ заголовков
				hpp = { "clang-format" }, -- Добавлено для C++ заголовков
				json = { "prettier" },
				sql = { "sql-formatter" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
			},
			formatters = {
				prettier = {
					prepend_args = { "--config-precedence", "prefer-file" },
					require_cwd_config = true,
				},
				["clang-format"] = { -- Настройки для C/C++
					prepend_args = {
						"--style=file", -- Использует .clang-format из проекта
						"--fallback-style=llvm", -- Стиль по умолчанию если нет конфига
					},
				},
			},
			-- Форматировать при сохранении
			format_on_save = {
				timeout_ms = 100,
				lsp_fallback = true,
			},
		})

		vim.keymap.set({ "n", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
	end,
}
