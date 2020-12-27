/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getNearestReturnPoint.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns the nearest return point marker
*/
params [["_position",[0,0,0],[[]]],["_side",sideUnknown,[sideUnknown,objNull]]];

private _returnPoints = [_side,true] call MPSF_fnc_getReturnPoints;

if (count _returnPoints == 0) exitWith { /*["No Returnpoints found"] call BIS_fnc_error;*/ "return_point" };

private _returnPoint = _returnPoints select 0;
private _returnDistance = _position distance getMarkerPos _returnPoint;
{
	private _markerDist = _position distance markerPos _x;
	if (_markerDist < _returnDistance) then {
		_returnPoint = _x;
		_returnDistance = _markerDist;
	};
} forEach _returnPoints;

_returnPoint;