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
          "svelte",          -- Svelte LSP
          "clangd",          -- C and C++ LSP
          "cmake",           -- CMake
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Auto-formatting setup
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local function setup_format_on_save(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end

      -- Configure LSPs with auto-formatting on save
      lspconfig.lua_ls.setup({
        on_attach = function(client, bufnr)
          setup_format_on_save(client, bufnr)
        end,
      })

      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          setup_format_on_save(client, bufnr)
        end,
      })

      lspconfig.pyright.setup({})

      lspconfig.jedi_language_server.setup({
        on_attach = function(client, bufnr)
          setup_format_on_save(client, bufnr)
        end,
      })

      lspconfig.svelte.setup({
        on_attach = function(client, bufnr)
          setup_format_on_save(client, bufnr)
        end,
      })

      lspconfig.clangd.setup({
        -- IMPORTANT: Let clangd know where your compile_commands.json is
        cmd = {
          "clangd",
          "--compile-commands-dir=/Users/vanderlei/Code/jacobi-method/build",
          -- Additional flags that can be helpful
          "--background-index",
          "--suggest-missing-includes",
          "--header-insertion=iwyu",
          -- If you have multiple compilers (including mpicc or mpicxx),
          -- you can tell clangd which ones to query. Adjust as needed:
          "--query-driver=/Library/Developer/CommandLineTools/usr/bin/cc*,/usr/local/bin/mpic*,/opt/homebrew/bin/mpic*",
        },
        on_attach = function(client, bufnr)
          setup_format_on_save(client, bufnr)
        end,
      })

      lspconfig.cmake.setup({
        on_attach = function(client, bufnr)
          setup_format_on_save(client, bufnr)
        end,
        filetypes = { "cmake" },
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Show LSP definition" })
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Show LSP code action" })
      vim.keymap.set("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format buffer using LSP" }) -- Manual formatting
    end,
  },
}
