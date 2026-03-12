return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    require("oil").setup()
    vim.keymap.set("n", "<leader>e", require("oil").toggle_float, { desc = "Oil explorer" })
  end,
}
