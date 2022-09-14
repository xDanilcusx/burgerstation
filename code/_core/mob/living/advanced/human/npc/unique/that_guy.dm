/mob/living/advanced/npc/unique/that_guy
	name = "That Guy"
	desc = "Hey, it's that guy."

	sex = MALE
	gender = MALE

	loyalty_tag = "Knight"
	iff_tag = "Knight"

	species = "stand"

	blood_type = /reagent/blood/human/ab_negative

	level = 60

	loadout = /loadout/that_guy


/mob/living/advanced/npc/unique/that_guy/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#CB7F4F")
	change_organ_visual("hair_head", desired_color = "#8A5B34", desired_icon_state = "hair_crewcut_s")

/mob/living/advanced/npc/unique/that_guy/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/space_cop)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/space_cop)
