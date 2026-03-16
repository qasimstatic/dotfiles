return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig() -- diagnostics enabled by default

			lsp_zero.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
			end)

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "lua_ls", "rust_analyzer", "zls" },
				handlers = {
					lsp_zero.default_setup,
					["clangd"] = function()
						require("lspconfig").clangd.setup({
							cmd = { "clangd", "--fallback-style=llvm", "--header-insertion=never", "--compile-commands-dir=." },
						})
					end,
				},
			})
		end,
	},
}
