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
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "cxx", "h", "hpp", "hxx", "cmake", "CMakeList.txt" },
	callback = function()
		vim.schedule(function()
			vim.keymap.set("n", "<c-b>", "<Cmd>CMakeBuild<CR>", { noremap = true, desc = "build project" })
			vim.keymap.set("n", "<c-r>", "<Cmd>CMakeRun<CR>", { noremap = true, desc = "build and run project" })
			vim.keymap.set("n", "<c-d>", "<Cmd>CMakeDebug<CR>", { noremap = true, desc = "build and debug project" })
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
