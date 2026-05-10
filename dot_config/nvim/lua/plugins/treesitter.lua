-- Treesitter: syntax highlighting, incremental selection, code folding
local core_parsers = {
	"bash",
	"nu",
	"ruby",
	"html",
	"css",
	"scss",
	"javascript",
	"typescript",
	"json",
	"lua",
	"c",
	"cpp",
	"rust",
	"haskell",
	"cmake",
	"odin",
	"go",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter.install").prefer_git = false

			vim.api.nvim_create_user_command("TSInstallCore", function()
				vim.cmd("TSInstallSync " .. table.concat(core_parsers, " "))
			end, { desc = "Install core treesitter parsers" })

			-- Auto-start treesitter on every buffer
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(event)
					pcall(vim.treesitter.start, event.buf)
				end,
			})
		end,
	},
}
