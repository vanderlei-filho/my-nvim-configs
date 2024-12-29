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
					"lua_ls", -- Lua LSP
					"ts_ls", -- TypeScript and JavaScript LSP
					"pyright", -- Python LSP
					"jedi_language_server", -- Python LSP
					"svelte", -- Svelte LSP
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

			-- Keymaps
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Show LSP definition" })
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Show LSP code action" })
			vim.keymap.set("n", "<leader>lf", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "Format buffer using LSP" }) -- Manual formatting
		end,
	},
}
