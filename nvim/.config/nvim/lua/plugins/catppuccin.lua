return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      default_integrations = false,
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        mini = {
          enabled = false
        },
        telescope = {
          enabled = true,
        },
        treesitter = true,
        treesitter_context = true,
        which_key = true
      }
    })

    vim.cmd.colorscheme("catppuccin-mocha")
  end
}
