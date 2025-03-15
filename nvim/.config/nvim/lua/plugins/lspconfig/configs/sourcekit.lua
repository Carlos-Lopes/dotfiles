local lspconfig = require("lspconfig")

-- Language server for Swift and C/C++/Objective-C.
-- https://www.swift.org/documentation/articles/zero-to-swift-nvim.html
lspconfig.sourcekit.setup({
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
})
