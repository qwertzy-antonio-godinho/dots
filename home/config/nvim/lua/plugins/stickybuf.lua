-- Stickybuf
local status_ok, stickybuf = pcall(require, "stickybuf")
if not status_ok then
	return
end

stickybuf.setup()
