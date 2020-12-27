/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createGroup.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Create a group of units at a position

	Parameter(s):
			1: <ARRAY> - Position [x,y]
			2: <STRING/SIDE> - Side or Faction name from cfgMission_Sides
			3: <STRING/ARRAY> - Array of Units or Group from cfgMission_Sides

	Returns:
		GROUP

	Example:
		[screenToWorld [0.5,0.5],West,["B_Soldier_TL_f","B_Soldier_AT_F","B_Soldier_GL_F"]] call MPSF_fnc_createGroup;
		[screenToWorld [0.5,0.5],"FactionTypeBLU","InfSquad"] call MPSF_fnc_createGroup;
*/
params [["_position",[0,0,0],[[]]],["_faction",sideUnknown,[sideUnknown,""]],["_classNames",[],[[],""]]];

private _side = if (_faction isEqualType "") then {
	_faction = [_faction] call MPSF_fnc_getCfgFactionID;
	["side",_faction] call MPSF_fnc_getCfgFaction;
} else {
	_faction
};

if (_side isEqualTo sideUnknown) exitWith {
	/*["Invalid faction ID %1",_faction] call BIS_fnc_error;*/
	grpNull
};

if (_classNames isEqualType "") then {
	_classNames = ["groupData",_faction,_classNames] call MPSF_fnc_getCfgFaction;
};

if (count _classNames == 0) exitWith {
	/*["No unit classnames received for %1 in spawnGroup",_faction] call BIS_fnc_error;*/
	grpNull
};

private _groupID = createGroup _side;
if (isNull _groupID) exitWith {
	/*["Failed to create groupID for %1 in spawnGroup",_faction] call BIS_fnc_error;*/
	grpNull
};

private _unitArray = [];
for "_i" from 0 to (count _classNames - 1) do {
	private _unitData = _classNames select _i;
	if (typeName _unitData isEqualTo typeName "") then { _unitData = [_unitData]; };
	_unitData params [["_unitType","",[""]],["_unitLoadout","",[""]]];
	if !(_unitType isEqualTo "") then {
		private _unit = _groupID createUnit [_unitType, _position, [], 8, "FORM"];
		if !(isNull _unit) then {
			_unit setSkill 0.7;
			_unit allowFleeing 0;
			//[_unit,formationPosition _unit] call MPSF_fnc_setPosAGLS;
			_unit setVehiclePosition [formationPosition _unit,[],0,"NONE"];
			_unitArray pushBack _unit;
			if !(_unitLoadout isEqualTo "") then {
				[_unit,_unitLoadout] call MPSF_fnc_setUnitLoadout;
			};
		};
	};
};

[units _groupID] call MPSF_fnc_addZeusObjects;

if !(isNull _groupID) then { _groupID allowFleeing 0; };

_groupID enableDynamicSimulation true;

_groupID