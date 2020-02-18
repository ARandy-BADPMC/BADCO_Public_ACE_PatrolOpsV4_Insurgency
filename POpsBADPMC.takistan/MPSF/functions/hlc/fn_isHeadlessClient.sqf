/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_isHeadlessClient.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Checks if a player is a headless client

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when headless client
*/
params [["_object",objNull,[objNull]]];

typeOf _object isEqualTo "HeadlessClient_F" && isPlayer _object;