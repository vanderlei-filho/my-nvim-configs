return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",          -- Lua LSP
          "ts_ls",           -- TypeScript and JavaScript LSP
          "pyright",         -- Python LSP
          "jedi_language_server", -- Python LSP
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- LSPs
      lspconfig.lua_ls.setup({})
      lspconfig.ts_ls.setup({})

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      --vim.keymap.set("n", "", vim.lsp.
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
