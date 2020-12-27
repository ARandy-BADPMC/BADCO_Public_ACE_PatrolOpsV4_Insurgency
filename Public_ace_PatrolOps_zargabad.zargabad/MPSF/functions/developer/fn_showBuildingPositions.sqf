/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_showBuildingPositions.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Describe your function

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [["_building",objNull,[objNull]]];
if (isNull _building) exitWith {false};
private _position = position _building;

{
	private _obj = createVehicle ["Sign_Arrow_Direction_F",_x,[], 0, "CAN_COLLIDE"];
	_obj setPosATL _x;
	_obj setDir ([_position,_x] call BIS_fnc_dirTo);
	[_obj,str _forEachIndex] call MPSF_fnc_createIntelBeacon;
} forEach ([_building] call BIS_fnc_buildingPositions);

true;