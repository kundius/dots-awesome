local awful = require("awful")

local function emit_info()
    awful.spawn.easy_async({"mpc", "-f", "[Title: %title%\nArtist: %artist%]"}, function(stdout)
        local title = stdout:match("Title:%s([^%c]*)") or ""
        local artist = stdout:match("Artist:%s([^%c]*)") or ""
        local status = stdout:match("%[(%w+)%]")
        local paused = status == "paused" and true or false
        artist = artist:gsub("%&", "&amp;")
        title = title:gsub("%&", "&amp;")
        awesome.emit_signal("evil::mpd", title, artist, paused)
    end)
end

-- Kill old mpc idleloop process
awful.spawn.easy_async_with_shell("pkill evil-mpd.sh", function ()
    -- Emit song info with each line printed
    awful.spawn.with_line_callback("evil-mpd.sh", {
        stdout = function()
            emit_info()
        end
    })
end)

emit_info()
