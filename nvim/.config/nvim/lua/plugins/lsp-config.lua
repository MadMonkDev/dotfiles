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
					"lua_ls",
					"arduino_language_server",
					"bashls",
					"ast_grep",
					"tailwindcss",
					"dockerls",
					"grammarly",
					"phpactor",
					"opencl_ls",
					"glsl_analyzer",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.arduino_language_server.setup({ capabilities = capabilities } )
			lspconfig.bashls.setup({ capabilities = capabilities } )
			lspconfig.ast_grep.setup({ capabilities = capabilities })
			lspconfig.tailwindcss.setup({ capabilities = capabilities })
			lspconfig.dockerls.setup({ capabilities = capabilities })
			lspconfig.grammarly.setup({ capabilities = capabilities })
			lspconfig.phpactor.setup({ capabilities = capabilities })
			lspconfig.opencl_ls.setup({ capabilities = capabilities })
			lspconfig.glsl_analyzer.setup({ capabilities = capabilities })
			-- lspconfig.asm_lsp.setup({ capabilities = capabilities })   -- add asm_lsp to ensure installed
			-- lspconfig.jinja_lsp.setup({ capabilities = capabilities })  -- add jinja_lsp to ensure insatalled
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "sd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
