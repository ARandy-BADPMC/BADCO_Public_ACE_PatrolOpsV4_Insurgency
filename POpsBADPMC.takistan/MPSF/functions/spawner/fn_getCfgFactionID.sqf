/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getCfgFactionID.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Faction ID
*/
params [["_faction","FactionTypeBLU",[""]]];

private _factionIDs = ["CfgMissionFramework","Factions"] call BIS_fnc_getCfgSubClasses;
private _defaultFaction = _factionIDs param [0,"",[""]];

if !(_faction IN _factionIDs) then {
	_faction = if (_faction IN ["FactionTypeBLU","FactionTypeOPF","FactionTypeCIV"]) then {
		["CfgMission",_faction] call MPSF_fnc_getCfgDataText;
	} else {
		getMissionConfigValue [_faction,_defaultFaction];
	};
};

_faction