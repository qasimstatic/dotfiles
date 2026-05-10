-- Statusline: lualine with catppuccin colors, mode indicators
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    -- Catppuccin color palette
    local C = {
      black = "#000000",
      red = "#f38ba8",
      mantle = "#181825",
      text = "#cdd6f4",
      blue = "#89b4fa",
      green = "#a6e3a1",
      yellow = "#f9e2af",
      mauve = "#cba6f7",
      teal = "#94e2d5",
    }

    -- Per-mode theme — lualine switches between these automatically
    local theme = {
      normal = {
        a = { fg = C.black, bg = C.blue, gui = "bold" },
        c = { fg = C.text, bg = C.black },
        x = { fg = C.text, bg = C.black },
        z = { fg = C.black, bg = C.blue },
      },
      insert = {
        a = { fg = C.black, bg = C.green, gui = "bold" },
        c = { fg = C.text, bg = C.black },
        x = { fg = C.text, bg = C.black },
        z = { fg = C.black, bg = C.green },
      },
      visual = {
        a = { fg = C.black, bg = C.mauve, gui = "bold" },
        c = { fg = C.text, bg = C.black },
        x = { fg = C.text, bg = C.black },
        z = { fg = C.black, bg = C.mauve },
      },
      replace = {
        a = { fg = C.black, bg = C.red, gui = "bold" },
        c = { fg = C.text, bg = C.black },
        x = { fg = C.text, bg = C.black },
        z = { fg = C.black, bg = C.red },
      },
      command = {
        a = { fg = C.black, bg = C.yellow, gui = "bold" },
        c = { fg = C.text, bg = C.black },
        x = { fg = C.text, bg = C.black },
        z = { fg = C.black, bg = C.yellow },
      },
      terminal = {
        a = { fg = C.black, bg = C.teal, gui = "bold" },
        c = { fg = C.text, bg = C.black },
        x = { fg = C.text, bg = C.black },
        z = { fg = C.black, bg = C.teal },
      },
      inactive = {
        a = { fg = C.text, bg = C.mantle, gui = "bold" },
        c = { fg = C.text, bg = C.black },
        x = { fg = C.text, bg = C.black },
        z = { fg = C.text, bg = C.mantle },
      },
    }

    lualine.setup({
      icons_enabled = true,
      options = {
        theme = theme,
        globalstatus = true,
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              local map = {
                NORMAL = "N", INSERT = "I", VISUAL = "V",
                ["V-LINE"] = "VL", ["V-BLOCK"] = "VB",
                COMMAND = "C", REPLACE = "R", TERMINAL = "T",
                O = "O",
              }
              return map[str] or str
            end,
          },
        },
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          { "location", padding = { left = 1, right = 1 } },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_c = {},
        x = {},
        z = {},
      },
    })
  end,
}
