/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setGroupPatrol.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Sets a group to patrol around an area
*/
params [["_groupID",grpNull,[grpNull]],["_position",[],[[]]],["_radius",150,[0]]];

if (isNull _groupID) exitWith { /*["SetGroupPatrol: Null Group ID"] call BIS_fnc_error;*/ false; };
if (count _position == 0) exitWith { /*["SetGroupPatrol: Invalid starting position"] call BIS_fnc_error;*/ false; };

private _groupLeader = leader _groupID;
private _groupVehicle = vehicle _groupLeader;
if (_groupVehicle isKindOf "Air") then {
	_radius = _radius max 1000;
};

_groupID setBehaviour "SAFE";
_groupID setSpeedMode "LIMITED";
_groupID setCombatMode "YELLOW";
_groupID setFormation (selectRandom ["STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","DIAMOND"]);

private _wpcount = (round(_radius / 15) max 5) min 10;
private _inc = 360/_wpcount;
private _wparray = [];
for "_i" from 0 to _wpcount do {
	private _ang = _inc * _i;
	private _a = (_position select 0)+(sin(_ang)*_radius);
	private _b = (_position select 1)+(cos(_ang)*_radius);
	if(_groupVehicle isKindOf "LAND" && !(surfaceIsWater [_a,_b]) || _groupVehicle isKindOf "SHIP" && surfaceIsWater [_a,_b] || _groupVehicle isKindOf "AIR") then{
		_wparray set [count _wparray,[_a,_b,0]];
	};
};

if (count _wparray == 0) exitWith { /*["Unable to assign waypoints to group %1 in %2",_groupID,mapGridPosition _position] call BIS_fnc_error;*/ false; };
_wparray = _wparray call BIS_fnc_arrayShuffle;

for "_i" from 0 to (count _wparray - 1) do {
	private _cur = (_wparray select _i);
	private _wp = _groupID addWaypoint [_cur, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius (5 + (_radius/5));
	[_groupID,_i] setWaypointTimeout [0,2,16];
};

private _wpCycle = _groupID addWaypoint [(_wparray select 1), 0];
_wpCycle setWaypointType "CYCLE";
_wpCycle setWaypointCompletionRadius (5 + (_radius/5));