/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_removeEventHandler.sqf
	Author(s): see mpsf\credits.txt

	Description:
		This function removes an item that is stacked in some event

	Parameter(s):
		0:	STRING	- The unique ID of the item inside the stack
		1:	STRING	- The onXxx event handler

	Returns:
		BOOL - TRUE if successfully removed, FALSE if not
*/
params [["_id","",[""]],["_event","",[""]]];

private _handlerID = missionNamespace getVariable [format ["%1%2",_id,_event],-1];
missionNamespace setVariable [format ["%1%2",_id,_event],nil];

[missionNamespace,_event,_handlerID] call BIS_fnc_removeScriptedEventHandler;