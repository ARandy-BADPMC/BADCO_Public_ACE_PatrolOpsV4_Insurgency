/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createIntelBeacon.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creates a 3D Marker
*/
params [
	["_position",[0,0,0],[[],objNull,""]]
	,["_displayText","",[""]]
	,["_displayIcon","",[""]]
];

["addIntelBeacon",[_position,_displayText,_displayIcon]] call MPSF_fnc_intel;