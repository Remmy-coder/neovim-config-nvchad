local M = {}

-- General Neovim fold settings
vim.o.foldcolumn = "1" -- Show the fold column
vim.o.foldlevel = 99 -- Keep folds open by default
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Key mappings for fold commands
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

-- UFO-specific LSP folding capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- UFO setup
function M.setup()
  require("ufo").setup {
    provider_selector = function(_, _, _)
      return { "lsp", "indent" }
    end,
  }
end

return M
