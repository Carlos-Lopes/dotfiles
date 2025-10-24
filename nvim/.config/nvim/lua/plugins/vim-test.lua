return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  config = function()
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local function nmap(keys, func, desc)
      vim.keymap.set("n", keys, func, {
        noremap = true,
        silent = true,
        desc = "[Test]: " .. desc,
      })
    end

    nmap("<leader>Tf", "<cmd>TestFile<CR>", "Test File")
    nmap("<leader>Tl", "<cmd>TestLast<CR>", "Test Last")
    nmap("<leader>Tn", "<cmd>TestNearest<CR>", "Test Nearest")
    nmap("<leader>Ts", "<cmd>TestSuite<CR>", "Test Suite")
    nmap("<leader>Tv", "<cmd>TestVisit<CR>", "Test Visit")

    local strategy = os.getenv("TMUX") and "vimux" or "neovim"
    vim.cmd("let test#strategy = '" .. strategy .. "'")
  end,
}
