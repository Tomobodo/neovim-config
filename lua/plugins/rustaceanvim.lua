return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		init = function()
			vim.g.rustaceanvim = function()
				local executors = require("rustaceanvim.executors")
				return {
					tools = {
						executor = executors.toggleterm,
					},
					server = {
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
						on_attach = function(client, bufnr)
							local function rust_build_then(on_success)
								vim.cmd("compiler cargo")
								local efm = vim.o.errorformat
								local lines = {}
								vim.fn.jobstart({ "cargo", "build" }, {
									cwd = vim.fn.getcwd(),
									on_stderr = function(_, data)
										for _, line in ipairs(data) do
											if line ~= "" then
												table.insert(lines, line)
											end
										end
									end,
									on_exit = function(_, code)
										vim.schedule(function()
											if code ~= 0 then
												vim.fn.setqflist({}, "r", { lines = lines, efm = efm })
												vim.cmd("copen")
											else
												vim.fn.setqflist({})
												on_success()
											end
										end)
									end,
								})
							end

							vim.keymap.set("n", "<F8>", function()
								vim.cmd("wa")
								rust_build_then(function() end)
							end, { noremap = true, buffer = bufnr, desc = "Build" })

							vim.keymap.set("n", "<F9>", function()
								vim.cmd("wa")
								rust_build_then(function()
									vim.cmd({ cmd = "RustLsp", args = { "debuggables" }, bang = true })
								end)
							end, { noremap = true, buffer = bufnr, desc = "Debug" })

							vim.keymap.set("n", "<S-F9>", function()
								vim.cmd("wa")
								rust_build_then(function()
									vim.cmd.RustLsp("debuggables")
								end)
							end, { noremap = true, buffer = bufnr, desc = "Pick debug target" })

							vim.keymap.set("n", "<F10>", function()
								vim.cmd("wa")
								rust_build_then(function()
									vim.cmd({ cmd = "RustLsp", args = { "runnables" }, bang = true })
								end)
							end, { noremap = true, buffer = bufnr, desc = "Run" })

							vim.keymap.set("n", "<leader>ct", function()
								vim.cmd.RustLsp("runnables")
							end, { noremap = true, buffer = bufnr, desc = "Select run target" })

							vim.keymap.set("n", "<leader>cT", function()
								vim.cmd.RustLsp("debuggables")
							end, { noremap = true, buffer = bufnr, desc = "Select debug target" })

							vim.keymap.set("n", "<leader>cd", function()
								vim.cmd.RustLsp("openDocs")
							end, { noremap = true, buffer = bufnr, desc = "Open doc" })

							vim.keymap.set("n", "<leader>ca", function()
								vim.cmd.RustLsp("codeAction")
							end, { noremap = true, buffer = bufnr, desc = "code action" })

							vim.keymap.set("n", "<leader>ce", function()
								vim.cmd.RustLsp("explainError")
							end, { noremap = true, buffer = bufnr, desc = "explain error" })
						end,
					},
				}
			end
		end,
	},
}
