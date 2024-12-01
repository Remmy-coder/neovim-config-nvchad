-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "ts_ls", "rust_analyzer", "astro", "rnix", "bashls" }
local nvlsp = require "nvchad.configs.lspconfig"
local ufo_capabilities = {}
pcall(function()
  ufo_capabilities = require("configs.ufo").capabilities
end)

local capabilities = vim.tbl_deep_extend("force", nvlsp.capabilities, ufo_capabilities)

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    -- capabilities = nvlsp.capabilities,
    capabilities = capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
