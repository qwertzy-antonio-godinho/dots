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

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

vim.fn.sign_define("DapBreakpoint", { text="", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text="ﳁ", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text="", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl= "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text="", texthl="DapLogPoint", linehl="DapLogPoint", numhl= "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text="", texthl="DapStopped", linehl="Search", numhl= "DapStopped" })

dap_virtual_text.setup()

dap.adapters.python = {
	type = "executable",
	command = "python",
	args = { "-m", "debugpy.adapter" },
}

dap_python.setup(mason_path .. "packages/debugpy/venv/bin/python")
dap_python.test_runner = "pytest"

-- Variables ----------------------
local env_variables = {}
local default_python_binary_path = "/usr/bin/python"
local default_automation_path = "~/nvim-test/"
env_variables["PYTHONPATH"] = "${PYTHONPATH}:" .. default_automation_path
env_variables["PYTHONTRACEMALLOC"] = "1"

python_binary_path = function()
	local venv_path = os.getenv("VIRTUAL_ENV")
	if venv_path then
		return venv_path .. "/bin/python"
	else
		return default_python_binary_path
	end
end
-- --------------------------------

table.insert(dap.configurations.python, {
	type = "python",
	request = "launch",
	name = "My py",
--	program = "${file}",
	module = "pytest",
	args = {
		"--verbosity=2",
		"--color=yes",
		"${file}",
	},
	env = env_variables,
	console = "integratedTerminal",
	pythonPath = python_binary_path,
	justMyCode = true,
})

dapui.setup({
	icons = { expanded = "-", collapsed = "+", current_frame = ">" },
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
