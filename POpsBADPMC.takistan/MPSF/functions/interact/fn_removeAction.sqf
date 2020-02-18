/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_removeAction.sqf
	Author(s): see mpsf\credits.txt

	Description:
		This function removes action to an object

	Parameter(s):
		0: STRING	- Unique Action ID to track
		1: OBJECT	- Remove the camera once finished and return to player view

	Returns:
		BOOLEAN
*/

params [
	["_actionID","",[""]]
	,["_object",objNull,[objNull]]
];

["onRemoveAction",[_actionID,_object],0] call MPSF_fnc_triggerEventHandler;