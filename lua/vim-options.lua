vim.g.mapleader = " "

vim.o.relativenumber = true
vim.o.number = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmode = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffe5ec" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#e7c6ff" })
vim.opt.cursorline = true

vim.keymap.set("n", "<leader>pp", ":!prettier -w %<CR><CR>")
vim.keymap.set("n", "<leader>gr", ":!go run %<CR>", { desc = "Go Run current file" })
vim.keymap.set("i", "<CapsLock>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-c>", "<cmd>Telescope close<CR>", { noremap = true })
vim.keymap.set("n", "<leader>t", ":terminal<CR>i", { desc = "Open terminal and focus" })
vim.api.nvim_set_keymap("t", "jj", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("n", "df", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "fd", ":Telescope current_buffer_fuzzy_find<CR>", { noremap = true, silent = true })

vim.opt.clipboard = "unnamedplus"

vim.opt.winblend = 10 -- Полупрозрачность
vim.opt.pumblend = 10

vim.g.border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		-- Бинд на <leader>cp для "compile and play"
		vim.keymap.set("n", "<leader>cp", function()
			-- Получаем информацию о файле
			local filename = vim.fn.expand("%:t") -- только имя файла
			local filepath = vim.fn.expand("%:p") -- полный путь

			-- Сохраняем файл
			vim.cmd("w")

			-- Определяем стандарт C++ автоматически
			local cpp_std = "c++17"
			local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false))
			if content:match("std::format") or content:match("std::jthread") then
				cpp_std = "c++20"
			end

			-- Формируем команду
			local cmd = string.format(
				'g++ -std=%s -Wall -Wextra -pedantic "%s" -o /tmp/%s.out && /tmp/%s.out && rm /tmp/%s.out',
				cpp_std,
				filepath,
				filename,
				filename,
				filename
			)

			-- Выполняем в терминале
			vim.cmd("split | terminal " .. cmd)
		end, { buffer = true, desc = "Compile and run C++ file" })
	end,
})
