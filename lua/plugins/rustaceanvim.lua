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
				server = {
					on_attach = function(client, bufnr)
						-- keymap
						vim.keymap.set("n", "<F9>", function()
							vim.cmd("wa")
							vim.cmd.RustLsp({ "runnables", bang = true })
						end, { noremap = true, desc = "Run rust target" })
						vim.keymap.set("n", "<F21>", function()
							vim.cmd("wa")
							vim.cmd.RustLsp({ "debuggables", bang = true })
						end, { noremap = true, desc = "Debug rust target" })
						vim.keymap.set("n", "<F33>", function()
							vim.cmd("wa")
							vim.cmd.RustLsp("debuggables")
						end, { noremap = true, desc = "Show debuggables" })
						vim.keymap.set("n", "<F57>", function()
							vim.cmd("wa")
							vim.cmd.RustLsp("runnables")
						end, { noremap = true, desc = "Show runnables" })
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
