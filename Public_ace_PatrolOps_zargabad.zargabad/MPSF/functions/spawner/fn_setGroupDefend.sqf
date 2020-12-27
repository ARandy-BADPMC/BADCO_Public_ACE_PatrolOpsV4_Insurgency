/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setGroupDefend.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Sets a group to defend an area by occupyin static weapons and building positions
*/
params [["_groupID",grpNull,[grpNull]],["_position",[],[[]]],["_radius",150,[0]],["_occupyRemaining",false,[false]]];

if (isNull _groupID) exitWith { /*["SetGroupDefend: Null Group ID"] call BIS_fnc_error;*/ false; };
if (count _position == 0) exitWith { /*["SetGroupDefend: Invalid starting position"] call BIS_fnc_error;*/ false; };

private _wayPoint = _groupID addWaypoint [_position, 20];
_groupID setBehaviour "SAFE";
_groupID setCombatMode "YELLOW";
_wayPoint setWaypointType "HOLD";

private _leader = leader _groupID;
private _units = (units _groupID) - [leader _groupID];

// Static Weapons
private _list = _position nearObjects ["StaticWeapon", 200];
if (count _list > 0 ) then {
	private _staticWeapons = [];
	{
		if ((_x emptyPositions "gunner") > 0) then {
			_staticWeapons pushBack _x;
		};
	} forEach _list;
	{
		if ((count _units) > 0) then {
			private _unit = (_units select ((count _units) - 1));
			_unit assignAsGunner _x;
			[_unit] orderGetIn true;
			_units resize ((count _units) - 1);
		};
	} forEach _staticWeapons;
};

private _buildingPositions = [_position,_radius,true] call MPSF_fnc_getNearbyBuildings;
{
	switch (true) do {
		case (count _buildingPositions > 0 && random 1 > 0.5) : {
			private _pos = _buildingPositions deleteAt (floor random count _buildingPositions);
			_x setPosATL _pos;
			_x forceSpeed 0;
			_x setDestination [_pos,"LEADER PLANNED", true];
			doStop _x;
		};
		case (random 1 > 0.5) : {
			_x forceSpeed 0;
			_x setDestination [getPos _x,"LEADER PLANNED", true];
			_x action ["SitDown", _x];
			doStop _x;
		};
	};
	_x addEventHandler ["Killed",{{ _x forceSpeed -1;} forEach units group (_this select 0)}];
} forEach _units;

_leader addEventHandler ["Killed",{{ _x forceSpeed -1;} forEach units group (_this select 0)}];

true;