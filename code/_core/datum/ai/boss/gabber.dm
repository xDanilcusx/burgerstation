/ai/boss/gabber
	var/next_trap = 0
	var/next_slam = 0

	var/mob/living/simple/gabber/owner_as_gabber

/ai/boss/gabber/New(var/desired_loc,var/mob/living/desired_owner)
	owner_as_gabber = desired_owner
	return ..()

/ai/boss/gabber/Destroy()
	owner_as_gabber = null
	return ..()

/ai/boss/gabber/set_objective(var/atom/A)
	. = ..()
	if(.)
		next_trap = max(next_trap,world.time + SECONDS_TO_DECISECONDS(30))
		next_slam = max(next_slam,world.time + SECONDS_TO_DECISECONDS(10))

/ai/boss/gabber/handle_movement()

	if(next_slam > 0 && next_slam <= world.time + SECONDS_TO_DECISECONDS(1)) //Doing slam.
		owner.move_dir = 0x0
		last_movement_proc = "slam override"
		return TRUE

	. = ..()

/ai/boss/gabber/handle_attacking()

	//Slam attack.
	if(next_slam > 0 && next_slam <= world.time + SECONDS_TO_DECISECONDS(1))

		if(next_slam > world.time)
			return TRUE

		var/turf/T = get_turf(objective_attack)

		if(T)
			var/checked_distance = get_dist(owner,T)

			if(checked_distance > 3)
				owner.dash_direction = get_dir(owner,T)
				owner.dash_amount = checked_distance - 1
				play_sound('sound/effects/dodge.ogg',get_turf(owner))
				next_slam = world.time + SECONDS_TO_DECISECONDS(1)
				return TRUE

			owner_as_gabber.slam(T)

			next_slam = world.time + (prob(25) ? SECONDS_TO_DECISECONDS(30) : SECONDS_TO_DECISECONDS(4))

			return TRUE

	//Trap attack.
	if(next_trap > 0 && next_trap <= world.time + SECONDS_TO_DECISECONDS(1))

		if(next_trap > world.time)
			return TRUE

		owner_as_gabber.trap_spam()

		next_trap = world.time + rand(SECONDS_TO_DECISECONDS(45),SECONDS_TO_DECISECONDS(90))

	. = ..()