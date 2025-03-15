return {
  "goolord/alpha-nvim",
  lazy = false,
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
  },
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
      dashboard.button("e", " New File", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", " Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("f", " Search File", ":Telescope find_files<CR>"),
      dashboard.button("w", "󰱼 Search Word", ":Telescope live_grep<CR>"),
      dashboard.button("l", "󰒲 Extensions", ":Lazy<CR>"),
      dashboard.button("q", " Quit", ":q<CR>"),
    }

    alpha.setup(dashboard.opts)

    vim.keymap.set("n", "<leader>ee", ':Alpha<CR>', { desc = "Open Greeter Window (Alpha)" })
  end,
}
