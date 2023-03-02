-- Automatically source and re-compile packer whenever you save this file
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
  group = packer_group,
  pattern = vim.fn.expand "$MYVIMRC",
})

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo")
vim.opt.backup = false
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.lazyredraw = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.guicursor = ""
vim.opt.fillchars = [[foldopen:,foldclose:]]
vim.opt.foldcolumn = "5"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.colorcolumn = "100"
vim.cmd [[colorscheme deep-space]]

local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
	if desc then
		desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gz", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
	vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

local servers = {}

local mason_lspconfig = require "mason-lspconfig"
mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}
mason_lspconfig.setup_handlers {
	function(server_name)
	require("lspconfig")[server_name].setup {
		capabilities = capabilities,
		on_attach = on_attach,
		settings = servers[server_name],
	}
	end,
}

local cmp = require 'cmp'

cmp.setup {
	mapping = cmp.mapping.preset.insert {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		else
			fallback()
		end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		else
			fallback()
		end
		end, { 'i', 's' }),
	},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'path' },
			{ name = 'nvim_lsp_signature_help' },
			{ name = 'buffer' },
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local language_servers = require("lspconfig").util.available_servers()

for _, ls in ipairs(language_servers) do
	require("lspconfig")[ls].setup {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
	end
	}
end

-- DAP
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
require("dap-python").test_runner = "pytest"

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        type    = "python", -- the type here established the link to the adapter definition : `dap.adapters.python`
        request = "launch",
        name    = "Launch file",
        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
        console    = "integratedTerminal",
        program    = "${file}", -- This configuration will launch the current file if used.
        --pythonPath = "/usr/bin/python"
      },
    }

-- Code fold
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end
require('ufo').setup({
    fold_virt_text_handler = handler
})

-- Diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config {
	virtual_text = {
		prefix = '∎',
	},
	severity_sort = true,
	signs = false,
	underline = true,
	float = {
		source = "always",  -- Or "if_many"
	},
	update_in_insert = true,
}

vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })

vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- wilder

local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline(),
    wilder.search_pipeline()
  ),
})

wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_palette_theme({
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
    border = 'rounded',
    max_height = '75%',      -- max height of the palette
    min_height = 0,          -- set to the same as 'max_height' for a fixed height window
    prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
    reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
  })
))

-- ▎● ■▼¤ ¦ «· »×ǀǁɅɪ ɛʭʬʷ 	˃ ˂˄ ˅ ˣ   ̶   ̸    ͞   裡     ͟      ͢    	 ҉  ᐁ ᐃᐅᐊ •— ― … ‹ › ― ‣‹›‼※ ⁕⁙⁞⁝ ₐↀ ↂ← 	↑ 	→ 	↓↖ 	↗ 	↘ 	↙↺ 	∗∎∘ 	∙√∿≣
-- Scroll bar
vim.cmd [[
let g:scrollview_character = '▎'
highlight link ScrollView Normal
]]

-- Neotest
vim.cmd [[
command! NeotestSummary lua require("neotest").summary.toggle()
command! NeotestFile lua require("neotest").run.run(vim.fn.expand("%"))
command! Neotest lua require("neotest").run.run(vim.fn.getcwd())
command! NeotestNearest lua require("neotest").run.run()
command! NeotestDebug lua require("neotest").run.run({ strategy = "dap" })
command! NeotestAttach lua require("neotest").run.attach()
command! NeotestOutput lua require("neotest").output.open()
]]

vim.cmd [[
au BufWritePost *.py :silent !black %
]]
