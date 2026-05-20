-- Haskell: haskell-tools (wraps HLS), hlint, fourmolu
return {
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^6",
		ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
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
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				haskell = { "fourmolu" },
			},
			formatters = {
				fourmolu = {
					prepend_args = { "--indentation=4" },
				},
			},
		},
	},
}
