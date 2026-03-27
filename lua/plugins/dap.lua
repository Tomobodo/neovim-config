return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
	},
	{
		"mfussenegger/nvim-dap",
		even = "VeryLazy",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap" },
		event = "VeryLazy",
		config = function()
			local dap = require("dap")

			local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb_path,
					args = { "--port", "${port}" },
					detached = false,
				},
			}

			local dapui = require("dapui")
			dapui.setup({
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.25,
							},
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"console",
						},
						size = 20,
						position = "bottom",
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = function(session, body)
				local type = session.config.type
				if type == "codelldb" then
					dapui.open()
				else
					dapui.open({ layout = 2 })
				end
			end
			dap.listeners.before.event_terminated["dapui_config"] = function(session, body)
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function(session, body)
				dapui.close()
			end
		end,
	},
}
