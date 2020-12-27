/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_destroyCtrl.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Destorys a created display control

	Parameter(s):
		0: STRING - Control Group

	Returns:
		Bool - True when done
*/
params [["_displayCtrl","",[""]]];

{
	ctrlDelete _x;
} forEach (uiNamespace getVariable [_displayCtrl,[]]);

true;