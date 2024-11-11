return {
	{
		"mrcjkb/rustaceanvim",
		verion = "^5",
		lazy = false,
		config = function()
			local executors = require("rustaceanvim.executors")
			vim.g.rustaceanvim = {
				tools = {
					executor = executors.toggleterm,
				},
				terminal = {
					direction = "horizontal",
				},
				dap = {
					adapter = false,
				},
				server = {
					on_attach = function(client, bufnr)
						local cmd = { "cargo", "build" }
						local build = function(sc)
							local output = sc.stdout
							if sc.code ~= 0 or output == nil then
								on_error(
									"An error occurred while compiling. Please fix all compilation issues and try again."
										.. "\nCommand: "
										.. table.concat(cmd, " ")
										.. (sc.stderr and "\nstderr: \n" .. sc.stderr or "")
										.. (output and "\nstdout: " .. output or "")
								)
								return
							end
						end

						-- keymap
						vim.keymap.set("n", "<F9>", function()
							vim.cmd("wa")
							vim.system(cmd, {}, function(sc)
								build(sc)
								vim.schedule(function()
									require("dap").run_last()
								end)
							end)
						end, { noremap = true, desc = "run target" })

						vim.keymap.set("n", "<F21>", function()
							vim.cmd("wa")
							vim.system(cmd, {}, function(sc)
								build(sc)
								vim.schedule(function()
									require("dap").continue()
								end)
							end)
						end, { noremap = true, desc = "select and run target" })
						vim.keymap.set("n", "<F8>", function()
							vim.cmd("wa")
							vim.cmd.RustLsp("flyCheck")
						end, { noremap = true, desc = "Build" })
						vim.keymap.set("n", "<leader>cd", function()
							vim.cmd.RustLsp("openDocs")
						end, { noremap = true, desc = "Open doc" })
						vim.keymap.set("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, { noremap = true, desc = "code action" })
						vim.keymap.set("n", "<leader>ce", function()
							vim.cmd.RustLsp("explainError")
						end, { noremap = true, desc = "explain error" })
					end,
				},
			}
		end,
	},
}
