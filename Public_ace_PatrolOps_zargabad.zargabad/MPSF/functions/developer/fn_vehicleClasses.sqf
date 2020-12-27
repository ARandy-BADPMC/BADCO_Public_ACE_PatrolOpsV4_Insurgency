/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_vehicleClasses.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Describe your function

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
private _factions = [];
private _factionIDs = [];
{
	_factionIDs pushBack configName _x;
	_factions pushBackUnique [
		configName _x
		,getNumber(_x >> "side")
		,getText(_x >> "displayName")
		,getText(_x >> "flag")
		,getText(_x >> "icon")
	];
} forEach ("isClass _x && getNumber(_x >> 'side') IN [0,1,2,3]" configClasses (configFile >> "CfgFactionClasses"));

private _units = [];
{
	_units pushBack [
		getNumber(_x >> "Side")
		,getText(_x >> "faction")
		,configName _x
	];
} forEach ("isClass _x && getNumber(_x >> 'scope') == 2" configClasses (configFile >> "CfgVehicles"));

private _factionData = [];
{
	private _factionID = _x;
	private _factionUnits = [];
	private _factionVehicles = [];
	{
		if ((_x select 1) isEqualTo _factionID) then {
			switch (true) do {
				case ((_x select 2) isKindOf "CaManBase") : {_factionUnits pushBack (_x select 2);};
				case ((_x select 2) isKindOf "Car");
				case ((_x select 2) isKindOf "Tank");
				case ((_x select 2) isKindOf "Air");
				case ((_x select 2) isKindOf "Ship") : {
					_factionVehicles pushBack (_x select 2);
				};
			};
		};
	} forEach _units;
	_factionData pushBack ((_factions select _forEachIndex) + [_factionUnits] + [_factionVehicles]);
} forEach _factionIDs;

//copyToClipboard str _factionData;

private _br = tostring [13,10];
private _tab = tostring [9];
private _tab2 = _tab + _tab;
private _tab3 = _tab + _tab2;
private _tab4 = _tab + _tab3;
private _tab5 = _tab + _tab4;
private _tab6 = _tab + _tab5;
private _tab7 = _tab + _tab6;

private _export = "/*" + _br;
_export = _export + _tab + "CfgSideGenerator" + _br;
_export = _export + _tab + "Contributor: " + (profileName) + _br;
_export = _export + "*/" + _br + _br;

// Export Data - Begin Compile
_export = _export + format ["class CfgMissionSides {",worldName] + _br;
for "_factionIndex" from 0 to (count _factionData - 1) do {
	(_factionData select _factionIndex) params ["_factionID","_factionSide","_factionName","_factionFlag","_factionIcon","_groupTypes","_vehicleTypes"];

	private _factionColour = ["ColorOpfor","ColorBlufor","ColorIndependent","ColorCivilian"] select _factionSide;

	_export = _export + _tab + format ["class %1 {",_factionID] + _br;
	_export = _export + _tab2 + format ["displayName = %1;",str _factionName] + _br;
	_export = _export + _tab2 + format ["displayLongName = %1;",str _factionName] + _br;
	_export = _export + _tab2 + format ["displayColour = %1;",str _factionColour] + _br;
	_export = _export + _tab2 + format ["side = %1;",_factionSide] + _br;

	_export = _export + _tab2 + "units[] = {" + _br;
	{
	_export = _export + _tab3 + format ["%1%2",if(_forEachIndex == 0) then {""} else {","},str _x] + _br;
	} forEach _groupTypes;
	_export = _export + _tab2 + "};" + _br;

	_export = _export + _tab2 + "vehicles[] = {" + _br;
	{
	_export = _export + _tab3 + format ["%1%2",if(_forEachIndex == 0) then {""} else {","},str _x] + _br;
	} forEach _vehicleTypes;
	_export = _export + _tab2 + "};" + _br;
	_export = _export + _tab + "};" + _br;
};
_export = _export + "};" + _br;

copyToClipboard str _export;
