local awful = require("awful")

local update_interval = 15

-- Periodically get ram info
awful.widget.watch("cat /proc/meminfo", update_interval, function(widget, stdout)
    local total = tonumber(stdout:match("MemTotal:%s+(%d+)"))
    local available = tonumber(stdout:match("MemAvailable:%s+(%d+)"))
    local used = total - available
    awesome.emit_signal("evil::ram", used, total)
end)
