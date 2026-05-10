-- Odin: ols LSP (basic type-checking and diagnostics)
-- NOTE: ols is not in mason. Install via: git clone https://github.com/DanielGavin/ols && cd ols && odin build . -out:~/bin/ols
return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("ols", {})
			vim.lsp.enable("ols")
		end,
	},
}
