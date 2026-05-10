-- File explorer: oil.nvim (edit directories like buffers)
return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		require("oil").setup()
		-- Toggle floating oil window
		vim.keymap.set("n", "<leader>e", require("oil").toggle_float, { desc = "Oil explorer" })
	end,
}
