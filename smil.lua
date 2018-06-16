local utils = require 'mp.utils'
local msg = require 'mp.msg'
local options = require 'mp.options'

mp.add_hook("on_load" or "on_load_fail", 50, function ()
    local url = mp.get_property("stream-open-filename", "")

    if not (string.match(url, '^http') == nil) then
        msg.warn("Attempting to fetch SMIL")
        msg.error(url)

        res = utils.subprocess({
            args = {"curl", "-s", url}
        })
        body = res["stdout"]
        smilurl = string.match(body, '<SmilURL name="default">(.*)</SmilURL>')

        if not (smilurl == nil) then
	    msg.warn("Found smilurl, playing")
	    msg.warn(smilurl)
            mp.set_property("stream-open-filename", smilurl)
        end
    end
end)
