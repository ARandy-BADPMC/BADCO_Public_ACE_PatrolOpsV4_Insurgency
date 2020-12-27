/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setGroupID.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Set a group NAME

	Parameter(s):
		0: GROUP - Group
		1: STRING - Group Name

	Returns:
		Bool - True when done
*/
params [["_group",grpNull,[grpNull]],["_groupName","",[""]]];

if (_groupName isEqualTo "") exitWith {};

_group setGroupid _groupName;

true;