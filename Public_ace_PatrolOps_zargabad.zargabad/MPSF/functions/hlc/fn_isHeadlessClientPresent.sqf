/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_isHeadlessClientPresent.sqf
	Author(s): see mpsf\credits.txt

	Description:
		If headless clients are present

	Returns:
		Bool - True when present
*/
count ([] call MPSF_fnc_getHeadlessClients) > 0