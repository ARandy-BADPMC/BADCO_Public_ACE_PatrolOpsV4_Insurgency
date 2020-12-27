/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_isTaskComplete.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns true if a task is complete
*/
params [["_taskID","",[""]],["_return",false,[false]]];

if ([_taskID] call BIS_fnc_taskExists) then {
	[_taskID] call BIS_fnc_taskCompleted;
} else {
	_return
};