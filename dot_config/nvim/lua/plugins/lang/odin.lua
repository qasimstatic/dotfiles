-- Odin: ols
-- NOTE: ols is not in mason. Install via: git clone https://github.com/DanielGavin/ols && cd ols && odin build . -out:~/bin/ols
vim.lsp.config("ols", {
	filetypes = { "odin" },
	cmd = { "ols" },
})
vim.lsp.enable("ols")

return {}
