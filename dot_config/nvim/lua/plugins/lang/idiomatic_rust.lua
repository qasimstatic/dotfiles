-- Rust: rustaceanvim (wraps rust-analyzer + DAP), rustfmt formatter, clippy lints
return {
	{
		"mrcjkb/rustaceanvim",
		version = "^8",
		ft = { "rust" },
		init = function()
			-- Use clippy instead of cargo check for diagnostics
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
	-- Formatter: rustfmt
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				rust = { "rustfmt" },
			},
		},
	},
}
