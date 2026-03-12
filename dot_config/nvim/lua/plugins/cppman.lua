return {
  "madskjeldgaard/cppman.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    local cppman = require("cppman")
    cppman.setup()

    vim.opt.shell = "sh"

    vim.keymap.set("n", "<leader>cc", function()
      cppman.input()
    end, { desc = "Cppman search" })

    vim.keymap.set("n", "<leader>cm", function()
      cppman.open_cppman_for(vim.fn.expand("<cword>"))
    end, { desc = "Cppman word" })
  end,
}
