/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setGroupCrowd.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Sets a group to wander aimlessly around an area to simulate crowd traffic
		Useful for civilian populations or an enemy camp that looks safe
*/
params [["_groupID",grpNull,[grpNull]],["_position",[0,0,0],[[]]],["_radius",0,[0]]];

_groupID setBehaviour "CARELESS";
_groupID setSpeedMode "LIMITED";
_groupID setCombatMode "WHITE";

private _movePositions = [_position,_radius,true] call MPSF_fnc_getNearbyBuildings;
if (count _movePositions < 10) then {
	private _wpcount = (round(_radius / 15) max 5) min 10;
	private _inc = 360/_wpcount;
	for "_i" from 0 to _wpcount do {
		private _ang = _inc * _i;
		private _a = (_position select 0)+(sin(_ang)*_radius);
		private _b = (_position select 1)+(cos(_ang)*_radius);
		if !(surfaceIsWater [_a,_b]) then{
			_movePositions pushBack [_a,_b,0];
		};
	};
	if (count _movePositions == 0) exitWith { /*["Unable to assign waypoints to group %1 in %2",_groupID,mapGridPosition _position] call BIS_fnc_error;*/ false; };
};

{ _x setPosATL (selectRandom _movePositions); } forEach (units _groupID);

_groupID setVariable ["crowdData",[_groupID,units _groupID,_movePositions]];

["MPSF_Crowd_EH","onEachFrame",{
	if (diag_frameNo % 500 == 0) then {
		{
			private _groupID = _x;
			if (count (_groupID getVariable ["crowdData",[]]) > 0) then {
				(_groupID getVariable ["crowdData",[]]) params ["_groupID","_units","_movePositions"];
				{ if (currentCommand _x isEqualTo "") then { _x doMove (selectRandom _movePositions); }; } forEach _units;
				if ({alive _x} count _units == 0) then { _groupID setVariable ["crowdData",nil]; };
			};
		} forEach allGroups;
		if (count (allGroups select { count (_x getVariable ["crowdData",[]]) > 0 }) == 0) then {
			["MPSF_Crowd_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
		};
	};
}] call MPSF_fnc_addEventHandler;