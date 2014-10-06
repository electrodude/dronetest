-- userspace library for wrapping peripherals

local lastcid = 0
local function newcid()		-- return new connection id, "computerid:connectionid", e.g. "5:23"
	lastcid = lastcid + 1
	return sys.id..":"..tonumber(lastcid)
end

peripheraltypes = {}	-- not local so it ends up in the API - see os.loadlib

function scan(timeout)
	local cid = newcid()
	digilines.send("broadcast", {rq=scan, id=cid, reply_to=sys.id})

	local devices = {}

	local timer = os.timer(timeout or 0.5)
	local evt, msg
	repeat
		evt = os.pullevent({digilines_receive = true, timer=true})
		if evt.type == "digilines_receive" then
			local msg = evt.message
			if type(msg) == "table" and msg.channel == "broadcast" and msg.cid == cid then
				msg.channel = nil
				msg.cid = nil
				table.insert(devices, msg)
			end
		end
	until evt.type == "timer" and evt.id == timer

	return devices
end

function connect(channel)		-- pass it a channel, it asks the device on that channel for its library and loads it
	local cid = newcid()
	digilines.send(channel, {rq="connect", id = cid})
	local timer = os.timer(0.5)
	local evt, msg
	repeat
		evt = os.pullevent({digilines_receive = true, timer=true})
		msg = evt.message
	until (evt.type == "timer" and evt.id == timer) or (evt.type == "digilines_receive" and evt.channel == channel and msg.id == cid and msg.rq == "connect_response")
	if evt.type == "timer" then
		error("digilines.connect: timed out")
	end

	local device = os.loadlib_string(msg.interface, {channel = channel, cid = cid})

	local pdef = peripheraltypes[msg.type] or {knowncids=setmetatable({}, {__mode="v"})}
	peripheraltypes[msg.type] = pdef
	pdef.interface = msg.interface
	pdef.knowncids[cid] = device

	-- maybe use the stuff we just put in the peripheraltypes table as a cache or something?

	return device
end
