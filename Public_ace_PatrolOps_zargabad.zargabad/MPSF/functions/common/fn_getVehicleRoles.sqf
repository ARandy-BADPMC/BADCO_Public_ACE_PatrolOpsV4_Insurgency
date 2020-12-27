/*
	Author: Karel Moricky
	Modified: EightSix

	Description:
	Returns vehicle roles

	Parameter(s):
		0: OBJECT or STRING

	Returns:
	ARRAY of ARRAYS in format [role,index],e.g. [["Driver",[]],["Turret",[0,1]],["Cargo",[0]]]
*/

params [["_vehicle",objNull,[objNull]],["_ffv",false,[false]]];
if (typename _vehicle == typename objnull) then {_vehicle = typeof _vehicle;};

private _cfgVehicle = configfile >> "cfgvehicles" >> _vehicle;
private _roles = [];

//--- Driver
if (getnumber (_cfgVehicle >> "hasdriver") > 0) then {
	_roles pushBack ["Driver",[]];
};

//--- Turrets
{
	_x params ["_path","_ffvPos"];
	_roles pushBack [
		if (_ffvPos) then {"Turret_FFV"} else {"Turret"}
		,_path
	];
} foreach ([_vehicle,[]] call MPSF_fnc_getturrets);

//--- Cargo
for "_t" from 0 to (getnumber (_cfgVehicle >> "transportsoldier") - 1) do {
	_roles pushBack ["Cargo",[_t]];
};

if !(_ffv) then {
	_roles = _roles select { ((_x select 0) find "FFV") < 0 };
};

_roles