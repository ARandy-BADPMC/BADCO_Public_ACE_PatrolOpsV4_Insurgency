/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_triggerEventHandler.sqf
	Author(s): see mpsf\credits.txt

	Description:
		This function triggers a event handler

	Parameter(s):
		0:	STRING		- Event Type
		1:	ARRAY		- Array of Arguments to pass
		2:	ANY			- Target to process the event

	Returns:
		BOOL
*/
params [["_event","",[""]],["_arguments",[],[[]]],["_target",0,[[],0,"",objNull,grpNull,sideUnknown,false]],["_return",false,[false]]];

// Override Target to local execution only
if !(isMultiplayer) then { _target = true; };

private _result = [false];
if (typeName _target isEqualTo typeName true) then {
	_result = [missionnamespace,_event,_arguments,_return] call BIS_fnc_callscriptedeventhandler;
} else {
	_result = [missionnamespace,_event,_arguments] remoteExec ["BIS_fnc_callscriptedeventhandler",_target,false];
};

if (count _result > 0) then { _result deleteAt (count _result - 1); } else {false};