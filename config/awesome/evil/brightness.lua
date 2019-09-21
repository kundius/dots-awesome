local awful = require("awful")

-- This value is stored in /sys/class/backlight/acpi_video0/max_brightness
local max_brightness = 10

local function emit_brightness_info(skip_notification)
    -- Brightness doesn't updates immediatly, so we need to "sleep" to get actual value
    awful.spawn.easy_async_with_shell("sleep 0.15 && cat /sys/class/backlight/acpi_video0/actual_brightness", function(out)
        local percentage = (tonumber(out) / max_brightness) * 100
        awesome.emit_signal("evil::brightness", percentage, skip_notification)
    end)
end

awesome.connect_signal("evil::acpid", function(out)
    if out:match("video/brightness") then
        emit_brightness_info(false)
    end
end)

emit_brightness_info(true)
