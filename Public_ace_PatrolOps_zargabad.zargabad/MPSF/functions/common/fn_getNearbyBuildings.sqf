/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getNearbyBuildings.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Return nearby buildings positions

	Parameter(s):
		0: ARRAY - Position
		1: NUMBER - Radius of buildings
		2: BOOL - Return all building positions

	Returns:
		ARRAY
*/
params [["_position",[0,0,0],[[]]],["_radius",0,[0]],["_returnBuildingPos",false,[false]]];

private _buildings = nearestObjects [_position,["House_F"],_radius];
private _buildingPositions = [];
{
	if (_returnBuildingPos) then {
		{ _buildingPositions pushBack _x; } forEach ([_x] call BIS_fnc_buildingPositions);
	} else {
		_buildingPositions pushBack _x;
	};
} forEach (_buildings);

_buildingPositions;