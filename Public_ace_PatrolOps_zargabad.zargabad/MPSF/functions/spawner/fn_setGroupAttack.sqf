/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setGroupAttack.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Sets a group to attack a position
*/
params [["_groupID",grpNull,[grpNull]],["_position",[],[[]]],["_triggered",false,[false]]];

if (isNull _groupID) exitWith { /*["SetGroupAttack: Null Group ID"] call BIS_fnc_error;*/ false; };
if !(_position isEqualTypeArray [0,0,0]) exitWith { /*["Position Error %1",_position] call BIS_fnc_error;*/ };

if (_triggered) then {
	private _attackArray = missionNamespace getVariable ["MPSF_CheckAttack_Array",[]];
	_attackArray pushBack [_groupID,_position];
	missionNamespace setVariable ["MPSF_CheckAttack_Array",_attackArray];

	["MPSF_CheckAttack_onEachFrame_EH","onEachFrame",{
		if !(diag_frameno % 50 == 0) exitWith {};

		private _attackCheck = missionNamespace getVariable ["MPSF_CheckAttack_Array",[]];
		if (count _attackCheck == 0) then {
			["MPSF_CheckAttack_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
		};

		{
			_x params [["_groupID",grpNull,[grpNull]],["_position",[0,0,0],[[]]]];
			if ({_x distance2D _position < 40} count allPlayers > 0) then {
				_attackCheck set [_forEachIndex,[]];
				{ _x forceSpeed -1; } forEach (units _groupID);
				_groupID setBehaviour "AWARE";
				_groupID setCombatMode "RED";
				private _wayPoint = _groupID addWaypoint [_position, 20];
				_wayPoint setWaypointType "SAD";

			};
		} forEach _attackCheck;
		missionNamespace setVariable ["MPSF_CheckAttack_Array",(_attackCheck select { count _x > 0 })];
	}] call MPSF_fnc_addEventHandler;

} else {
	{ _x forceSpeed -1; } forEach (units _groupID);
	_groupID setBehaviour "AWARE";
	_groupID setCombatMode "RED";
	private _wayPoint = _groupID addWaypoint [_position, 20];
	_wayPoint setWaypointType "SAD";
};
