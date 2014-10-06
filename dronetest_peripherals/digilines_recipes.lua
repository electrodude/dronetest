local function noncraftable(item)
	-- TODO: actually do something
	return true
end

if noncraftable('digilines:wire_std_00000000') then
	minetest.register_craft(
	{
		output = 'digilines:wire_std_00000000',
		recipe = {
			{'mesecons_materials:silicon','group:mesecon_conductor_craftable'},
		}
	})
end

if noncraftable('digilines:wire_std_00000000') then
	minetest.register_craft(
	{
		output = 'digilines_lcd:lcd',
		recipe = {
			{'mesecons_lamp:lamp_off','mesecons_lamp:lamp_off',		'mesecons_lamp:lamp_off'},
			{'mesecons_lamp:lamp_off','digilines:wire_std_00000000','mesecons_lamp:lamp_off'},
			{'mesecons_lamp:lamp_off','mesecons_lamp:lamp_off',		'mesecons_lamp:lamp_off'},
		}
	})
end
