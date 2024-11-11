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
			dap.adapters.run = {
				type = "server",
				port = "${port}",
				executable = {
					args = { "--port", "${port}" },
					command = "codelldb",
				},
				name = "run",
			}

			local dapui = require("dapui")
			dapui.setup({
				layouts = {
					{
						-- You can change the order of elements in the sidebar
						elements = {
							-- Provide IDs as strings or tables with "id" and "size" keys
							{
								id = "scopes",
								size = 0.25, -- Can be float or integer > 1
							},
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left", -- Can be "left" or "right"
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
				local type = session.config.type
			end
			dap.listeners.before.event_exited["dapui_config"] = function(session, body)
				local type = session.config.type
			end
		end,
	},
}
