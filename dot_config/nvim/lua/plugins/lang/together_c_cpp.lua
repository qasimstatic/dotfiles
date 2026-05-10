-- C/C++: clangd LSP, clang_format formatter, codelldb debugger
return {
	-- LSP: clangd
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--offset-encoding=utf-16",
					"--query-driver=/usr/bin/c++,/usr/bin/gcc,/usr/bin/clang++",
				},
			})
			vim.lsp.enable("clangd")
		end,
	},
	-- Formatter: clang_format (Allman braces, LLVM style)
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
			},
			formatters = {
				clang_format = {
					prepend_args = {
						"--style={BasedOnStyle: llvm, IndentWidth: 4, BreakBeforeBraces: Allman}",
					},
				},
			},
		},
	},
	-- Debugger: codelldb — registered when opening C/C++ files
	{
		"mfussenegger/nvim-dap",
		opts = function()
			local dap = require("dap")

			local codelldb_path = vim.fn.exepath("codelldb")
			if codelldb_path == "" then
				codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
			end

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb_path,
					args = { "--port", "${port}" },
				},
			}

			local launch_config = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			dap.configurations.c = launch_config
			dap.configurations.cpp = launch_config
		end,
	},
}
