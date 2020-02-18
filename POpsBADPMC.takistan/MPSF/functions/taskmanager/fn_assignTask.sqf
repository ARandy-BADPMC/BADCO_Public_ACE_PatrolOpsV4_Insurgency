/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_assignTask.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Assigns a task
*/
params [["_taskID","",[""]]];

[_taskID] call BIS_fnc_taskSetCurrent;