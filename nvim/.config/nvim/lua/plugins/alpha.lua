return {
  "goolord/alpha-nvim",
  lazy = false,
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    -- Set Menu Options
    dashboard.section.buttons.val = {
      dashboard.button("e", " New File", "<cmd>ene<CR>"),
      dashboard.button("r", " Recent Files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("f", " Search File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("w", "󰱼 Search Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("l", "󰒲 Extensions", "<cmd>Lazy<CR>"),
      dashboard.button("q", " Quit", "<cmd>q<CR>"),
    }

    alpha.setup(dashboard.opts)
  end,
}
