/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setUnitGear.sqf
	Author(s): see mpsf\credits.txt

	Description:
		REDUNDANT
*/
params [["_unit",player,[objNull]],["_loadout",[],[[],""]],["_clearGear",true,[false]]];

if (_loadout isEqualType "") then {
	_loadout = missionNamespace getVariable [format["MPSF_Loadout_%1",_loadout],([_loadout] call MPSF_fnc_getConfigLoadout)];
};

if (_clearGear) then {
	removeHeadgear _unit;
	removeGoggles _unit;
	removeAllAssignedItems _unit;
	removeAllItems _unit;
	removeAllWeapons _unit;
	removeBackpack _unit;
	removeVest _unit;
	removeUniform _unit;
};

if (count _loadout == 0) exitWith { false; };

_loadout params [
	["_uniformData",[],[[]]],
	["_vestData",[],[[]]],
	["_backpackData",[],[[]]],
	["_headgear","",[""]],
	["_goggles","",[""]],
	["_binoculars","",[""]],
	["_primaryWeaponData",[],[[]]],
	["_secondaryWeaponData",[],[[]]],
	["_handgunWeaponData",[],[[]]],
	["_assignedItems",[],[[]]],
	["_allItems",[],[[]]],
	["_insignia","",[""]],
	["_face","",[""]]
];

if (count _uniformData > 0) then {
	_uniformData params [["_uniform","",[""]],["_uniformItems",[],[[]]]];
	if !(_uniform == "") then {
		removeUniform _unit;
		_unit forceAddUniform _uniform;
		for "_i" from 0 to (count _uniformItems - 1) do {
			_item = _uniformItems select _i;
			if (_unit canAddItemToUniform _item) then {
				_unit addItemToUniform _item;
			} else {
				systemChat format ["%1 has fallen out of your gear",_item];
			};
		};
	};
};

if (count _vestData > 0) then {
	_vestData params [["_vest","",[""]],["_vestItems",[],[[]]]];
	if !(_vest == "") then {
		removeVest _unit;
		_unit addVest _vest;
		for "_i" from 0 to (count _vestItems - 1) do {
			_item = _vestItems select _i;
			if (_unit canAddItemToVest _item) then {
				_unit addItemToVest _item;
			} else {
				systemChat format ["%1 has fallen out of your gear",_item];
			};
		};
	};
};

if (count _backpackData > 0) then {
	_backpackData params [["_backpack","",[""]],["_backpackItems",[],[[]]]];
	if !(_backpack == "") then {
		removeBackpack _unit;
		_unit addBackpack _backpack;
		for "_i" from 0 to (count _backpackItems - 1) do {
			_item = _backpackItems select _i;
			if (_unit canAddItemToBackpack _item) then {
				_unit addItemToBackpack _item;
			} else {
				systemChat format ["%1 has fallen out of your gear",_item];
			};
		};
	};
};

if !(_headgear == "") then { _unit addHeadgear _headgear; };
if !(_goggles == "") then { _unit addGoggles _goggles; };
if !(_binoculars == "") then { _unit addWeapon _binoculars; };

if (count _primaryWeaponData > 0) then {
	_primaryWeaponData params [["_weapon","",[""]],["_weaponAccessories",[],[[]]],["_weaponMagazines",[],[[]]]];
	if !(_weapon == "") then {
		{ _unit addMagazine _x; } forEach _weaponMagazines;
		_unit addWeapon _weapon;
		{ _unit addPrimaryWeaponItem _x; } forEach _weaponAccessories;
	};
};
if (count _secondaryWeaponData > 0) then {
	_secondaryWeaponData params [["_weapon","",[""]],["_weaponAccessories",[],[[]]],["_weaponMagazines",[],[[]]]];
	if !(_weapon == "") then {
		{ _unit addMagazine _x; } forEach _weaponMagazines;
		_unit addWeapon _weapon;
		{ _unit addSecondaryWeaponItem _x; } forEach _weaponAccessories;
	};
};
if (count _handgunWeaponData > 0) then {
	_handgunWeaponData params [["_weapon","",[""]],["_weaponAccessories",[],[[]]],["_weaponMagazines",[],[[]]]];
	if !(_weapon == "") then {
		{ _unit addMagazine _x; } forEach _weaponMagazines;
		_unit addWeapon _weapon;
		{ _unit addHandgunItem _x; } forEach _weaponAccessories;
	};
};

if (count _assignedItems > 0) then {
	{
		_unit linkItem _x;
		_unit addPrimaryWeaponItem _x;
		_unit addSecondaryWeaponItem _x;
		_unit addHandgunItem _x;
	} forEach _assignedItems;
};

if (count _allItems > 0) then {
	{
		_unit addItem _x;
	} forEach _allItems;
};

if !(_insignia == "") then {
	[_unit,_insignia] call BIS_fnc_setUnitInsignia;
};

if !(_face == "") then {
	_unit setFace _face;
};

true;