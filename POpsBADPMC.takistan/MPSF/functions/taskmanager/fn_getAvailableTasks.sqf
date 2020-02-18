/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getAvailableTasks.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns all tasks for that unit
*/
params [["_unit",objNull,[objNull]]];

if !(isNull _unit) then {
	[_unit] call BIS_fnc_tasksUnit;
} else {
	[];
};