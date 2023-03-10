-- Bufferline
local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	options = {
		indicator = {
			style = "none",
		},
		offsets = {
			{ filetype = "neo-tree", text = "Explorer", highlight = "PanelHeading", padding = 1, },
			{ filetype = "dapui", text = "Debug", },
			{ filetype = "Trouble",  text = "Problems", },
			{ filetype = "aerial",   text = "Symbols", highlight = "PanelHeading", padding = 1, },
		},
		custom_filter = function(buf_number, buf_numbers)
			local buf_name = vim.fn.bufname(buf_number)
			if string.find(buf_name, "fugitive") then
				return false
			end

			local filetype = vim.bo[buf_number].filetype
			if filetype == "qf" or filetype == "" then
				return false
			end
			return true
		end
	},
})
