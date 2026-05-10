return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		open_mapping = [[<leader>t]],
		insert_mappings = false,
		terminal_mappings = false,
		direction = "horizontal",
		size = 10,
		shell = vim.o.shell,
	},
}
