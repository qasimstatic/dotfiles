-- TypeScript/JavaScript: vtsls, eslint, prettier
vim.lsp.config("vtsls", {
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	cmd = { "vtsls", "--stdio" },
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

vim.lsp.config("vscode-eslint-language-server", {
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	cmd = { "vscode-eslint-language-server", "--stdio" },
})
vim.lsp.enable("vscode-eslint-language-server")

return {
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
