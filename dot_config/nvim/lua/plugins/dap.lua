-- DAP framework: UI, keymaps, signs (language-specific adapters go in lang/)
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ "<leader>dr", function() require("dap").continue() end, desc = "Run debugger" },
			{ "<leader>dc", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
			{ "<leader>du", function() require("dap").step_out() end, desc = "Step out" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate debugger" },
			{ "<leader>dw", function() require("dapui").float_element("watches") end, desc = "Watch variables" },
			{ "<leader>ds", function() require("dapui").float_element("stacks") end, desc = "Call stack" },
			{ "<leader>dv", function() require("dapui").float_element("scopes") end, desc = "Scopes" },
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

			-- Highlight groups
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#f38ba8", bg = "none" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#89b4fa", bg = "none" })
			vim.api.nvim_set_hl(0, "DapStopped", { fg = "#a6e3a1", bg = "none" })

			-- Sign definitions
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "Visual" })
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
			handlers = {
				-- Skip default handler: we define our own configs per-language
			},
		},
	},
}
