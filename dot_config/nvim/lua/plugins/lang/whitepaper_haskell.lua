-- Haskell: haskell-tools.nvim (wraps HLS), fourmolu formatter
return {
	-- LSP + tooling: haskell-language-server via haskell-tools
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
								-- Enable hlint code actions and diagnostics
								hlint = { codeActionsOn = true, diagnosticsOn = true },
							},
						},
					},
				},
			}
		end,
	},
	-- Formatter: fourmolu (4-space indent)
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
