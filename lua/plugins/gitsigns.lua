return {
	"lewis6991/gitsigns.nvim",
	dependencies = { "sindrets/diffview.nvim" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next Git Hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Previous Git Hunk" })

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Git Hunk" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Git Hunk" })
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage Git Hunk" })
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset Git Hunk" })
				map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Git Hunk" })

				-- Diffview
				map("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
				map("n", "<leader>dh", "<cmd>DiffviewFileHistory<CR>", { desc = "View File History" })
				map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })
			end,
		})
	end,
}

