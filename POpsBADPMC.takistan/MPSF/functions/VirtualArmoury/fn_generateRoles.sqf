private _typeWeapons = ["AssaultRifle","MachineGun","SniperRifle","Shotgun","Rifle","SubmachineGun","Launcher","MissileLauncher","RocketLauncher","Handgun"];
private _typeItems = ["Map","GPS","UAVTerminal","Radio","Compass","Watch","Glasses","NVGoggles","Binocular","LaserDesignator","AccessoryMuzzle","AccessorySights","AccessoryPointer","AccessoryBipod"];
private _typeGear = ["Headgear","Uniform","Vest"];
private _typeBackpacks = ["Backpack"];

private _allWeapons = [];
private _allItems = [];
private _allGear = [];
private _allBackpacks = [];

{
	private _class = _x;
	private _className = configname _x;
	private _scope = (getnumber (_class >> "scopeArsenal")) max (getnumber (_class >> "scope"));
	private _isBase = if (isarray (_x >> "muzzles")) then {(_className call BIS_fnc_baseWeapon == _className)} else {true};
	if (_scope == 2 && {gettext (_class >> "model") != ""} && _isBase) then {
		private _weaponType = (_className call BIS_fnc_itemType);
		private _weaponTypeCategory = _weaponType select 0;
		if (_weaponTypeCategory != "VehicleWeapon") then {
			private _weaponTypeSpecific = _weaponType select 1;
			switch (true) do {
				case (_weaponTypeSpecific in _typeWeapons) : {
					_allWeapons pushBackUnique [_weaponTypeSpecific,_className];
				};
				case (_weaponTypeSpecific in _typeItems) : {
					_allItems pushBackUnique [_weaponTypeSpecific,_className];
				};
				case (_weaponTypeSpecific in _typeGear) : {
					_allGear pushBackUnique [_weaponTypeSpecific,_className];
				};
				case (_weaponTypeSpecific in _typeBackpacks) : {
					_allBackpacks pushBackUnique [_weaponTypeSpecific,_className];
				};
			};
		};
	};
} foreach (
	("isClass _x" configClasses (configFile >> "cfgWeapons")) +
	("isClass _x" configClasses (configFile >> "cfgVehicles")) +
	("isClass _x" configClasses (configFile >> "cfgGlasses"))
);

_allWeapons sort true;
_allItems sort true;
_allGear sort true;
_allBackpacks sort true;

private _return = [];
{
	private _cfg = _x;
	private _className = tolower configName _x;
	private _sideID = getNumber (_cfg >> "side");
	private _faction = getText (_cfg >> "faction");
	private _role = switch (true) do {
		case !(_className find "_sl_" < 0);
		case !(_className find "_tl_" < 0) : {
			"Squad Leader"
		};
		case !(_className find "_medic_" < 0) : {
			"Medic"
		};
		case !(_className find "_gl_" < 0) : {
			"Grenadier"
		};
		case !(_className find "_lat_" < 0);
		case !(_className find "_aa_" < 0);
		case !(_className find "_at_" < 0) : {
			"Missile Specialist"
		};
		case !(_className find "_heavygunner_" < 0);
		case !(_className find "_mg_" < 0);
		case !(_className find "_ar_" < 0) : {
			"Auto Rifleman"
		};
		case !(_className find "sharphooter" < 0);
		case !(_className find "sharpshooter" < 0);
		case !(_className find "_m_" < 0) : {
			"Marksman"
		};
		case !(_className find "_exp_" < 0) : {
			"Explosive Specialist"
		};
		case !(_className find "_repair_" < 0);
		case !(_className find "_engineer_" < 0) : {
			"Engineer"
		};
		case !(_className find "_diver_" < 0) : {
			"Diver"
		};
		case !(_className find "heli" < 0);
		case !(_className find "pilot" < 0) : {
			"Pilot"
		};

		case !(_className find "sniper" < 0);
		case !(_className find "spotter" < 0);
		case !(_className find "_ghillie_" < 0) : {
			"Sniper"
		};
		case !(_className find "recon" < 0) : {
			"Recon"
		};
		default {"Rifleman"};
	};

	private _loadout = getUnitLoadout _x;

	_loadout params ["_primaryArray","_secondaryArray","_handgunArray","_uniformArray","_vestArray","_backpackArray","_headgear","_glasses","_binocularArray","_itemsArray"];

	_primaryWeapon = (_primaryArray param [0,""]) call BIS_fnc_baseWeapon;
	_secondaryWeapon = (_secondaryArray param [0,""]) call BIS_fnc_baseWeapon;
	_handweapon = (_handgunArray param [0,""]) call BIS_fnc_baseWeapon;

	_uniform = _uniformArray param [0,""];
	_vest = _vestArray param [0,""];
	_backpack = _backpackArray param [0,""];

	_return pushBack ([
			_className
			,_role + "_" + _faction
			,_sideID
			,_role
			,_primaryWeapon
			,_secondaryWeapon
			,_handweapon
			,_uniform
			,_vest
			,_backpack call BIS_fnc_baseVehicle
			,_headgear
		]);
} forEach ("isClass _x && configName _x isKindOf 'CaManBase' && getNumber (_x >> 'scope') == 2 && getNumber (_x >> 'side') in [1] && getText (_x >> 'faction') in ['BLU_F','BLU_T_F','BLU_CTRG_F']" configClasses (configFile >> "CfgVehicles"));

private _roles = [
	["Default","Default",-1,_allWeapons apply {_x select 1},_allGear apply {_x select 1},_allItems apply {_x select 1},_allBackpacks apply {_x select 1}]
];

{
	_x params ["_className","_roleID","_sideID","_role","_primaryWeapon","_secondaryWeapon","_handweapon","_uniform","_vest","_backpack","_headgear"];

	private _index = (_roles apply {_x param [0,""]}) find (_role);
	if (_index < 0) then {
		_roles pushBack [
			_role
			,_role
			,_sideID
			,[_primaryWeapon,_secondaryWeapon,_handweapon] - [""]
			,[_uniform,_vest,_headgear] - [""]
			,[] - [""]
			,[_backpack] - [""]
			,[_className] - [""]
		];
	} else {
		_roleWeapons = (_roles select _index) select 3;
		_roleGear = (_roles select _index) select 4;
		_roleItems = (_roles select _index) select 5;
		_roleBackpacks = (_roles select _index) select 6;
		_roleClassnames = (_roles select _index) select 7;
		{ _roleWeapons pushBackUnique _x; } forEach ([_primaryWeapon,_secondaryWeapon,_handweapon] - [""]);
		{ _roleGear pushBackUnique _x; } forEach ([_uniform,_vest,_headgear] - [""]);
		{ _roleBackpacks pushBackUnique _x; } forEach ([_backpack] - [""]);
		{ _roleClassnames pushBackUnique _x; } forEach ([_className] - [""]);
	};
} forEach _return;

private _br = tostring [13,10];
private _tab = tostring [9];
private _tab2 = _tab + _tab;
private _tab3 = _tab + _tab2;
private _tab4 = _tab + _tab3;
private _tab5 = _tab + _tab4;
private _tab6 = _tab + _tab5;
private _tab7 = _tab + _tab6;

private _export = "/*" + _br;
_export = _export + _tab + "CfgVirtualArmoury Roles Generator" + _br;
_export = _export + _tab + "Contributor: " + (profileName) + _br;
_export = _export + "*/" + _br + _br;

_export = _export + format ["class CfgRoles {"] + _br;
{
	_x params ["_roleID","_role","_sideID","_weaponArray","_gearArray","_itemsArray","_backpackArray","_roleClassnames"];
	_weaponArray sort true;
	_gearArray sort true;
	_roleClassnames sort true;

	_export = _export + _tab + format ["class %1 {",_roleID splitString " " joinString ""] + _br;
	//_export = _export + _tab2 + format ["side = %1",_sideID] + _br;
	_export = _export + _tab2 + format ["displayName = %1;",str _role] + _br;
	_export = _export + _tab2 + format ["icon = %1;",str ""] + _br;
	_export = _export + _tab2 + format ["limit = 0;"] + _br;
	_export = _export + _tab2 + format ["fullArmoury = 0;"] + _br;
	_export = _export + _tab2 + format ["traits[] = {%1,%2,%3,%4,%5,%6,%7};",str "Crewman",str "PilotHeli",str "PilotPlane",str "Medic",str "Engineer",str "ExplosiveSpecialist",str "HALO"] + _br;
	//_export = _export + _tab2 + format ["crewman = 0;"] + _br;
	//_export = _export + _tab2 + format ["pilotHeli = 0;"] + _br;
	//_export = _export + _tab2 + format ["pilotPlane = 0;"] + _br;
	//_export = _export + _tab2 + format ["medic = 0;"] + _br;
	//_export = _export + _tab2 + format ["engineer = 0;"] + _br;
	//_export = _export + _tab2 + format ["explosiveSpecialist = 0;"] + _br;
	//_export = _export + _tab2 + format ["HALO = 0;"] + _br;
	if (count (_weaponArray + _gearArray + _itemsArray + _backpackArray) > 0) then {
		_export = _export + _tab2 + "class Armoury {" + _br;
		if (count _weaponArray > 0) then {
			_export = _export + _tab3 + "weapons[] = {" + ((_weaponArray apply {str _x}) joinString ",") + "};" + _br;
		};
		if (count _gearArray > 0) then {
			_export = _export + _tab3 + "gear[] = {" + ((_gearArray apply {str _x}) joinString ",") + "};" + _br;
		};
		if (count _itemsArray > 0) then {
			_export = _export + _tab3 + "items[] = {" + ((_itemsArray apply {str _x}) joinString ",") + "};" + _br;
		};
		if (count _backpackArray > 0) then {
			_export = _export + _tab3 + "backpacks[] = {" + ((_backpackArray apply {str _x}) joinString ",") + "};" + _br;
		};
		if (count _roleClassnames > 0) then {
			_export = _export + _tab3 + "classNames[] = {" + ((_roleClassnames apply {str _x}) joinString ",") + "};" + _br;
		};
		_export = _export + _tab2 + "};" + _br;
	};
	_export = _export + _tab + "};" + _br;
} forEach _roles;
_export = _export + "};" + _br;

copyToClipboard _export;