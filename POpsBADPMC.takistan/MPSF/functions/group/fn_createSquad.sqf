/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createGroup.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Create a group for  aside

	Parameter(s):
		0: SIDE - A side
		1: BOOL - Register the group in Squad Mod

	Returns:
		Group
*/
params [["_side",sideUnknown,[sideUnknown]],["_register",true,[false]]];

if (_side isEqualTo sideUnknown) exitWith {};

private _groupID = ["create",[_side,_register]] call MPSF_fnc_group;
if (isNull _groupID) exitWith { /*["Failed to create group for side: %1",_side] call BIS_fnc_error;*/ grpNull };

_groupID;