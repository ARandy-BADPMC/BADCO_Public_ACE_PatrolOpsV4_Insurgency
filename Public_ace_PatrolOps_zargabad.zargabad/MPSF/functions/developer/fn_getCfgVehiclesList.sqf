/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getCfgVehiclesList.sqf
	Author(s): see mpsf\credits.txt
*/
private _br = tostring [13,10];
private _return = [];
{
	private _vehicleID = _x;
	private _scope = (configFile >> "CfgVehicles" >> _vehicleID >> "scope") call BIS_fnc_getCfgDataBool;
	if (_scope) then {

		private _dlc = "ARMA 3";
		private _addons = configsourceaddonlist (configFile >> "CfgVehicles" >> _vehicleID);
		if (count _addons > 0) then {
			private _mods = configsourcemodlist (configfile >> "CfgPatches" >> _addons select 0);
			if (count _mods > 0) then {
				_dlc = format ["%1 %2",_dlc,toUpper (_mods select 0)];
			};
		};
		private _faction = (configFile >> "CfgVehicles" >> _vehicleID >> "faction") call BIS_fnc_getCfgData;
		_return pushBack [
			_dlc
			,(configFile >> "CfgVehicles" >> _vehicleID >> "scope") call BIS_fnc_getCfgData
			,(configFile >> "CfgVehicles" >> _vehicleID >> "simulation") call BIS_fnc_getCfgData
			,(configFile >> "CfgVehicles" >> _vehicleID >> "vehicleClass") call BIS_fnc_getCfgData
			,_faction
			,_vehicleID
			,(configfile >> "CfgFactionClasses" >> _faction >> "displayName") call BIS_fnc_getCfgData
			,(configFile >> "CfgVehicles" >> _vehicleID >> "displayName") call BIS_fnc_getCfgData
			,(configFile >> "CfgVehicles" >> _vehicleID >> "model") call BIS_fnc_getCfgData
		];
	};
} forEach ((configFile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses);

private _export = "dlc|scope|simulation|vehicleClass|factionID|className|faction|displayName|model" + _br;
{
	_export = _export + (_x joinString "|") + _br;
} forEach _return;

copyToClipboard _export;