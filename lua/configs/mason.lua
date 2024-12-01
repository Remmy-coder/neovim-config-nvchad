-- return {
--   ensure_installed = {
--     "lua_lsp",
--     "stylua",
--     "rustfmt",
--     "tsserver",
--     "rust-analyzer",
--     "html-lsp",
--     "prettier",
--   },
-- }

local M = {}

M.mason = {
  pkgs = {
    "lua_lsp",
    "stylua",
    "rustfmt",
    "tsserver",
    "rust-analyzer",
    "html-lsp",
    "prettier",
  },
}

return M
