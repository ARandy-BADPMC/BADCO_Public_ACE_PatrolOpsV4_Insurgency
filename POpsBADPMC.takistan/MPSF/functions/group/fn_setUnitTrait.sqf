/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setUnitTrait.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Set a Units Role

	Parameter(s):
		0: Object - Unit
		1: STRING - Trait Name
		2: BOOL - Has Trait

	Returns:
		Bool - True when done
*/
params [["_target",objNull,[objNull]],["_trait","",[""]],["_value",false,[false]]];

if (isNull _target) exitWith { false };

private _knownTraits = ["medic","engineer","explosiveSpecialist","UAVHacker"] apply {toLower _x};

_target setUnitTrait [_trait,_value,!(toLower _trait in _knownTraits)];

true;