-- fold
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

-- navigation
local navOpts = { noremap = true, silent = true }

vim.keymap.set("n", "<tab>", function()
	if vim.bo.buftype == "" then
		vim.cmd("bnext")
	end
end, { desc = "Next buffer" })

vim.keymap.set("n", "<S-tab>", function()
	if vim.bo.buftype == "" then
		vim.cmd("bprev")
	end
end, { desc = "Previous buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", navOpts)
vim.keymap.set("n", "<C-j>", "<C-w>j", navOpts)
vim.keymap.set("n", "<C-k>", "<C-w>k", navOpts)
vim.keymap.set("n", "<C-l>", "<C-w>l", navOpts)

-- motion
local motionOpts = { noremap = true, silent = true }

vim.keymap.set("i", "<C-h>", "<LEFT>", motionOpts)
vim.keymap.set("i", "<C-j>", "<DOWN>", motionOpts)
vim.keymap.set("i", "<C-k>", "<UP>", motionOpts)
vim.keymap.set("i", "<C-l>", "<RIGHT>", motionOpts)

-- bufdelete
vim.keymap.set("n", "<C-x>", function()
	require("bufdelete").bufdelete(0, true)
end, { desc = "Delete buffer" })

-- toggleterm
vim.keymap.set("n", "<A-h>", "<Cmd>ToggleTerm direction=horizontal<cr>", { noremap = true, desc = "Open terminal" })
vim.keymap.set(
	"n",
	"<A-v>",
	"<Cmd>ToggleTerm direction=vertical size=80<cr>",
	{ noremap = true, desc = "Open vertical terminal" }
)
vim.keymap.set(
	"n",
	"<A-n>",
	"<cmd>ToggleTerm direction=float size=80<cr>",
	{ noremap = true, desc = "Open floating terminal" }
)

vim.keymap.set("t", "<A-h>", "<Cmd>ToggleTerm direction=horizontal<cr>", { noremap = true, desc = "Close terminal" })
vim.keymap.set("t", "<A-t>", "<Cmd>ToggleTerm direction=vertical<cr>", { noremap = true, desc = "Close terminal" })
vim.keymap.set("t", "<A-n>", "<Cmd>ToggleTerm direction=float<cr>", { noremap = true, desc = "Close terminal" })
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { noremap = true, desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { noremap = true, desc = "Window move" })

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- nvimtree
vim.keymap.set("n", "<c-n>", "<Cmd>NvimTreeFindFileToggle<cr>", { desc = "toggle file tree" })

-- diagnostic
vim.keymap.set("n", "f", vim.diagnostic.open_float, { noremap = true, silent = true })

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufopts = { noremap = true, silent = true }
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client == nil then
			return
		end

		if client.supports_method("textDocument/rename") then
			vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, bufopts)
		end

		if client.supports_method("textDocument/declaration") then
			vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, bufopts)
		end

		if client.supports_method("textDocument/definition") then
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)
		end

		if client.supports_method("textdocument/hover") then
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		end

		if client.supports_method("textdocument/signature_help") then
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		end

		if client.supports_method("textDocument/implementation") then
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, bufopts)
		end

		if client.supports_method("textDocument/code_action") then
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		end

		if client.supports_method("textDocument/references") then
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
		end

		if client.supports_method("textDocument/format") then
			vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, bufopts)
		end
	end,
})

-- cmake
local cmake = require("cmake-tools")

local disable_clangd = function()
	print("Stopping lsp")
	vim.cmd("LspStop clangd")
end

local enable_clangd = function()
	print("Starting lsp")
	vim.cmd("LspStart clangd")
end

-- hack to stop and restart lsp server because it bug with modules and keep the
-- modules files locked so it prevent from building more than once ruining the
-- workflow, until this is fixed this is how i'll circumvent it
local cmake_build = function()
	disable_clangd()
	cmake.build({}, function()
		enable_clangd()
	end)
end

local cmake_run = function()
	disable_clangd()
	cmake.run({}, function()
		enable_clangd()
	end)
end

local cmake_debug = function()
	disable_clangd()
	cmake.debug({}, function()
		enable_clangd()
	end)
end

-- Autocommand pour définir des raccourcis lorsque des fichiers C/C++ sont ouverts
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "cxx", "h", "hpp", "hxx", "cmake", "CMakeLists.txt" },
	callback = function()
		vim.schedule(function()
			vim.keymap.set("n", "<F8>", cmake_build, { noremap = true, desc = "Build project" })
			vim.keymap.set("n", "<F9>", cmake_run, { noremap = true, desc = "Build and run project" })
			vim.keymap.set("n", "<S-F9>", cmake_debug, { noremap = true, desc = "Build and debug project" })
		end)
	end,
})

--dap
local dap = require("dap")
vim.keymap.set(
	"n",
	"<leader>db",
	"<cmd>DapToggleBreakpoint<cr>",
	{ noremap = true, desc = "Toggle breakpoint at line" }
)
vim.keymap.set("n", "<leader>dr", "<cmd>DapContinue<cr>", { noremap = true, desc = "Start or continue the debugger" })
vim.keymap.set("n", "<leader>dt", "<cmd>DapTerminate<cr>", { noremap = true, desc = "Stop the debugger" })
vim.keymap.set("n", "<leader>dl", function()
	dap.run_last()
end, { noremap = true, desc = "Run last debug target" })

--dapui
local dapui = require("dapui")
vim.keymap.set("n", "<leader>du", function()
	dapui.toggle()
end, {
	noremap = true,
	desc = "Toggle dapui",
})

--zig
local function zig_build(callback_on_success)
	vim.cmd("wa") -- Sauvegarder tous les fichiers

	-- Effacer et réinitialiser Quickfix
	vim.cmd("cclose")
	vim.cmd("cexpr []")

	-- Exécuter le job pour `zig build`
	vim.fn.jobstart("zig build", {
		stdout_buffered = false,
		on_stdout = function(_, data, _)
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						vim.fn.setqflist({}, "a", { lines = { line } })
					end
				end
				vim.cmd("copen")
			end
		end,
		on_stderr = function(_, data, _)
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						vim.fn.setqflist({}, "a", { lines = { line } })
					end
				end
				vim.cmd("copen")
			end
		end,
		on_exit = function(_, exit_code, _)
			if exit_code == 0 then
				vim.notify("Build completed successfully!", vim.log.levels.INFO)
				if callback_on_success then
					vim.cmd("cclose")
					callback_on_success()
				end
			else
				vim.notify("Build failed! Check Quickfix.", vim.log.levels.ERROR)
			end
		end,
	})
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "zig" },
	callback = function()
		vim.schedule(function()
			vim.keymap.set("n", "<F8>", function()
				zig_build(nil)
			end, { noremap = true, desc = "build project" })

			vim.keymap.set("n", "<S-F9>", function()
				zig_build(function()
					dap.continue()
				end)
			end, { noremap = true, desc = "build and run last launch target" })

			vim.keymap.set("n", "<F9>", function()
				zig_build(function()
					dap.run_last()
				end)
			end, { noremap = true, desc = "build and run" })
		end)
	end,
})
