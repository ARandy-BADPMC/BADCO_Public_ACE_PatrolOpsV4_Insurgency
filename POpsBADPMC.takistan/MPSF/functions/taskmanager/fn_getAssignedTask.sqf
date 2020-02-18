/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getAssignedTask.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Returns the units assigned task
*/
params [["_unit",objNull,[objNull]]];

if !(isNull _unit) then {
	[_unit] call BIS_fnc_taskCurrent;
} else {
	"";
};