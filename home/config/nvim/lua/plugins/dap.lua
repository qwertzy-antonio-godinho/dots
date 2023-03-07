-- DAP
local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

-- DAP UI
local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
	return
end

-- DAP virtual text
local status_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not status_ok then
	return
end

-- DAP python
local status_ok, dap_python = pcall(require, "dap-python")
if not status_ok then
	return
end

dap_virtual_text.setup()

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
dap_python.setup(mason_path .. "packages/debugpy/venv/bin/python")
dap_python.test_runner = "pytest"

dap.adapters.python = {
	type = "executable",
	command = "python",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "My py",
		console = "integratedTerminal",
		program = "${file}",
		pythonPath = function()
			return "python"
		end,
--		pythonPath = "/usr/bin/python"
	},
}

dapui.setup({
	icons = { expanded = "-", collapsed = "+", current_frame = "" },
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.75 },
				{ id = "stacks", size = 0.25 },
			},
			size = 0.20,
			position = "left",
		},
		{
			elements = {
				{ id = "repl",    size = 0.45 },
				{ id = "console", size = 0.55 },
			},
			size = 0.27,
			position = "bottom",
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open("tray")
end
