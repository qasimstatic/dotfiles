-- Go: gopls LSP (with staticcheck + analyses), gofumpt formatter
-- NOTE: requires Go installed on system. gopls/gofumpt install via `go install`, not mason.
return {
	-- LSP: gopls with staticcheck (the clang-tidy of Go) + analyses
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							unusedwrite = true,
							shadow = true,
							fieldalignment = true,
							nilness = true,
						},
						staticcheck = true,
						gofumpt = true,
						vulncheck = "Imports",
					},
				},
			})
			vim.lsp.enable("gopls")
		end,
	},
	-- Formatter: gofumpt (stricter gofmt)
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				go = { "gofumpt" },
			},
		},
	},
}
