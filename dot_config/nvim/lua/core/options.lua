-- Editor options
-- Blue block for Normal, Green block for Insert, Mauve block for Visual
vim.opt.guicursor = {
  "n:block-CursorNormal",   -- Normal: block, blue
  "i:block-CursorInsert",   -- Insert: block, green  
  "v:block-CursorVisual",   -- Visual: block, mauve
  "r:block-CursorReplace",  -- Replace: block, red
  "c:block-Cursor",         -- Command: block, default
}

-- Custom cursor colors using Catppuccin palette
vim.api.nvim_set_hl(0, "CursorInsert", { fg = "#a6e3a1", bg = "#a6e3a1" })  -- Green
vim.api.nvim_set_hl(0, "CursorVisual", { fg = "#cba6f7", bg = "#cba6f7" })  -- Mauve
vim.api.nvim_set_hl(0, "CursorReplace", { fg = "#f38ba8", bg = "#f38ba8" }) -- Red

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.showmode = false -- lualine shows mode
vim.opt.cmdheight = 0 -- hide cmdline when not in use

-- Current Line No. Highlight
vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Statement" })

vim.opt.swapfile = false
vim.wo.number = true

-- Disable LazyVim import order check
vim.g.lazyvim_check_order = false

-- Transparency blend options
vim.opt.pumblend = 0
vim.opt.winblend = 0

-- Using ripgrep
vim.o.grepprg = "rg --vimgrep --smart-case --no-heading"
vim.o.grepformat = "%f:%l:%c:%m"
