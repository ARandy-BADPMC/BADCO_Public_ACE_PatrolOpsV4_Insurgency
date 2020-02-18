/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_isAdmin.sqf
	Author(s): see mpsf\credits.txt
	Credit: Mackenzieexd from TaskForce72 for UID filter

	Description:
		Validates player as Administrator based on UID Filter and Server Commands.
		Credit to

	Parameter(s):
		0: OBJECT - Player

	Returns:
		BOOL - True if administrator permissions
*/
params [["_player",player,[objNull]]];

if !(isPlayer _player) exitWith {false};

private _adminUIDs = ["CfgMissionFramework","AdminUIDs"] call MPSF_fnc_getCfgDataArray;

(serverCommandAvailable "#kick" && "_MP_CANKICK_" in _adminUIDs) || (getPlayerUID _player IN _adminUIDs)