return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local function nmap(keys, func, desc)
        vim.keymap.set("n", keys, func, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          desc = "[Git]: " .. desc,
        })
      end

      nmap("<leader>hb", function()
        gs.blame_line({ full = true })
      end, "Show full Git blame for current line")
      nmap("<leader>hd", gs.diffthis, "Show diff for the current file")
      nmap("<leader>tb", gs.toggle_current_line_blame, "Toggle line blame")
      nmap("<leader>td", gs.toggle_deleted, "Toggle deleted lines")
      nmap("<leader>tw", gs.toggle_word_diff, "Toggle dord diff")
    end,
  },
}
