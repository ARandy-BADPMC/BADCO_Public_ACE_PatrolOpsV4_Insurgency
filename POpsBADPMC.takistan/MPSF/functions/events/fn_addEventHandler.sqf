/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_addEventHandler.sqf
	Author(s): see mpsf\credits.txt

	Description:
		This function adds a new item that will be stacked and called upon event handler selected has been executed

	Parameter(s):
		0:	STRING		- The unique ID of the item inside the stack
		1:	STRING		- The onXxx event handler to monitor and execute code upon
		2:	STRING or CODE	- The function name or code to execute upon the event triggering

	Returns:
		STRING - The stacked item ID
*/
params [
	["_id","",[""]]
	,["_event","",[""]]
	,["_code",{},[{}, ""]]
];

if ([_id,_event] call MPSF_fnc_isEventHandler) then { [_id,_event] call MPSF_fnc_removeEventHandler; };

private _handlerID = [missionNamespace,_event,_code] call BIS_fnc_addScriptedEventHandler;
missionNamespace setVariable [format ["%1%2",_id,_event],_handlerID];

_id;