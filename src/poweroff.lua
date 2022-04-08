--!lua
local args = ...

local sys = require("syscalls")
local errx = require("posix.errno").errno

local arg = (args[1] and args[1]:sub(3)) or args[0]
local success, err

if arg == "halt" then
  success, err = sys.reboot("halt")
elseif arg == "poweroff" or arg == "-p" then
  success, err = sys.reboot("poweroff")
elseif arg == "reboot" then
  success, err = sys.reboot("restart")
else
  success, err = nil, "Invalid executable name, or bad argument."
end

if not success then
  io.stderr:write(args[0]..": "..errx(err).."\n")
  sys.exit(1)
end

-- This is probably not needed, but it's good to have nonetheless.
sys.exit(0)
