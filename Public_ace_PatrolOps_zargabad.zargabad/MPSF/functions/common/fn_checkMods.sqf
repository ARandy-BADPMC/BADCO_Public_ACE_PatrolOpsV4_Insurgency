/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_checkMods.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Checks if a mod or mods are present

	Parameter(s):
		0: ARRAY - Mod List
		1: BOOL - If all must be present

	Returns:
		Bool - Mods are present
*/
params [["_mods",[],[[]]],["_checkAll",false,[false]]];

if (_checkAll) then {
	{isClass (configFile >> "cfgPatches" >> _X)} count _mods == count _mods;
} else {
	{isClass (configFile >> "cfgPatches" >> _X)} count _mods > 0;
};