/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_isEventHandler.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Checks if an event exists

	Parameter(s):
		0: STRING - Event ID
		1: sTRING - Event  Type

	Returns:
		Bool - True when done
*/
params [["_id","",[""]],["_event","",[""]]];

(missionNamespace getVariable [format ["%1%2",_id,_event],-1]) >= 0;