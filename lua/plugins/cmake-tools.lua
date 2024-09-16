local cmake_kits_path = os.getenv("CMAKE_KITS_PATH")

return {
	"Civitasv/cmake-tools.nvim",
	event = "VeryLazy",
	cmd = { "CMake" },
	config = function()
		local osys = require("cmake-tools.osys")
		require("cmake-tools").setup({
			cmake_command = "cmake",
			cmake_regenerate_on_save = true,
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
			cmake_build_options = {},
			cmake_build_directory = function()
				if osys.iswin32 then
					return "build\\${variant:buildType}"
				end
				return "build/${variant:buildType}"
			end,
			cmake_soft_link_compile_commands = true,
			cmake_compile_commands_from_lsp = false,
			cmake_kits_path = cmake_kits_path,
			cmake_variants_message = {
				short = { show = true },
				long = { show = true, max_lenght = 40 },
			},
			cmake_dap_configuration = {
				name = "cpp",
				type = "codelldb",
				request = "launch",
				stopOnEntry = false,
				runInTerminal = true,
				console = "integratedTerminal",
			},
			cmake_executor = {
				name = "quickfix",
				opts = {},
				default_opts = {
					quickfix = {
						show = "always",
						position = "belowright",
						size = 10,
						encoding = "utf-8",
						auto_close_when_success = true,
					},
				},
			},
			cmake_runner = {
				name = "toggleterm",
				opts = {},
				default_opts = {
					toggleterm = {
						direction = "horizontal",
						close_on_exit = false,
						auto_scroll = true,
						singleton = true,
					},
				},
			},
			cmake_notifications = {
				enable = false,
				spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
				refresh_rate_ms = 100, -- how often to iterate icons
			},
		})
	end,
}
