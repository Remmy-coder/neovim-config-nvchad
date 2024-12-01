-- lua/configs/dap.lua
local M = {}

local function set_keymaps()
  local dap = require "dap"
  local dapui = require "dapui"

  vim.keymap.set("n", "<leader>d", "", { desc = "+debug" })
  vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
  end, { desc = "Breakpoint Condition" })
  vim.keymap.set("n", "<leader>db", function()
    dap.toggle_breakpoint()
  end, { desc = "Toggle Breakpoint" })
  vim.keymap.set("n", "<leader>dc", function()
    dap.continue()
  end, { desc = "Continue" })
  vim.keymap.set("n", "<leader>di", function()
    dap.step_into()
  end, { desc = "Step Into" })
  vim.keymap.set("n", "<leader>do", function()
    dap.step_over()
  end, { desc = "Step Over" })
  vim.keymap.set("n", "<leader>dO", function()
    dap.step_out()
  end, { desc = "Step Out" })
  vim.keymap.set("n", "<leader>dr", function()
    dap.repl.toggle()
  end, { desc = "Toggle REPL" })
  vim.keymap.set("n", "<leader>dl", function()
    dap.run_last()
  end, { desc = "Run Last" })
  vim.keymap.set("n", "<leader>dt", function()
    dap.terminate()
  end, { desc = "Terminate" })
  vim.keymap.set("n", "<leader>du", function()
    dapui.toggle()
  end, { desc = "Toggle UI" })
end

local codelldb_path = require("mason-registry").get_package("codelldb"):get_install_path() .. "/extension"
local codelldb_bin = codelldb_path .. "/adapter/codelldb"
local cargo_module = require "configs.dap_cargo_inspector"

M.setup = function()
  local dap = require "dap"
  local dapui = require "dapui"

  dapui.setup()

  -- Automatically open/close DAP UI
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  -- Set up signs
  vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DapStopped", linehl = "", numhl = "" })

  -- TypeScript configuration
  dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath "data" .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
  }
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = codelldb_bin,
      args = { "--port", "${port}" },
      -- On windows you may have to uncomment this:
      -- detached = false,
    },
    enrich_config = function(config, on_config)
      if config["cargo"] ~= nil then
        on_config(cargo_module.cargo_inspector(config))
      end
    end,
  }
  dap.configurations.typescript = {
    {
      name = "Launch",
      type = "node2",
      request = "launch",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
      outFiles = { "${workspaceFolder}/dist/**/*.js" },
      -- timeout = 10000,
      -- stopEntry = true,
    },
    {
      name = "Attach to process",
      type = "node2",
      request = "attach",
      processId = require("dap.utils").pick_process,
      -- stopEntry = true,
    },
  }
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
      env = function()
        local variables = {}
        for k, v in pairs(vim.fn.environ()) do
          table.insert(variables, string.format("%s=%s", k, v))
        end
        return variables
      end,
    },
  }

  -- Load .vscode/launch.json if it exists
  if vim.fn.filereadable ".vscode/launch.json" == 1 then
    require("dap.ext.vscode").load_launchjs()
  end

  -- Set up keymaps
  set_keymaps()
end

-- Expose set_keymaps function
M.set_keymaps = set_keymaps

return M
