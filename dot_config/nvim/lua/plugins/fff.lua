-- File finder: fff.nvim (fast fuzzy finder)
return {
	"dmtrKovalenko/fff.nvim",
	lazy = false,
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	keys = {
		{
			"<leader>ff",
			function()
				require("fff").find_files()
			end,
			desc = "Find files",
		},
		{
			"<leader>lg",
			function()
				require("fff").live_grep()
			end,
			desc = "Live grep",
		},
	},
	opts = {
		prompt = " ",
		title = "Finder",
		layout = {
			height = 1.0,  -- full screen height
			width = 1.0,   -- full screen width
			prompt_position = "top",
		},
	},
}
