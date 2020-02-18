/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_removeTask.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Removes a BIS task
*/
params [["_taskID","",[""]],["_targets",true,[true,sideunknown,grpNull,objnull,[]]]];

[_taskID,_targets] call BIS_fnc_deleteTask;