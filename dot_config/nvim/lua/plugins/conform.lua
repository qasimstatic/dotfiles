-- Formatter: conform.nvim (language-specific formatters live in lang/)
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {},
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
			},
			-- Formatters for general-purpose languages
			formatters_by_ft = {
				lua = { "stylua" },
				cmake = { "cmakelang" },
			},
		},
	},
}
