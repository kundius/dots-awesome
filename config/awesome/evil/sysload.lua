local awful = require("awful")

local update_interval = 10
local nproc = 2 -- Number of processors

awful.widget.watch("cat /proc/loadavg", update_interval, function(w, stdout)
    -- Get average load for the last minute
    local loadavg = stdout:match("^[^%s]+%s")
    local loadpercentage = (tonumber(loadavg) / nproc) * 100

    awesome.emit_signal("evil::sysload", loadpercentage)
end)
