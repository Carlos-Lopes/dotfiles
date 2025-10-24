return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    dim_inactive = {
      enabled = true,
      shade = "dark",
      percentage = 0.15,
    },
    default_integrations = false,
    auto_integrations = true,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)

    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
