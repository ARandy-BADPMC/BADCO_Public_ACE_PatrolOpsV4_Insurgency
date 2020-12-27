/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getConfigLoadout.sqf
	Author(s): see mpsf\credits.txt

	Description:
		REDUNDANT
*/
params [["_loadoutID","",[""]],["_isMissionConfig",false,[true]]];

private _cfgLoadout = configNull;
{
	if (isClass (_x >> _loadoutID)) exitWith {
		_cfgLoadout = _x >> _loadoutID;
	};
} forEach [missionConfigFile >> "CfgRespawnInventory",configFile >> "CfgVehicles"];

if (isNull _cfgLoadout) exitWith { [] };

private _data = [];
private _uniformClass = switch (true) do {
	case (isText(_cfgLoadout >> "uniform")) : { getText(_cfgLoadout >> "uniform"); };
	case (isText(_cfgLoadout >> "uniformClass")) : { getText(_cfgLoadout >> "uniformClass"); };
	case (isArray(_cfgLoadout >> "uniforms")) : { selectRandom getArray(_cfgLoadout >> "uniforms"); };
	case (isArray(_cfgLoadout >> "uniformClasses")) : { selectRandom getArray(_cfgLoadout >> "uniformClasses"); };
	default {""};
};

private _vestClass = "";
private _backpackClass = getText(_cfgLoadout >> "backpack");
private _headgearClass = "";
private _gogglesClass = "";
private _binocularClass = "";
private _linkedItems = [];
{
	private _type = getnumber (configfile >> "cfgweapons" >> _x >> "iteminfo" >> "type");
	if (isclass(configfile >> "cfgglasses" >> _x)) then {
		_gogglesClass = _x;
	};
	switch (_type) do {
		case 701 : { _vestClass = _x; };
		case 605 : { _headgearClass = _x; };
		default { _linkedItems pushBack _x; };
	};
} forEach getArray(_cfgLoadout >> "linkedItems");

private _primaryWeaponClass = "";
private _secondaryWeaponClass = "";
private _handgunWeaponClass = "";
{
	private _type = getnumber (configfile >> "cfgweapons" >> _x >> "type");
	switch (_type) do {
		case 1 : { _primaryWeaponClass = _x; };
		case 2 : { _handgunWeaponClass = _x; };
		case 4 : { _secondaryWeaponClass = _x; };
	};
} forEach getArray(_cfgLoadout >> "weapons");

if !(_uniformClass == "") then {
	_data set [0,[_uniformClass,[]]];
};
if !(_vestClass == "") then {
	_data set [1,[_vestClass,[]]];
};
if !(_backpackClass == "") then {
	_data set [2,[_backpackClass,[]]];
};
if !(_headgearClass == "") then {
	_data set [3,_headgearClass];
};
if !(_gogglesClass == "") then {
	_data set [4,_gogglesClass];
};
if !(_binocularClass == "") then {
	_data set [5,_binocularClass];
};
{
	_x params [["_weapon","",[""]],["_weaponAccessories",[],[[]]],["_weaponMagazines",[],[[]]]];
	if (_weapon != "") then {
		_data set [6 + _foreachindex,[_weapon,_weaponAccessories,_weaponMagazines]];
	};
} foreach [
	[_primaryWeaponClass,[],getArray(_cfgLoadout >> "magazines")],
	[_secondaryWeaponClass,[],[]],
	[_handgunWeaponClass,[],[]]
];
_data set [9,_linkedItems];
_data set [10,getArray(_cfgLoadout >> "items")];
_data set [11,getText(_cfgLoadout >> "insignia")];
_data set [12,getText(_cfgLoadout >> "face")];

_data;