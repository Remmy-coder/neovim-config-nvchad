local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "deno_fmt" },
    typescript = { "deno_fmt" },
    typescriptreact = { "deno_fmt" },
    json = { "jq" },
    yaml = { "yamlfix" },
    rust = { "rustfmt", "dprint" },
    css = { "stylelint", "dprint" },
    html = { "dprint" },
    astro = { "deno_fmt", args = { "--ext", "astro,ts,tsx,js,jsx,md,json,jsonc,css,scss,html" } },
    nix = { "nixpkgs_fmt" },
    bash = { "beautysh" },
    sh = { "beautysh" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
