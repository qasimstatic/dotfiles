-- LeetCode: solve LeetCode problems inside nvim (default language: C++)
return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lang = "cpp",
	},
}
