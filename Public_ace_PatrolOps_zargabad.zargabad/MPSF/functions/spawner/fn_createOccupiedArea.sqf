/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createOccupiedArea.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates an area occupied specific forces
*/
params [["_position",[0,0,0],[[]]],["_radius",0,[0]],["_faction",sideUnknown,[sideUnknown,""]],["_classNames",[],[[],""]]];

private _buildingPositions = [_position,_radius,true] call MPSF_fnc_getNearbyBuildings;
private _groupUnits = [];

for "_i" from 0 to (count _buildingPositions - 1) do {
	if (count _groupUnits == 0) then {
		private _spawnGroup = [_position,_faction,_classNames] call MPSF_fnc_createGroup;
		_spawnGroup params [["_groupID",grpNull,[grpNull]],["_groupUnits",[],[[]]]];
	};

	if (count _groupUnits == 0) exitWith {};

	if (random 1 >= 0.3) then {
		private _unit = _groupUnits deleteAt (floor random count _groupUnits);
		private _pos = _buildingPositions deleteAt (floor random count _buildingPositions);
		_unit setPosATL _pos;
		_unit forceSpeed 0;
		_unit setDestination [_pos,"LEADER PLANNED", true];
		doStop _unit;
	};
};

for "_i" from 0 to (floor(_radius/100)) do {
	_this call MPSF_fnc_createPatrol;
};

true;