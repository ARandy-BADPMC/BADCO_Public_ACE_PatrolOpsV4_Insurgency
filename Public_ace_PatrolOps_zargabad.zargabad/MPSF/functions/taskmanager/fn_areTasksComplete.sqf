/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_areTasksComplete.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Checks if tasks are complete
*/
params [["_taskIDs","",["",[]]]];

if !(_taskIDs == typeName []) then {
	_taskIDs = [_taskIDs];
};

count (_taskIDs select {[_x] call MPSF_fnc_isTaskComplete}) == count _taskIDs