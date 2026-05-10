-- LSP framework: Mason + semantic tokens disable on attach
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
					-- C/C++
					"clangd",
					-- Haskell
					"fourmolu",
					-- TypeScript/JavaScript
					"vtsls",
					"vscode-eslint-language-server",
					"prettier",
					-- Lua
					"lua-language-server",
					"selene",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Disable semantic tokens on attach — treesitter handles highlighting
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
