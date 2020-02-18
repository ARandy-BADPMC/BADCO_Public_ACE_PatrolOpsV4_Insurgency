/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getUnitTrait.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Gets a unit Trait

	Parameter(s):
		0: Object - Unit

	Returns:
		Bool - If the unit has the trait
*/
params [["_target",objNull,[objNull]],["_trait","",[""]]];

if (isNull _target || _trait isEqualTo "") exitWith { false };

_target getUnitTrait _trait;