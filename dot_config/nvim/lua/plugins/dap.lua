return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ensure_installed = { "codelldb" },
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dr", dap.continue, { desc = "Run debugger" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step out" })
			vim.keymap.set("n", "<leader>dw", function()
				dapui.float_element("watches")
			end, { desc = "Watch variables" })
			vim.keymap.set("n", "<leader>ds", function()
				dapui.float_element("stacks")
			end, { desc = "Call stack" })
			vim.keymap.set("n", "<leader>dsc", function()
				dapui.float_element("scopes")
			end, { desc = "Scopes" })
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			ensure_installed = { "codelldb" },
			handlers = {},
		},
	},
}
