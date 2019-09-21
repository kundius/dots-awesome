local awful = require("awful")

local update_interval = 10

-- Periodically get temperature info
awful.widget.watch("cat /sys/class/hwmon/hwmon1/temp1_input", update_interval, function(widget, stdout)
    local temp = tonumber(stdout) / 1000
    awesome.emit_signal("evil::temperature", temp)
end)
