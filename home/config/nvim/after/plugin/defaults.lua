vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath 'cache' .. '/undo'
vim.o.lazyredraw = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.cmd [[
  set guicursor=n-v-c:block-Cursor
  set guicursor+=n-v-c:blinkon0
]]
vim.g.nvim_focused = true

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '3'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F1>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>dt", ":lua require'dap-python'.test_method()<CR>")
vim.keymap.set("n", "<leader>dc", ":lua require'dap-python'.test_class()<CR>")

require('neodev').setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
require("dap-python").test_runner = "pytest"

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
local navic = require("nvim-navic")
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end
        -- you can add other fields for setting up lsp server in this table
    })
end

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

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<C-q>", ":qa<CR>", { silent = true })
map("i", "<C-q>", "<cmd>qa<CR>", { silent = true })
map("v", "<C-q>", "<cmd>qa<CR>", { silent = true })

map("n", "<C-S-q>", ":qa!<CR>", { silent = true })
map("i", "<C-S-q>", "<cmd>qa!<CR>", { silent = true })
map("v", "<C-S-q>", "<cmd>qa!<CR>", { silent = true })

map("n", "<C-s>", ":w<CR>", { silent = true })
map("i", "<C-s>", "<cmd>w<CR>", { silent = true })
map("v", "<C-s>", "<cmd>w<CR>", { silent = true })

map("n", "<C-z>", ":u<CR>", { silent = true })
map("i", "<C-z>", "<cmd>u<CR>", { silent = true })
map("v", "<C-z>", "<cmd>u<CR>", { silent = true })

map("n", "<C-S-z>", "<C-R>", { silent = true })
map("i", "<C-S-z>", "<cmd>redo<CR>", { silent = true })
map("v", "<C-S-z>", "<cmd>redo<CR>", { silent = true })

