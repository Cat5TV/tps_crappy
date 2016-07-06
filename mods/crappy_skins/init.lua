minetest.register_on_joinplayer(function(player)
	local numberOfSkins = 21 -- Set the number of skins in ./textures
	local chosenSkin = math.random(numberOfSkins)
	local filename = minetest.get_modpath("crappy_skins").."/textures/"..chosenSkin..".png"
	local f = io.open(filename)
	if f then
		f:close()
		default.player_set_textures(player, {chosenSkin..".png"})
	end
end)
