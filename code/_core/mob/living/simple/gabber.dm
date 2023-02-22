/mob/living/simple/gabber
	name = "test boss"
	icon = 'icons/mob/living/simple/gabber.dmi'
	icon_state = "idle"
	pixel_x = -16

	damage_type = /damagetype/unarmed/holy

	var/ape_mode = FALSE

	ai = /ai/boss/gabber/

	force_spawn = TRUE
	boss = TRUE

	value = 10000

	stun_angle = 0

	health_base = 12500
	stamina_base = 5000
	mana_base = 12500

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Gabber"
	loyalty_tag = "Gabber"

	blood_type = /reagent/blood/ancient
	blood_volume = 3000

	soul_size = SOUL_SIZE_MYSTIC

	object_size = 2

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 50

	movement_delay = DECISECONDS_TO_TICKS(3)

/mob/living/simple/gabber/update_icon()
	. = ..()
	if(ape_mode)
		icon_state = "swords"
	else
		icon_state = initial(icon_state)

/mob/living/simple/gabber/Finalize()
	. = ..()
	update_sprite()
	set_light_sprite(VIEW_RANGE*0.5,0.25, "#3184B7",LIGHT_OMNI)

/*
	transform = get_base_transform()

/mob/living/simple/gabber/get_base_transform()
	var/matrix/M = matrix()
	M.Scale(2)
	return M
*/

/mob/living/simple/gabber/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"[icon_state]_light")
	I.plane = PLANE_LIGHTING
	I.appearance_flags = src.appearance_flags | RESET_COLOR | KEEP_APART
	I.alpha = 125
	I.layer = 1000
	add_overlay(I)

/mob/living/simple/gabber/proc/slam(var/turf/target)
	if(has_status_effect(PARALYZE))
		return FALSE
	src.do_say("SUBMIT, HERETIC!")
	add_status_effect(PARALYZE,duration=8,magnitude=-1,stealthy=TRUE)
	var/obj/effect/gabber_slam/S = new(target)
	S.owner = src
	S.charge()
	return TRUE

/mob/living/simple/gabber/proc/trap_spam()

	if(has_status_effect(PARALYZE))
		return FALSE

	src.do_say("BEHOLD!")
	add_status_effect(PARALYZE,duration=16,magnitude=-1,stealthy=TRUE)

	for(var/i=1,i<=8,i++)
		var/sin_x = sin(i/8 * 360)*VIEW_RANGE
		var/sin_y = sin(i/8 * 360)*VIEW_RANGE
		var/turf/T = locate(x + round(sin_x),y + round(sin_y),z)
		var/obj/effect/temp/gabber_death_trap/DT = new(T)
		DT.owner = src
		DT.loyalty_tag = src.loyalty_tag
		DT.place()

/mob/living/simple/gabber/proc/shoot_bouncy_projectiles(var/atom/desired_target,var/amount=5)

	shoot_projectile(
		src,
		desired_target,
		null,
		null,
		/obj/projectile/magic/gabber_ring,
		/damagetype/ranged/leaper_bubble,
		16,
		16,
		0,
		TILE_SIZE*0.25,
		amount,
		"#FFFFFF",
		0,
		1,
		iff_tag,
		loyalty_tag,
		base_spread = 0
	)

	return TRUE


/mob/living/simple/gabber/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/bullet_num_max,var/accuracy)

	if(bullet_num_max == 1)
		return ..()

	var/num = bullet_num/bullet_num_max

	var/norm_x = initial_offset_x + sin(num*360)
	var/norm_y = initial_offset_y + cos(num*360)

	var/mul = max(abs(norm_x),abs(norm_y))

	return list(norm_x/mul,norm_y/mul)