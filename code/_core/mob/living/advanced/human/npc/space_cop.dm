/mob/living/advanced/npc/space_cop
	name = "space cop"
	desc = "Investigating galactic warcrimes since 2068."

	ai = /ai/advanced/space_cop

	dialogue_id = /dialogue/npc/soldier/

	level = 16

	loadout = /loadout/space_cop



/mob/living/advanced/npc/space_cop/Generate()
	sex = pick(MALE,FEMALE)
	gender = sex
	. = ..()

/mob/living/advanced/npc/space_soldier/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/space_cop)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/space_cop)