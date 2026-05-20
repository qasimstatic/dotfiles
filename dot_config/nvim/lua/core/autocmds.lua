local augroup = vim.api.nvim_create_augroup("qasim_core", { clear = true })

-- Transparency
vim.api.nvim_create_autocmd("ColorScheme", {
	group = augroup,
	pattern = "*",
	callback = function()
		local highlights = {
			"Normal",
			"NormalFloat",
			"NormalNC",
			"SignColumn",
			"EndOfBuffer",
			"Terminal",
			"FoldColumn",
			"Folded",
			-- Notify
			"NotifyINFOBody",
			"NotifyERRORBody",
			"NotifyWARNBody",
			"NotifyTRACEBody",
			"NotifyDEBUGBody",
			"NotifyINFOTitle",
			"NotifyERRORTitle",
			"NotifyWARNTitle",
			"NotifyTRACETitle",
			"NotifyDEBUGTitle",
			"NotifyINFOBorder",
			"NotifyERRORBorder",
			"NotifyWARNBorder",
			"NotifyTRACEBorder",
			"NotifyDEBUGBorder",
			-- Other
			"FloatBorder",
			"Pmenu",
			"PmenuSel",
		}

		for _, highlight in ipairs(highlights) do
			vim.api.nvim_set_hl(0, highlight, { bg = "none" })
		end
	end,
})

-- Apply transparency once at startup for current colorscheme
vim.api.nvim_exec_autocmds("ColorScheme", {
	group = "qasim_core",
	pattern = "*",
})
