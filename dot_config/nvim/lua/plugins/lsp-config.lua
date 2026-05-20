-- LSP framework: Mason + LspAttach autocmd
-- Language server configs use vim.lsp.config/enable at the top level of each lang/ file
return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason").setup({})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"clangd",
					"fourmolu",
					"vtsls",
					"eslint-lsp",
					"prettier",
					"lua-language-server",
					"selene",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
			})
		end,
	},
}
