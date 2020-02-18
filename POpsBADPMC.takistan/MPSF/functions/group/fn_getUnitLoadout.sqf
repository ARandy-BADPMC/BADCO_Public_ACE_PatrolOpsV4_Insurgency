/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getUnitLoadout.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns a units loadout and allows save

	Parameter(s):
		0: Object - Unit to get loadout
		1: STRING - if used, will save under the variable

	Returns:
		Array
*/
params [["_unit",objNull,[objNull]],["_loadoutID","",[""]]];

private _loadout = getUnitLoadout _unit;

if !(_loadoutID isEqualTo "") then {
	missionNamespace setVariable [format["MPSF_SaveLoadout_%1",_loadoutID],_loadout];
};

_loadout;