local helpers = require("helpers")

function update_volume_info(skip_notification)
    helpers.get_volume_info(function(vol, mute)
        awesome.emit_signal("volume::update", vol, mute, skip_notification)
    end)
end

-- Pulseaudio sets different volume for speakers and headphones. We need to update volume when headphones connected
awesome.connect_signal("evil::acpid", function(out)
    if out:match("headphone") then
        update_volume_info(false)
    end
end)

update_volume_info(true)
