return {
	"saecki/crates.nvim",
	tag = "stable",
	event = "VeryLazy",
	config = function()
		local crates = require("crates")
		crates.setup()
		crates.show()
	end,
}
