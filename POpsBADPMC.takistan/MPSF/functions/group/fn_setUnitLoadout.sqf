/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setUnitLoadout.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Sets a units loadout based on supplied array or predefined config

	Parameter(s):
		0: Object - Unit or Player
		1: String/Array - Loadout Name or array matching <getUnitLoadout>

	Returns:
		Bool - True when done
*/
params [["_unit",objNull,[objNull]],["_loadout","",[[],""]]];

if (_loadout isEqualTo "") exitWith { false };
if (_loadout isEqualType []) exitWith { _unit setUnitLoadout _loadout; true; };

switch (true) do {
	case (isClass (configFile >> "CfgVehicles" >> _loadout)) : {};
	case (isClass (missionConfigFile >> "CfgRoles" >> _loadout)) : {
		_loadout = getUnitLoadout (missionConfigFile >> "CfgRoles" >> _loadout);
	};
	case (isClass (missionConfigFile >> "CfgRespawnInventory" >> _loadout)) : {
		_loadout = getUnitLoadout (missionConfigFile >> "CfgRespawnInventory" >> _loadout);
	};
	default {
		_loadout = missionNamespace getVariable [format["MPSF_SaveLoadout_%1",_loadout],[]];
	};
};

if (count _loadout == 0) exitWith { false; };

_unit setUnitLoadout _loadout;

true;