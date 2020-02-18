/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getCfgComposition.sqf
	Author(s): see mpsf\credits.txt

	Description:
		(REDUNDANT) Get a object composition configuration

	Parameter(s):
		0: STRING - Composition ID

	Returns:
		ARRAY
*/
params [["_compositionID","",[""]]];

private _config = ["CfgMissionFramework","ObjectCompositions",_compositionID] call BIS_fnc_getCfgSubClasses;
private _compData = [];

if (count _config == 0) exitWith {
	//["Unable to find composition %1",_compositionID] call BIS_fnc_error;
	[];
};

for "_i" from 0 to (count _config - 1) do {
	private _className = _config select _i;
	private _objectData = [_className];
	{
		_objectData set [_forEachIndex + 1,(["CfgMissionFramework","ObjectCompositions",_compositionID,_className,_x] call BIS_fnc_getCfgData)];
	} forEach [
		"classname"
		,"position"
		,"orientation"
		,"simulate"
		,"fuel"
		,"damage"
		,"cargoFuel"
		,"cargoAmmo"
		,"cargoRepair"
	];
	_compData pushBack _objectData;
};

_compData;