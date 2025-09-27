local keymap = vim.keymap.set

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

keymap("n", "<leader>gr", ":!go run %<CR>", { desc = "Go Run current file" })

keymap("i", "<CapsLock>", "<Esc>", { noremap = true, silent = true })
keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
keymap("n", "<C-c>", "<cmd>Telescope close<CR>", { noremap = true })
vim.api.nvim_set_keymap("t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
keymap("n", "df", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
keymap("n", "fw", ":Telescope current_buffer_fuzzy_find<CR>", { noremap = true, silent = true })

-- don't copy when deleting
keymap("n", "x", '"_x')
keymap("n", "d", '"_d')
keymap("n", "D", '"_D')
keymap("v", "x", '"_x')
keymap("v", "d", '"_d')
keymap("v", "D", '"_D')



vim.opt.clipboard = "unnamedplus"

vim.opt.winblend = 10 -- Полупрозрачность
vim.opt.pumblend = 10

vim.g.border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		-- Бинд на <leader>cp для "compile and play"
		keymap("n", "<leader>cp", function()
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
                'g++ -std=%s -Wall -Wextra -pedantic "%s" -o /tmp/%s.out -lglut -lGLU -lGL -lm && /tmp/%s.out && rm /tmp/%s.out',
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

-- shortcuts for debug
keymap("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
keymap("n", "<F5>", "<cmd>DapContinue<CR>", { desc = "Start/continue debugger" })
keymap("n", "<F10>", "<cmd>DapStepOver<CR>", { desc = "Step over" })
keymap("n", "<F11>", "<cmd>DapStepInto<CR>", { desc = "Step into" })
keymap("n", "<F12>", "<cmd>DapStepOut<CR>", { desc = "Step out" })
keymap("n", "<leader>dt", "<cmd>DapTerminate<CR>", { desc = "Terminate debugger" })

-- Bufferline navigation
vim.api.nvim_set_keymap("n", "<A-p>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-n>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-d>", ":bdelete<CR>", { noremap = true, silent = true })