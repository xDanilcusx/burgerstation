/obj/item/ball
	name = "ball"
	rarity = RARITY_RARE
	icon = 'icons/obj/item/ball.dmi'

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	var/north_momentum = 0
	var/east_momentum = 0

	var/bounciness = 0.5

	movement_delay = 1

	density = TRUE

	var/dribbling = FALSE

	value = 500

/obj/item/ball/update_overlays()
	. = ..()
	var/image/I = new/icon(initial(icon),"[initial(icon_state)]_shading")
	add_overlay(I)

/obj/item/ball/Finalize()
	. = ..()
	update_sprite()
	if(isturf(loc))
		SSball.all_balls |= src

/obj/item/ball/Destroy()
	SSball.all_balls -= src
	. = ..()

/obj/item/ball/post_move(var/atom/new_loc)
	. = ..()
	if(isturf(new_loc))
		SSball.all_balls |= src
	else
		SSball.all_balls -= src

/obj/item/ball/proc/ball_think(var/tick_rate=1)

	var/desired_move_dir = 0x0

	if(north_momentum > 0)
		desired_move_dir |= NORTH
		if(move_delay <= 0)
			north_momentum -= 1
	else if(north_momentum < 0)
		desired_move_dir |= SOUTH
		if(move_delay <= 0)
			north_momentum += 1
	if(east_momentum > 0)
		desired_move_dir |= EAST
		if(move_delay <= 0)
			east_momentum -= 1
	else if(east_momentum < 0)
		desired_move_dir |= WEST
		if(move_delay <= 0)
			east_momentum += 1

	north_momentum = FLOOR(north_momentum,1)
	east_momentum = FLOOR(east_momentum,1)

	if(!dribbling)
		movement_delay = max(1,10 - max(abs(north_momentum),abs(east_momentum))*4)

	move_dir = desired_move_dir

	if(move_dir)
		set_dir(move_dir)

	handle_movement(tick_rate)

	return TRUE


/obj/item/ball/soccer
	name = "soccer ball"
	desc = "Also known as a football."
	desc_extended = "You kick this. I guess you can throw this too."
	icon_state = "soccer"

/obj/item/ball/soccer/get_examine_list(var/mob/examiner)
	. = ..()
	. += span("notice","Hold ALT to move over the ball without kicking it.<br>Hold SPACE to triple your kicking power.<br>Hold SHIFT while running into the ball to double your kicking power.")

/obj/item/ball/soccer/Cross(atom/movable/O)
	return TRUE

/obj/item/ball/soccer/Uncrossed(atom/movable/O)
	return Crossed(O)

/obj/item/ball/soccer/Crossed(atom/movable/O)
	. = ..()
	if(is_living(O))
		var/mob/living/L = O
		if(L.horizontal)
			return .

		if(L.attack_flags & CONTROL_MOD_ALT)
			return .

		var/bump_dir = get_dir(src,O)

		var/move_mod = max(1,(L.move_mod-1)**2)

		if(L.loc == src.loc)
			bump_dir = turn(L.dir,180)
			move_mod *= 2
		else if(L.attack_flags & CONTROL_MOD_KICK)
			move_mod *= 3

		if(bump_dir & NORTH)
			if(north_momentum > 0)
				north_momentum = FLOOR(-north_momentum*bounciness,1)
			north_momentum -= move_mod
		else if(bump_dir & SOUTH)
			if(north_momentum < 0)
				north_momentum = FLOOR(-north_momentum*bounciness,1)
			north_momentum += move_mod
		if(bump_dir & EAST)
			if(east_momentum > 0)
				east_momentum = FLOOR(-east_momentum*bounciness,1)
			east_momentum -= move_mod
		else if(bump_dir & WEST)
			if(east_momentum < 0)
				east_momentum = FLOOR(-east_momentum*bounciness,1)
			east_momentum += move_mod

		if(move_mod == 1 && O.move_delay > 0)
			movement_delay = O.move_delay
			dribbling = TRUE
		else
			dribbling = FALSE

/obj/item/ball/soccer/Bump(atom/Obstacle)

	var/bump_dir = get_dir(src,Obstacle)

	if(bump_dir & NORTH)
		if(north_momentum > 0)
			north_momentum = FLOOR(-north_momentum*bounciness,1)
	else if(bump_dir & SOUTH)
		if(north_momentum < 0)
			north_momentum = FLOOR(-north_momentum*bounciness,1)

	if(bump_dir & EAST)
		if(east_momentum > 0)
			east_momentum = FLOOR(-east_momentum*bounciness,1)
	else if(bump_dir & WEST)
		if(east_momentum < 0)
			east_momentum = FLOOR(-east_momentum*bounciness,1)

	. = ..()


