SUBSYSTEM_DEF(hook)
	name = "Enviromental Hazard Subsystem"
	desc = "Controls hazards, like extreme cold or extreme heat."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT

/subsystem/hook/Initialize()
	return TRUE

/subsystem/hook/on_life()
	return TRUE

//GMOD, anyone? Doesn't need a priority var as people should just add/overwrite the proc it calls.
//Adds a hook to an event.
/subsystem/hook/proc/add_hook(var/event_name,var/identifier,var/datum/owner,var/datum/proc_target,var/proc_to_use)

	ASSERT(event_name)
	ASSERT(identifier)
	ASSERT(owner)
	ASSERT(proc_target)
	ASSERT(proc_to_use)

	if(!owner.hooks)
		owner.hooks = list()

	if(!owner.hooks[event_name])
		owner.hooks[event_name] = list()

	owner.hooks[event_name][identifier] = list(proc_target,proc_to_use)

	world.log << "Adding: [owner].hooks\[[event_name]\]\[[identifier]\] = list([proc_target],[proc_to_use])"

	return TRUE

/subsystem/hook/proc/remove_hook(var/event_name,var/identifier,var/datum/datum_to_use)

	ASSERT(datum_to_use)

	if(!datum_to_use.hooks)
		return FALSE

	if(!datum_to_use.hooks[event_name])
		return FALSE

	if(!datum_to_use.hooks[event_name][identifier])
		return FALSE

	datum_to_use.hooks[event_name] -= identifier

	return TRUE

/subsystem/hook/proc/call_hook(var/event_name,var/datum/datum_to_use,var/args)

	world.log << "Calling hook: [event_name]."

	ASSERT(event_name)

	if(!length(datum_to_use.hooks))
		return FALSE

	if(!length(datum_to_use.hooks[event_name]))
		return FALSE

	var/total_calls = 0

	for(var/identifier in datum_to_use.hooks[event_name])
		var/list/list_info = datum_to_use.hooks[event_name][identifier]
		var/proc_owner = list_info[1]
		var/proc_to_use = list_info[2]
		call(proc_owner,proc_to_use)(args)
		total_calls++

	world.log << "Did [total_calls] total calls."

	return total_calls



