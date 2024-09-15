return {
  "Civitasv/cmake-tools.nvim",
  event = "VeryLazy",
  cmd = { "CMake" },
  config = function()
    local osys = require('cmake-tools.osys')
    require("cmake-tools").setup({
      cmake_command = "cmake",
      cmake_regenerate_on_save = true,
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = {},
      cmake_build_directory = function()
        if osys.iswin32 then
          return "out\\${variant:buildType}"
        end
        return "out/${variant:buildType}"
      end,
      cmake_soft_link_compile_commands = true,
      cmake_compile_commands_from_lsp = false,
      cmake_kits_path = "/home/tomo/workspace/cpp/CMakeKits.json",
      cmake_variants_message = {
        short = { show = true },
        long = { show = true, max_lenght = 40 }
      },
      cmake_dap_configuration = {
        name = "cpp",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal"
      },
      cmake_executor = {
        name = "quickfix",
        defaults_opts = {
          quickfix = {
            show = "always",
            position = "belowright",
            size = 10
          }
        }
      },
      cmake_terminal = {
        name = "terminal",
        opts = {
          name = "Main Terminal",
          prefix_name = "[CMake]: ",
          split_direction = "horizontal",
          split_size = 45,
          single_terminal_per_instance = true,
          single_terminal_per_tab = true,
          keep_terminal_static_location = true,
          start_insert_in_launch_task = false,
          start_insert_in_other_task = false,
          focus_on_main_terminal = false,
          focus_on_launch_terminal = false
        }
      },
      cmake_notifications = {
        enable = false,
        spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
        refresh_rate_ms = 100, -- how often to iterate icons
      }
    })
  end
}
