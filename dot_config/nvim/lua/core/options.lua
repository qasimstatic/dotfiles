-- Core editor options

-- Blue block for Normal, green for Insert, mauve for Visual
vim.opt.guicursor = {
	"n:block-CursorNormal",
	"i:block-CursorInsert",
	"v:block-CursorVisual",
	"r:block-CursorReplace",
	"c:block-Cursor",
}

vim.api.nvim_set_hl(0, "CursorInsert", { fg = "#a6e3a1", bg = "#a6e3a1" })
vim.api.nvim_set_hl(0, "CursorVisual", { fg = "#cba6f7", bg = "#cba6f7" })
vim.api.nvim_set_hl(0, "CursorReplace", { fg = "#f38ba8", bg = "#f38ba8" })

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.showmode = false
vim.opt.cmdheight = 0

vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Statement" })

vim.opt.swapfile = false

vim.g.lazyvim_check_order = false

vim.opt.pumblend = 0
vim.opt.winblend = 0

-- Using ripgrep
vim.o.grepprg = "rg --vimgrep --smart-case --no-heading"
vim.o.grepformat = "%f:%l:%c:%m"

-- LSP diagnostics: virtual text, gutter signs, underline
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
		format = function(diagnostic)
			-- Show source: [clang-tidy] unused variable
			if diagnostic.source then
				return string.format("[%s] %s", diagnostic.source, diagnostic.message)
			end
			return diagnostic.message
		end,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.INFO] = "◆",
			[vim.diagnostic.severity.HINT] = "⚡",
		},
	},
	underline = true,
	float = {
		border = "single",
		format = function(diagnostic)
			if diagnostic.source then
				return string.format("[%s] %s", diagnostic.source, diagnostic.message)
			end
			return diagnostic.message
		end,
	},
})

-- Catppuccin-colored diagnostic highlights
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#f38ba8" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#f9e2af" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#89b4fa" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#a6e3a1" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#f38ba8" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#f9e2af" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#89b4fa" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#a6e3a1" })
