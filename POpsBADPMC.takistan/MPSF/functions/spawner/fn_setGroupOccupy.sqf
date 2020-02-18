params [["_groupID",grpNull,[grpNull]],["_position",[],[[]]],["_radius",150,[0]],["_defaultPatrol",false,[false]]];

if (isNull _groupID) exitWith { /*["SetGroupPatrol: Null Group ID"] call BIS_fnc_error;*/ false; };
if (count _position == 0) exitWith { /*["SetGroupPatrol: Invalid starting position"] call BIS_fnc_error;*/ false; };

private _wayPoint = _groupID addWaypoint [_position, 20];
_groupID setBehaviour "SAFE";
_groupID setCombatMode "WHITE";
_wayPoint setWaypointType "HOLD";

private _buildingPositions = [_position,_radius,true] call MPSF_fnc_getNearbyBuildings;
if (count _buildingPositions == 0 && _defaultPatrol) exitWith {
	_this call MPSF_fnc_setGroupPatrol;
};

{
	if (count _buildingPositions > 0 && (vehicle _x isEqualTo _x)) then {
		private _pos = _buildingPositions deleteAt (floor random count _buildingPositions);
		_x setPosATL _pos;
		doStop _x;
		_x forceSpeed 0;
		_x setDestination [_pos,"LEADER PLANNED", true];
	};
	_x addEventHandler ["Killed",{{ _x forceSpeed -1;} forEach units group (_this select 0)}];
} forEach (units _groupID);

true;