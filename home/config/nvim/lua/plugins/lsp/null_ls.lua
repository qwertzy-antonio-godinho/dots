-- Null-LS
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

vim.diagnostic.config({
	virtual_text = false, --{
--		prefix = "∎»",
--	},
	severity_sort = true,
	signs = true,
	underline = true,
	float = {
		source = "always",
	},
	update_in_insert = true,
})
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.vulture,
		null_ls.builtins.code_actions.gitsigns.with({
			config = {
				filter_actions = function(title)
				    return title:lower():match("blame") == nil
				end,
			},
		})
	},
	on_attach = function(current_client, bufnr)
	if current_client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
			end,
		})
		end
	end,
})

