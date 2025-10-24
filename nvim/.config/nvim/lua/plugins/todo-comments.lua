return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require('todo-comments').setup({})

    vim.keymap.set("n", "<C-t>", ":TodoTelescope<CR>", { desc = "Open [T]odo Window" })
  end
}
