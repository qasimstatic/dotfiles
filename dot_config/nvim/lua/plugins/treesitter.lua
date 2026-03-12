return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = {
        "bash", "nu", "ruby",
        "html", "css", "scss",
        "javascript", "typescript", "json", "lua",
        "c", "cpp", "cmake", "odin",
      },
      auto_install = true,
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = false
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
