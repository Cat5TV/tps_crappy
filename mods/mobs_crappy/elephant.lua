
-- Elephant

mobs:register_mob("mobs_crappy:elephant", {
	type = "animal",
	passive = false,
	reach = 2,
	damage = 3,
	attack_type = "dogfight",
	hp_min = 50,
	hp_max = 70,
	armor = 100,
	visual = "mesh",
	mesh = "elephant.b3d",
	collisionbox = {-1.44, -2.56, -1.44, 1.44, 1.44, 1.44},
	textures = {
		{"mobs_crappy_elephant.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=4, y=4},
	makes_footstep_sound = true,
	step_height = 1.1,
	walk_velocity = 0.5,
	run_velocity = 8,
	jump = true,
	jump_height = 4,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -10,
	fear_height = 2,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "ethereal:bamboo"},
	replace_with = "air",
	follow = {"farming:wheat"},
	view_range = 14,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 5, max = 5},
	},
	animation = {
		speed_normal = 5,
		speed_run = 10,
		walk_start = 3,
		walk_end = 19,
		stand_start = 20,
		stand_end = 30,
		run_start = 3,
		run_end = 19,

	},

	do_custom = function(self, dtime)

		-- set needed values if not already present
		if not self.v2 then
			self.v2 = 0
			self.max_speed_forward = 3
			self.max_speed_reverse = 2
			self.accel = 2
			self.terrain_type = 3
			self.driver_attach_at = {x = 0, y = 8.5, z = -2}
			self.driver_eye_offset = {x = 0, y = 3, z = 0}
			--self.driver_scale = {x = .4, y = .4} -- normal size player
			self.driver_scale = {x = 1, y = 1} -- oversided player
		end

		-- if driver present allow control of elephant
		if self.driver then

			mobs.drive(self, "walk", "stand", false, dtime)

			return false -- skip rest of mob functions
		end

		return true
	end,

	on_die = function(self, pos)

		-- drop saddle when elephant is killed while riding
		-- also detach from elephant properly
		if self.driver then
			minetest.add_item(pos, "mobs:saddle")
			mobs.detach(self.driver, {x = 1, y = 0, z = 1})
		end

	end,

	on_rightclick = function(self, clicker)

		-- make sure player is clicking
		if not clicker or not clicker:is_player() then
			return
		end

		-- feed, tame or heal horse
		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		-- make sure tamed horse is being clicked by owner only
		if self.tamed and self.owner == clicker:get_player_name() then

			local inv = clicker:get_inventory()

			-- detatch player already riding horse
			if self.driver and clicker == self.driver then

				mobs.detach(clicker, {x = 1, y = 0, z = 1})

				-- add saddle back to inventory
				if inv:room_for_item("main", "mobs:saddle") then
					inv:add_item("main", "mobs:saddle")
				else
					minetest.add_item(clicker.getpos(), "mobs:saddle")
				end

			-- attach player to horse
			elseif not self.driver
			and clicker:get_wielded_item():get_name() == "mobs:saddle" then

				self.object:set_properties({stepheight = 1.1})
				mobs.attach(self, clicker)

				-- take saddle from inventory
				inv:remove_item("main", "mobs:saddle")
			end
		end

		mobs:protect(self, clicker)
		-- used to capture horse with magic lasso
		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end
})

mobs:register_spawn("mobs_crappy:elephant", {"default:dirt_with_dry_grass","default:desert_sand","default:dirt_with_grass", "ethereal:prairie_dirt"}, 20, 10, 25000, 1, 150)

mobs:register_egg("mobs_crappy:elephant", "Elephant", "default_dry_grass.png", 1)
