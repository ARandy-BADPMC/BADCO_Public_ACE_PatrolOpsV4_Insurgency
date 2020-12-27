/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_isWeaponRaised.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Check if a unit weapon is raised

	Parameter(s):
		0: Object - Unit to Check

	Returns:
		Bool - True when weapon raised
*/
params [["_unit",objNull,[objNull]]];

_weaponDir = _unit weaponDirection currentWeapon _unit;

(_weaponDir select 2) > -0.4