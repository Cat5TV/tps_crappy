
local path = minetest.get_modpath("mobs_crappy")

-- Intllib
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end
mobs.intllib = S

-- Animals

dofile(path .. "/chicken.lua") -- JKmurray
dofile(path .. "/cow.lua") -- KrupnoPavel
dofile(path .. "/sheep.lua") -- PilzAdam
dofile(path .. "/bunny.lua") -- ExeterDad
dofile(path .. "/kitten.lua") -- Jordach/BFD
dofile(path .. "/goat.lua") -- NathanS21/DonBatman
dofile(path .. "/elephant.lua") -- Thanks to TenPlus1 for putting this together from dmobs for me

print (S("[MOD] Mobs Redo 'Animals' loaded"))
