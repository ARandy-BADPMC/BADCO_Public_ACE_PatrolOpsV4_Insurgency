/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createPatrol.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creats a group that then patrols around
*/
params [["_position",[0,0,0],[[]]],["_radius",0,[0]],["_faction",sideUnknown,[sideUnknown,""]],["_classNames",[],[[],""]]];

private _spawnGroup = [_position,_faction,_classNames] call MPSF_fnc_createGroup;

if (isNull _spawnGroup || count units _spawnGroup == 0) exitWith {grpNull};

[_spawnGroup,_position,_radius] spawn MPSF_fnc_setGroupPatrol;

_spawnGroup;