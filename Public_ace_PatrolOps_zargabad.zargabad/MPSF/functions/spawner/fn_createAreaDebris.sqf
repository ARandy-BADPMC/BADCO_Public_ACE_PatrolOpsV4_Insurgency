/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createAreaDebris.sqf
	Author(s): see mpsf\credits.txt

	Description:
		IN PROGRESS - Creats debris on road that act as obstacles to vehicle travel

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [["_position",[0,0,0],[[]]],["_radius",0,[0]],["_debrisTypes",[],[[],""]],["_nearRoads",false,[false]]];

if (_position isEqualTo [0,0,0]) exitWith { [] };
if (_radius <= 0) exitWith { [] };
if !(typeName _debrisTypes isEqualTo typeName []) then { _debrisTypes = [_debrisTypes]; };
if (count _debrisTypes == 0) exitWith { [] };

private _positions = [];
if (_nearRoads) then {} else {
	private _wpcount = (round(_radius / 15) max 5) min 10;
	private _inc = 360/_wpcount;
	for "_i" from 0 to _wpcount do {
		private _ang = _inc * _i;
		private _incRadius = _radius * random 1;
		private _a = (_position select 0)+(sin(_ang)*_radius);
		private _b = (_position select 1)+(cos(_ang)*_radius);
		if !(surfaceIsWater [_a,_b]) then{
			_positions pushBack [_a,_b,0];
		};
	};
};
if (count _movePositions == 0) exitWith { /*["Unable to assign waypoints to group %1 in %2",_groupID,mapGridPosition _position] call BIS_fnc_error;*/ false; };
