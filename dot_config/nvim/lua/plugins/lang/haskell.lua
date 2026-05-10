return {
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^6",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.g.haskell_tools = {
				hls = {
					settings = {
						haskell = {
							plugin = {
								hlint = { codeActionsOn = true, diagnosticsOn = true },
							},
						},
					},
				},
			}
		end,
	},
}
