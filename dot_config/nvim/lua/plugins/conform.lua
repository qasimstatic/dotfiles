return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				mode = "n",
				desc = "Format file",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
			},
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
				lua = { "stylua" },
				cmake = { "cmakelang" },
				odin = { "odinfmt" },
				rust = { "rustfmt" },
			},
			formatters = {
				clang_format = {
					prepend_args = {
						"--style={BasedOnStyle: llvm, BreakBeforeBraces: Allman}",
					},
				},
				odinfmt = {
					command = "odinfmt",
					args = { "-stdin" },
					stdin = true,
					cwd = function()
						return vim.fn.expand("~/.config/odinfmt")
					end,
				},
			},
		},
	},
}
