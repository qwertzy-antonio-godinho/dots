-- Mason
local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

-- Mason LSP
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

-- Mason null LS
local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
  return
end

local servers = {
	pylsp = {
		Python = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

mason.setup()

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		}
	end,
})

mason_null_ls.setup({
	ensure_installed = {
		"python-lsp-server",
		"flake8",
		"black",
		"isort",
		"vulture",
		"debugpy",
	},
	automatic_installation = true,
})
