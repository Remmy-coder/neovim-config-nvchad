require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--

local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Set up DAP keymaps after all plugins have loaded
autocmd("VimEnter", {
  callback = function()
    require("configs.dap").set_keymaps()
  end,
})
