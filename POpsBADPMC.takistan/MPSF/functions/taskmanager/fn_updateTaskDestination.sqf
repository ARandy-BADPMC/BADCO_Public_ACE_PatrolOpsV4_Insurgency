/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_updateTaskDestination.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Updates the position of the task
*/
params [["_taskID","",[""]],["_destination",[0,0,0],[[],objNull,""]]];

if (typeName _destination == typeName "") then { _destination = getMarkerPos _destination; };

[_taskID,nil,nil,_destination] call BIS_fnc_setTask;