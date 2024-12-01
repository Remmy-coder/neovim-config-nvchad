return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = require "configs.mason",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    "MunifTanjim/nui.nvim",
  },

  {
    "kndndrj/nvim-dbee",
    event = { "BufEnter" },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup(--[[optional config]])
    end,
  },

  { "echasnovski/mini.icons", version = false },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require("configs.dap").setup()
    end,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
  },

  { "nvim-neotest/nvim-nio" },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("configs.ufo").setup()
    end,
    event = "BufReadPost", -- Lazy load after files are read
  },
  {
    "NvChad/base46",
    lazy = false, -- load immediately
    config = function()
      require("base46").load_all_highlights() -- Initialize base46 theme
    end,
  },
}
