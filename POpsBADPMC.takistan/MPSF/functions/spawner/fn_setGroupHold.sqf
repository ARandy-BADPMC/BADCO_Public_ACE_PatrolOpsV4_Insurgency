/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setGroupHold.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Sets a group to hold position
*/
params [["_groupID",grpNull,[grpNull]],["_position",[],[[]]]];

if (isNull _groupID) exitWith { /*["SetGroupPatrol: Null Group ID"] call BIS_fnc_error;*/ false; };
if (count _position == 0) exitWith { /*["SetGroupPatrol: Invalid starting position"] call BIS_fnc_error;*/ false; };

_groupID setBehaviour "SAFE";
_groupID setCombatMode "WHITE";

private _wayPoint = _groupID addWaypoint [_position, 20];
_wayPoint setWaypointType "HOLD";