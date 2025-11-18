return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				go = { "goimports", "golines" },
				cpp = { "clang-format" }, -- Добавлено для C++
				c = { "clang-format" }, -- Добавлено для C
				h = { "clang-format" }, -- Добавлено для C/C++ заголовков
				hpp = { "clang-format" }, -- Добавлено для C++ заголовков
				json = { "prettier" },
				sql = { "sql-formatter" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },
				python = { "black" },
			},
			formatters = {
				prettier = {
					prepend_args = { "--config-precedence", "prefer-file" },
					require_cwd_config = true,
				},
				["clang-format"] = { -- Настройки для C/C++
					prepend_args = {
						"--style={BasedOnStyle: LLVM, UseTab: Never, IndentWidth: 4, TabWidth: 4, ColumnLimit: 0}",
					},
				},
			},
			-- Форматировать при сохранении
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})
		vim.keymap.set({ "n", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
	end,
}
