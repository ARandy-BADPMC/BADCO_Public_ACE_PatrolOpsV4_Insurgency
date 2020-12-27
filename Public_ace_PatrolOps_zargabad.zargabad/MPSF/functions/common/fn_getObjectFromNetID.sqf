/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getObjectFromNetID.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Gets an Object or group from a netID

	Parameter(s):
		0: STRING - Object ID
		1: OBJECT/GROUP - Default to be returned

	Returns:
		OBJECT or GROUP
*/
params [["_id","",[""]],["_default",objNull,[objNull,grpNull]]];

private _return = _id call BIS_fnc_groupFromNetId;
if !(isNull _return) exitWith {_return};

_return = _id call BIS_fnc_objectFromNetId;
if !(isNull _return) exitWith {_return};

_default;