-- Rust: rustaceanvim (wraps rust-analyzer + DAP), clippy, rustfmt
return {
	{
		"mrcjkb/rustaceanvim",
		version = "^8",
		ft = { "rust" },
		init = function()
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
								extraArgs = { "--warnings-as-errors" },
							},
							diagnostics = {
								enable = true,
								styleLints = { enable = true },
							},
						},
					},
				},
			}
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				rust = { "rustfmt" },
			},
		},
	},
}
