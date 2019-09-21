local awful = require("awful")

local update_interval = 20

local function emit_charger_info()
    -- Know is charger info emited on awesome startup to avoid sendiong notificaion
    local is_initial = awesome.startup
    awful.spawn.easy_async_with_shell("cat /sys/class/power_supply/*/online", function (out)
        if tonumber(out) == 1 then
            awesome.emit_signal("evil::charger", true, is_initial)
        else
            awesome.emit_signal("evil::charger", false, is_initial)
        end
    end)
end

awful.widget.watch("cat /sys/class/power_supply/BAT1/capacity", update_interval, function(w, stdout)
    awesome.emit_signal("evil::battery", tonumber(stdout))
end)

awesome.connect_signal("evil::acpid", function(out)
    if out:match("ac_adapter") then
        emit_charger_info()
    end
end)

emit_charger_info()
