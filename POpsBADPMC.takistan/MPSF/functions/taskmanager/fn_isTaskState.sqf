/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_isTaskState.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Checks if a task has a specific state
*/
params [["_taskID","",[""]],["_state","",[""]],["_return",false,[false]]];

if !([_taskID] call BIS_fnc_taskExists) exitWith {
	_return
};

if (_state isEqualTo "") then {
	[_taskID] call BIS_fnc_taskCompleted;
} else {
	toLower([_taskID] call BIS_fnc_taskState) isEqualTo toLower _state
};
