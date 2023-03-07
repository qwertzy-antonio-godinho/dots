local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
	is_bootstrap = true
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer and plug-ins. Please restart after installation."
	vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
else
	packer.init {
		display = {
			open_fn = function()
				return require("packer.util").float { border = "rounded" }
			end,
		},
	}
end

require("packer").startup(function(use)
use "wbthomason/packer.nvim"
local has_plugins, plugins = pcall(require, "packages.install_plugins")
if has_plugins then
	plugins(use)
end

if is_bootstrap then
	require("packer").sync()
	end
end)
