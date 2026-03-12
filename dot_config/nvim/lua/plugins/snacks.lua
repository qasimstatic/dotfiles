return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      win = {
        border = "single",
        padding = { 0, 0 },
      },
      preset = {
        header = [[
                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████
 ]],
        keys = {
          { icon = "", key = "f", desc = "Find File", action = ":lua require('fff').find_files()" },
          { icon = "", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = "", key = "c", desc = "Config", action = ":e " .. vim.fn.stdpath("config") },
          { icon = "󰒲", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "󰈆", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    indent = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
  },
  keys = {
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log_file() end, desc = "Lazygit log" },
  },
}
