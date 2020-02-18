/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_isUnitSpeaking.sqf
	Author(s): see mpsf\credits.txt
	Credits: ACE3, ACRE and TFAR

	Description:
		Check if a player is speaking with a key press

	Parameter(s):
		0: Object - Unit to check

	Returns:
		Bool - True when speaking
*/
params [["_unit",objNull,[objNull]]];

(_unit getVariable ["BIS_VON_var_isSpeaking",false])
// TFAR Support
|| (_unit getVariable ["tf_isSpeaking",false])
// ACRE Support
|| ([_unit] call (missionNamespace getVariable ["acre_api_fnc_isSpeaking",{false}]))
|| ([_unit] call (missionNamespace getVariable ["acre_api_fnc_isBroadcasting",{false}]))