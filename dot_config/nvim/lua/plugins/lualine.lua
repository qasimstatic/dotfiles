return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    local colors = {
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

    local theme = {
      normal = {
        a = { fg = colors.black, bg = colors.blue, gui = "bold" },
        b = { fg = colors.red, bg = colors.mantle },
        c = { fg = colors.text, bg = colors.black },
        x = { fg = colors.text, bg = colors.black },
        y = { fg = colors.blue, bg = colors.mantle },
        z = { fg = colors.black, bg = colors.blue },
      },
      insert = {
        a = { fg = colors.black, bg = colors.green, gui = "bold" },
        b = { fg = colors.red, bg = colors.mantle },
        c = { fg = colors.text, bg = colors.black },
        x = { fg = colors.text, bg = colors.black },
        y = { fg = colors.green, bg = colors.mantle },
        z = { fg = colors.black, bg = colors.green },
      },
      visual = {
        a = { fg = colors.black, bg = colors.mauve, gui = "bold" },
        b = { fg = colors.red, bg = colors.mantle },
        c = { fg = colors.text, bg = colors.black },
        x = { fg = colors.text, bg = colors.black },
        y = { fg = colors.mauve, bg = colors.mantle },
        z = { fg = colors.black, bg = colors.mauve },
      },
      replace = {
        a = { fg = colors.black, bg = colors.red, gui = "bold" },
        b = { fg = colors.red, bg = colors.mantle },
        c = { fg = colors.text, bg = colors.black },
        x = { fg = colors.text, bg = colors.black },
        y = { fg = colors.red, bg = colors.mantle },
        z = { fg = colors.black, bg = colors.red },
      },
      command = {
        a = { fg = colors.black, bg = colors.yellow, gui = "bold" },
        b = { fg = colors.red, bg = colors.mantle },
        c = { fg = colors.text, bg = colors.black },
        x = { fg = colors.text, bg = colors.black },
        y = { fg = colors.yellow, bg = colors.mantle },
        z = { fg = colors.black, bg = colors.yellow },
      },
      terminal = {
        a = { fg = colors.black, bg = colors.teal, gui = "bold" },
        b = { fg = colors.red, bg = colors.mantle },
        c = { fg = colors.text, bg = colors.black },
        x = { fg = colors.text, bg = colors.black },
        y = { fg = colors.teal, bg = colors.mantle },
        z = { fg = colors.black, bg = colors.teal },
      },
      inactive = {
        a = { fg = colors.text, bg = colors.mantle, gui = "bold" },
        b = { fg = colors.text, bg = colors.mantle },
        c = { fg = colors.text, bg = colors.black },
        x = { fg = colors.text, bg = colors.black },
        y = { fg = colors.text, bg = colors.mantle },
        z = { fg = colors.text, bg = colors.mantle },
      },
    }

    lualine.setup({
      icons_enabled = true,
      options = {
        theme = theme,
        globalstatus = true,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
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
              }
              return map[str] or str
            end,
          },
        },
        lualine_c = { "filename" },
        lualine_x = {
          { lazy_status.updates, cond = lazy_status.has_updates, color = { fg = "#ff9e64" } },
          { "filetype" },
        },
      },
    })
  end,
}
