/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createIntel.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates/Converts an item into intel or enables a converation

	Parameter(s):
		0: Object - Description

	Returns:
		OBJECT
*/
params [["_target",objNull,[[],"",objNull]],["_arguments",[],[[]]]];

["createIntel",[_target,_arguments]] call MPSF_fnc_intel;