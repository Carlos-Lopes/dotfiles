return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    -- Function to display lazy updates with color
    local function lazy_updates()
      local updates = lazy_status.updates()
      return updates ~= "" and "󰚰 " .. updates or ""
    end

    lualine.setup({
      options = {
        icons_enabled = vim.g.have_nerd_font or false,
        theme = "catppuccin-mocha",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn" },
            symbols = {
              error = " ",
              warn = " ",
            },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
          "diff",
        },
        lualine_c = {
          { "filename", path = 0, symbols = { modified = "●", readonly = "" } },
        },
        lualine_x = {
          { lazy_updates, cond = lazy_status.has_updates, color = { fg = "#ff9e64" } },
          "encoding",
          { "fileformat", symbols = { unix = "", dos = "", mac = "" } },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },
    })
  end,
}
