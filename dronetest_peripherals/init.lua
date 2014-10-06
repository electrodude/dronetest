function _G.lst(t)
	for k,v in pairs(t) do
		print(tostring(k)..": "..tostring(v))
	end
end
--[[
function dcall(...)
	local ret = {pcall(...)}
	if not ret[1] then
		print("ERROR: "..tostring(ret[2]))
	end
	return unpack(ret)
end
--]]


dronetest = {}


-- none of these are finished yet (they were started in my (electrodude's) original computertest)
-- I'll add them as I finish them
local parts = 
{
	--"digilines_recipes",	-- digilines doesn't have crafting recipes, we need to add some
	--"terminal",			-- terminal block
	--"uiblock",			-- custom formspec block
	--"floppy",				-- floppy disk
	--"floppydrive",		-- floppy drive
	--"harddrive",			-- hard drive
	--"encryptor",			-- encrypting tunneler
	--"tunneler",			-- non-encrypting tunneler (might be useless)
	--"ioexpander",			-- digilines to mesecons
}

local base = minetest.get_modpath("dronetest_peripherals").."/"
for _,part in ipairs(parts) do
	dofile(base..part..".lua")
end
