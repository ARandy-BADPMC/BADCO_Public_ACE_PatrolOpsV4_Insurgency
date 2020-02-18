/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_onKilledDropIntel.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Adds a killed event handler that the server will process in the event a unit(s) is killed and drops intel.

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [["_units",[],[objNull,[]]],["_attributes",[],[[]]]];

["onKilledDropIntel",[_units,_attributes]] call MPSF_fnc_intel;