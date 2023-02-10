/obj/item/weapon/ranged/bullet/pump/shotgun/lever
	name = "12g 1984 lever-action shotgun"
	desc = "Git off my property!"
	desc_extended = "A lever action shotgun. Its lightweight, long-barrel design makes it more accurate than most shotguns, but fires slower. The weapon of choice for Space Farmers."
	icon = 'icons/obj/item/weapons/ranged/shotgun/sol/cowboy.dmi'
	icon_state = "inventory"
	value = 900

	company_type = "Solarian"

	tier = 2

	shoot_delay = 2

	pump_delay = 4

	automatic = FALSE

	bullet_count_max = 5

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	size = SIZE_4
	weight = 10

	action_name = "work"

	bullet_length_min = 76
	bullet_length_best = 76.2
	bullet_length_max = 76.4

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	heat_max = 0.08

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = TRUE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,



		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 30 - 16
	attachment_undermount_offset_y = 18 - 16

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.75

	can_wield = TRUE

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_base_spread()
	return 0.05