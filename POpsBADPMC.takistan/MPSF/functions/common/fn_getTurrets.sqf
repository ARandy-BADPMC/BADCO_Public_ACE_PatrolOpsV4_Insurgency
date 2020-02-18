/*
	Author:
		Karel Moricky, optimised by Killzone_Kid

	Description:
		Return vehicle turrets

	Parameter(s):
		0: OBJECT or STRING (classname)
		1: CONFIG or ARRAY - output type (array of config paths or IDs)

	Returns:
		ARRAY of CONFIGs or ARRAYs
*/

params [["_veh", -1]];

if (_veh isEqualType objNull) then {_veh = typeOf _veh};

private _vehConfig = configFile >> "CfgVehicles" >> _veh;

private _vehTurretsPath = [];
private _path = [];

private _fnc_getTurretsPath = {
	private _index = 0;
	{
		_path append [_index];
		_vehTurretsPath pushBack +[_path,getNumber(_x >> "isPersonTurret") > 0];
		_index = _index + 1;
		if (isClass (_x >> "Turrets")) then {
			_x call _fnc_getTurretsPath;
			_path deleteAt (count _path - 1);
		};
	} forEach ("true" configClasses (_this >> "Turrets"));
};

_vehConfig call _fnc_getTurretsPath;

_vehTurretsPath