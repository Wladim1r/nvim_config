vim.g.mapleader = " "

vim.o.relativenumber = true
vim.o.number = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmode = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.api.nvim_set_hl(0, 'LineNr', { fg = '#ffe5ec' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = '#e7c6ff' })
vim.opt.cursorline = true

vim.keymap.set("n", "<leader>pp", ":!prettier -w %<CR><CR>")
vim.keymap.set('n', '<leader>gr', ':w | !go run %<CR>', { desc = 'Go Run current file' })
vim.keymap.set('i', '<CapsLock>', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })
vim.keymap.set("n", "<C-c>", "<cmd>Telescope close<CR>", { noremap = true })
vim.keymap.set("n", "<leader>t", ":terminal<CR>i", { desc = "Open terminal and focus" })
vim.api.nvim_set_keymap('t', 'jj', '<C-\\><C-n>', { noremap = true, silent = true })

vim.opt.clipboard = 'unnamedplus'  -- Использовать системный буфер по умолчанию
