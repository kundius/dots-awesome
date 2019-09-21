local awful = require("awful")

-- Kill old listen process
awful.spawn.easy_async_with_shell('pkill evil-acpid.sh', function()
    -- Listen acpid events
    awful.spawn.with_line_callback('evil-acpid.sh', {
        stdout = function(out)
            awesome.emit_signal("evil::acpid", out)
        end
    })
end)
