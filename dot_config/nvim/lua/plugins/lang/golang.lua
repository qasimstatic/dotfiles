-- Go: gopls (with staticcheck), gofumpt
-- NOTE: requires Go installed on system. gopls/gofumpt install via `go install`, not mason.
vim.lsp.config("gopls", {
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	cmd = { "gopls" },
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

return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				go = { "gofumpt" },
			},
		},
	},
}
