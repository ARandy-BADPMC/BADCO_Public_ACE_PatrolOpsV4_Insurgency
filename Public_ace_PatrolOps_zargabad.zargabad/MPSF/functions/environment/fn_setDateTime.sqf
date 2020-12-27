/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setDateTime.sqf
	Author(s): see mpsf\credits.txt

	Description:
		This function updates the misison date time

	Parameter(s):
		0: NUMBER/ARRAY		- Skip Hours or Date Array
		1: BOOL				- Players will see a transition effect

	Returns:
		BOOL
*/
params [["_dateTime",0,[0,[]]],["_instant",true,[false]]];

["setDatetime",[_dateTime,_instant]] spawn MPSF_fnc_environment;