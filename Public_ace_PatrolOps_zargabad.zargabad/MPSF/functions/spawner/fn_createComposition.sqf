/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createComposition.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Create a group of units at a position

	Parameter(s):
			1: <ARRAY> - Position [x,y,(z)]
			2: <NUMBER> - Angle of Composition
			3: <STRING/ARRAY> - Composition Name or array of objects
			4: <BOOL> - Set Multiplayer Simulation (false is good for bandwidth)

	Returns:
		<ARRAY OF OBJECTS>

	Example:
		["helipad_0",screenToWorld [0.5,0.5],direction player] call MPSF_fnc_createComposition;
*/
params [["_composition","",["",[]]],["_position",[0,0,0],[[]]],["_direction",random 360,[0]],["_simulate",false,[false]]];

["create3DENComposition",[_composition,_position,_direction]] call MPSF_fnc_create3DENComposition;