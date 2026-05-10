-- TypeScript/JavaScript: vtsls LSP, eslint linter, prettier formatter
return {
	-- LSP: vtsls (TypeScript + JavaScript)
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("vtsls", {
				settings = {
					typescript = {
						preferences = {
							importModuleSpecifierPreference = "relative",
						},
						suggest = {
							includeAutomaticOptionalChainCompletions = false,
						},
					},
				},
			})
			vim.lsp.enable("vtsls")
		end,
	},
	-- Linter: vscode-eslint-language-server (the clang-tidy of JS/TS)
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("vscode-eslint-language-server", {})
			vim.lsp.enable("vscode-eslint-language-server")
		end,
	},
	-- Formatter: prettier
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
			},
		},
	},
}
