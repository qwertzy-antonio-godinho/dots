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

-- Renamer
local status_ok, renamer = pcall(require, "renamer")
if not status_ok then
	return
end

-- LSP lines
local status_ok, lsp_lines = pcall(require, "lsp_lines")
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

renamer.setup({
    border_chars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
})

lsp_lines.setup()

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "<leader>doc", vim.lsp.buf.hover, { desc = "Hover [Doc]umentation" })
vim.keymap.set("n", "<leader>sig", vim.lsp.buf.signature_help, { desc = "[Sig]nature Documentation" })
vim.keymap.set("n", "<leader>ren", renamer.rename, { desc = "[Ren]ame" })
vim.keymap.set("n", "<leader>work", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "[Work]orkspace" })
