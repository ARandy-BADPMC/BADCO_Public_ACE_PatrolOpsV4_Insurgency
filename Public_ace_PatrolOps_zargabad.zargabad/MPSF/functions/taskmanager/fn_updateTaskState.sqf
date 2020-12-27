/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_updateTaskState.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Updates the task status

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [["_taskID","",[""]],["_state","",[0,"",false]],["_hint",false,[false]]];

[_taskID,nil,nil,nil,_state,nil,_hint] call BIS_fnc_setTask;