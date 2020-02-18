/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getReturnPoints.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns all return points
*/
params [["_side",sideUnknown,[sideUnknown,objNull]],["_default",false,[false]]];

if !(_side isEqualType sideUnknown) then { _side = [_side] call BIS_fnc_objectSide; };
if !(_side in [east, west, resistance, civilian]) exitWith {};

private _marker = format ["returnpoint"];
private _returnPoints = allMapMarkers select compile format ["_x select [0, %1] == '%2'",count _marker,_marker];

if (count _returnPoints == 0 && _default) then {
	_returnPoints = [_side] call BIS_fnc_getRespawnMarkers;
};

_returnPoints;