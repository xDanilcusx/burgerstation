/atom/proc/Initialize()
	if(initialized)
		CRASH_SAFE("WARNING: [src.get_debug_name()] was initialized twice!")
		return TRUE
	return TRUE

/atom/proc/PostInitialize()
	return TRUE

/atom/proc/Generate() //Generate the atom, giving it stuff if needed.
	if(generated)
		CRASH_SAFE("WARNING: [src.get_debug_name()] was generated twice!")
		return TRUE
	return TRUE

/atom/proc/Finalize() //We're good to go.
	if(finalized)
		CRASH_SAFE("WARNING: [src.get_debug_name()] was finalized twice!")
		return TRUE
	return TRUE