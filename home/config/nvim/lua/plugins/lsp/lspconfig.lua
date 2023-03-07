-- LSP config
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- CMP LSP
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

-- Fidget
local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
	return
end

local language_servers = lspconfig.util.available_servers()
for _, ls in ipairs(language_servers) do
	lspconfig[ls].setup {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
		end
	}
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true
}

fidget.setup()
